import { useEffect, useState } from "react"
import { Post } from "./Types"
import NewPost from "./NewPost"

function Posts() {
    const [posts, setPosts] = useState<Post[]>([])

    function getPosts() {
        fetch('http://localhost:5050/posts', {
            credentials: 'include',
        })
        .then(res => res.json())
        .then(data => setPosts(data))
    }

    useEffect(getPosts, [])

    return (
        <>
    <h2>Keskustelu</h2>
    {posts.map(p => (
        <div className="post" key={p.id}>
            <h3 className="title">{p.title}</h3>
            <p className="meta">{p.posted} – {p.realname}</p>
            <p className="body">{p.body}</p>
        <hr/>
        </div>
    ))}
    <NewPost onPostSend={getPosts}/>
    </>
    )
}

export default Posts