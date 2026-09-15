import { createBrowserRouter, Navigate, RouterProvider } from 'react-router-dom'
import './App.css'
import Posts from './Posts'
import Login from './Login'
import Users from './Users'
import { createContext, useState } from 'react'
import { ProtectedRouteProps, User } from './Types'
import Root from './Root'

export const UserContext = createContext<{user: User | null, setUser: (user: User|null) => void}>({
  user: null,
  setUser: (user) => {return user}
})

function ProtectedRoute({ user, roles=['user', 'admin', 'moderator'], children }: ProtectedRouteProps) {
  if (!user || !(roles.includes(user.role))) {
    return <Navigate to={'/login'} replace />;
  }

  return children;
};

function App() {
  const [user, setUser] = useState<User|null>(null)
  const userValue ={user, setUser}

  const router = createBrowserRouter([
    {
      path: "/",
      element: <Root/>,
      children: [
        {
          path: "login",
          element: <Login/>,
        },
        {
          path: "posts",
          element: <ProtectedRoute user={user}><Posts/></ProtectedRoute>
        },
        {
          path: "users",
          element: <ProtectedRoute user={user} roles={['admin']}><Users/></ProtectedRoute>
        },
      ]
    }
  ])

  return (
    <>
        <UserContext.Provider value={userValue}>
          <RouterProvider router={router}/>
        </UserContext.Provider>
    </>
  )
}

export default App
