import { useContext } from "react";
import { Link, Outlet } from "react-router-dom";
import { UserContext } from "./App";

function Root() {
    const {user} = useContext(UserContext)
    function logout() {
        fetch('http://localhost:5050/logout', {
          credentials: 'include',
        })
          .then((res) => {
            if (!res.ok) {
              console.log('error', res)
            } else {
              window.location.href = '/login'
            }
          })
      }
    return (
        <>
            <nav>
                {!user && <Link to="/login">Kirjaudu sisään</Link>}
                {user && <Link to="/posts">Foorumi</Link>}
                {user?.role === 'admin' && <Link to="/users">Käyttäjät</Link>}
                <span>{user?.realname}</span>
                { user && <button onClick={logout}>Kirjaudu ules</button>}
                
            </nav>
            <Outlet/>
        </>
    )
}

export default Root