import { useEffect, useState } from "react"
import { User } from "./Types"

function Users() {
    const [users, setUsers] = useState<User[]>([])

    useEffect(() => {
        fetch('http://localhost:5050/users', {
            credentials: 'include'
        })
        .then(res => {
            if (!res.ok) {
                console.log('error', res)
            } else return res.json()
        })
        .then(data => setUsers(data))
    }, [])

    return (
        <>
            <h2>Users</h2>
            <table>
                <thead>
                    <tr>
                        <th>Käyttäjänimi</th>
                        <th>Nimi</th>
                        <th>Rooli</th>
                        <th>Julkinen avain</th>
                    </tr>
                </thead>
                <tbody>
                    {users?.map(u => (
                        <tr key={u.id}>
                            <td>{u.username}</td>
                            <td>{u.realname}</td>
                            <td>{u.role}</td>
                            <td>{u.publickey ? ' ✔' : null}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}

export default Users