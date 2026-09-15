import http from 'http';
import mysql from 'mysql';
import fs from 'fs/promises';
import bcrypt from 'bcrypt';
import crypto from 'crypto';

/** 
 * @typedef {Object} SessionData
 * @property {number} id The user's database id
 * @property {string} username The user's username
 * @property {string} realname The user's displayname
 * @property {string} role The user's role ('user', 'moderator' or 'admin')
 * @property {Date} expires The expiration date of the session
 */
/** 
 * @typedef {Object<string, SessionData>} Session
 */

/**
 * List of sessions
 * @type {Session[]}
 */
const sessions = {}

const serverHost = 'localhost'
const serverPort = 5050

const dbHost = "localhost"
const dbUser = "sql-user"
const dbPassword = "sql-user"
const db = "sql-inject"

const corsHeaders = {
    'Access-Control-Allow-Origin': 'http://localhost:5173', /* @dev First, read about security */
    'Access-Control-Allow-Methods': 'OPTIONS, POST, GET',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Max-Age': 2592000, // 30 days
  };

/**
 * 
 * @param {http.IncomingMessage} request 
 * @returns 
 */
function parseCookies(request) {
    const list = {};
    const cookieHeader = request.headers?.cookie;
    if (cookieHeader) {
        cookieHeader.split(';').forEach(cookie => {
            let [name, ...rest] = cookie.split('=');
            name = name?.trim();
            if (!name) return;
            const value = rest.join('=').trim();
            list[name] = decodeURIComponent(value);
        });
    }
    return list;
}

/**
 * 
 * @param {http.IncomingMessage} req Request object
 */
function verifySession(req) {
    const cookies = parseCookies(req)
    const sessionId = cookies.sessionId
    return (!!sessionId && sessionId in sessions)
}

/**
 * 
 * @param {http.IncomingMessage} req Request object
 * @param {string[]} roles List of accepted roles
 */
function verifyRole(req, roles) {
    const cookies = parseCookies(req)
    const sessionId = cookies.sessionId
    const session = sessions[sessionId]
    return roles.includes(session.role)
}

/**
 * 
 * @param {http.IncomingMessage} req Request object
 * @param {http.ServerResponse} res Server response
 */
function login(req, res) {
    const con = mysql.createConnection({
        host: dbHost,
        user: dbUser,
        password: dbPassword,
        database: db,
    });
    let body = ''
    req.on('data', chunk => {
        body += chunk
    })

    req.on('end', () => {
        const bodyParsed = JSON.parse(body)
        const username = bodyParsed.username
        const password = bodyParsed.password
        con.connect((err) => {
            if (err) throw err
            con.query('\
                SELECT * FROM users WHERE username = "' + username + '";', (err, result) => {
                    if (err) throw err
                    console.log('result', result)
                    if (result.length) {
                        const hash = result[0].password
                        // Voi kiesus mikä hack: bcrypt-moduuli ei tue $2y -etuliitettä
                        const fixedHash = hash[2] == 'y' ? hash.replace('y', 'a') : hash
                        bcrypt.compare(password, fixedHash, (err, same) => {
                            if (err) console.log('err', err)
                                console.log('valid', same)
                            if (same) {
                                // TODO: täällä luodaan sessio ja pistetään se httponly-keksiin
                                const sessionId = crypto.randomBytes(16).toString('hex')
                                const session = {
                                    id: result[0].id,
                                    username,
                                    realname: result[0].realname,
                                    role: result[0].role,
                                    expires: new Date(new Date().getTime() + 1000 * 60 * 60)
                                }
                                sessions[sessionId] = session
                                res.setHeader("Content-Type", "application/json")
                                res.setHeader('Set-Cookie', `sessionId=${sessionId}; HttpOnly; Secure; SameSite=Strict; Path=/`);
                                res.writeHead(200, corsHeaders)
                                res.end(JSON.stringify(result))
                            } else {
                                res.writeHead(401, corsHeaders)
                                res.end(JSON.stringify({message: 'Login vailure'}))
                            }
                        })}
                    con.end((err) => {
                        if (err) throw err
                        console.log('Disconnected', con.threadId)
                    })
                })
        })
    })
}

function logout(req, res) {
    const cookies = parseCookies(req)
    const sessionId = cookies.sessionId
    delete sessions[sessionId]
    res.setHeader('Set-Cookie', 'sessionId=; Max-Age=0; HttpOnly; Secure; Path=/');
    res.writeHead(204, corsHeaders);
    res.end();
}

/**
 * 
 * @param {http.IncomingMessage} req Request object
 * @param {http.ServerResponse} res Server response
 */
function getPosts(req, res) {
    const cookies = parseCookies(req)
    console.log('cookies', cookies)
    console.log('sessions', sessions)
    if (!verifySession(req)) {
        res.writeHead(401, corsHeaders)
        res.end('[]')
        return
    }
    const con = mysql.createConnection({
        host: dbHost,
        user: dbUser,
        password: dbPassword,
        database: db,
    });

    con.connect((err) => {
        if (err) throw err
        con.query('\
            SELECT posts.id, title, body, author, posted, signature, users.realname, users.publickey\
            FROM posts\
            INNER JOIN users\
            WHERE users.id = author\
            ORDER BY posted, id;', (err, result) => {
                if (err) throw err
                res.setHeader("Content-Type", "application/json");
                res.writeHead(200, corsHeaders);
                res.end(JSON.stringify(result));
                con.end(function (err) {
                    if (err) throw err;
                    console.log("Disconnected!", con.threadId);
                })
        })
    })
}

/**
 * 
 * @param {http.ServerResponse} req Request object
 * @param {http.ServerResponse} res Server response
 */
function postPost(req, res) {
    if (!verifySession(req)) {
        res.writeHead(401, corsHeaders)
        res.end('[]')
        return
    }
    let body = ''
    req.on('data', chunk => {
        body += chunk
    })

    req.on('end', () => {
        const bodyParsed = JSON.parse(body)
        const title = bodyParsed.title
        const postBody = bodyParsed.body
        const author = bodyParsed.author

    const con = mysql.createConnection({
        host: dbHost,
        user: dbUser,
        password: dbPassword,
        database: db,
    });
    con.connect((err) => {
        if (err) throw err
        con.query('\
            INSERT INTO posts (title, body, author)\
            VALUES ("'+title+'", "'+postBody+'", '+author+');', (err, result) => {
                if (err) throw err
                res.setHeader("Content-Type", "application/json");
                res.writeHead(200, corsHeaders);
                res.end(JSON.stringify(result));
                con.end(function (err) {
                    if (err) throw err;
                    console.log("Disconnected!", con.threadId);
                })
        })
    })
    })
}

/**
 * 
 * @param {http.ServerResponse} req Request object
 * @param {http.ServerResponse} res Server response
 */
function getUsers(req, res) {
    if (!verifySession(req) || !verifyRole(req, ['admin'])) {
        res.setHeader("Content-Type", "application/json");
        res.writeHead(401, corsHeaders)
        res.end('[]')
        return
    }
    const con = mysql.createConnection({
        host: dbHost,
        user: dbUser,
        password: dbPassword,
        database: db,
    });

    con.connect((err) => {
        if (err) throw err
        con.query('SELECT id, username, realname, role, publickey FROM users;', (err, result) => {
            if (err) throw err
            console.log(result)
            res.setHeader("Content-Type", "application/json");
            res.writeHead(200, corsHeaders);
            res.end(JSON.stringify(result));
            con.end(function (err) {
                if (err) throw err;
                console.log("Disconnected", con.threadId);
            })
        })
    })
}

/**
 * 
 * @param {http.IncomingMessage} req Incoming request
 * @param {http.ServerResponse} res Server response
 */
function routes(req, res) {
    console.log('got request', req.url)
    switch (req.url) {
        case "/":
            res.writeHead(200, corsHeaders);
            res.end('hellp from home');
            break
        case "/favicon.ico":
            const __dirname = process.cwd();
            fs.readFile(__dirname + '/favicon.ico').then(file=>{
                res.setHeader("Content-Type", "image/x-icon");
                res.writeHead(200);
                res.end(file);
            })
            break
        case "/posts":
            if (req.method==='GET') getPosts(req, res)
            else if (req.method==='POST') postPost(req, res)
            break
        case "/users":
            getUsers(req, res)
            break
        case "/login":
            login(req, res)
            break
        case "/logout":
            logout(req, res)
            break
        default:
            res.setHeader("Content-Type", "application/json");
            res.writeHead(404)
            res.end(JSON.stringify({
                title: "Not found",
                detail: "Viärä osote", 
                status: 404}))
            break
    }
}

http.createServer(routes).listen(serverPort, serverHost, () => {
    console.log('Server listening on', serverHost, 'port', serverPort)
})