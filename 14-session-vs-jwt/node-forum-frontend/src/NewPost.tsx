import { BaseSyntheticEvent, useContext, useState } from "react"
import { UserContext } from "./App"

function NewPost({onPostSend}: {onPostSend: () => void}) {
    const [title, setTitle] = useState<string>()
    const [body, setBody] = useState<string>()
    const {user} = useContext(UserContext)
    function postMessage(e: BaseSyntheticEvent) {
        e.preventDefault()
        fetch('http://localhost:5050/posts', {
            method: 'POST',
            credentials: 'include',
            body: JSON.stringify({title, body, author: user?.id})
        })
            .then(res => {
                if (!res.ok) {
                    console.log('error', res)
                } else return res.json()
            })
            .then(() => {
                console.log('sent')
                onPostSend()
            })
    }
    return (
        <form onSubmit={postMessage}>
            <input type="text" name="title" placeholder="Otsikko" value={title} onChange={(e)=>setTitle(e.target.value)}/>
            <textarea name="body" placeholder="Viesti" value={body} onChange={(e) => setBody(e.target.value)}></textarea>
            <input type="submit" value="Lähetä" />
        </form>
    )
}

export default NewPost