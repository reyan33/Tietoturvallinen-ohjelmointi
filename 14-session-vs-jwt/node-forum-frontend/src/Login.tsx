import { FormEvent, useContext, useState } from "react"
import { useNavigate } from "react-router-dom"
import { UserContext } from "./App"
import { User } from "./Types"

function Login() {
    const navigate = useNavigate()
    const [username, setUsername] = useState<string>('')
    const [password, setPassword] = useState<string>('')
    const {setUser} = useContext(UserContext);

    function login(e:FormEvent) {
        e.preventDefault()
        console.log('gonna login', username, password)
        fetch('http://localhost:5050/login', {
            method: 'POST',
            credentials: 'include',
            body: JSON.stringify({username, password})
        })
            .then(res => {
                if (!res.ok) {
                    console.log('error', res)
                } else return res.json() as Promise<User[]>
            })
            .then(data => {
                console.log('response', data)
                setUser(data ? data[0] : null)
                navigate('/posts')
            })
    }
    return (
        <>
            <h2>Login</h2>
            <form onSubmit={login} method="post">
                <input type="text" name="username" id="username" value={username} onChange={e => setUsername(e.currentTarget.value)} placeholder="Käyttäjänimi" />
                <input type="password" name="password" id="password" value={password} onChange={e => setPassword(e.currentTarget.value)} placeholder="Salasana" />
                <input type="submit" value="Kirjaudu" />
            </form>
        </>
    )
}

export default Login