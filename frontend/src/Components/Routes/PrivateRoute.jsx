import React from 'react';
import { Route, Redirect} from 'react-router-dom'


// Function that redirects to Login page if no logged in staff is present.
// Path is provided as prop for further redirecting the user to the page he intented to visit
// in case of successful authorization.
export default function PrivateRoute ({component: Component, loggedInStaff, path, ...rest}) {
  const authed = loggedInStaff === undefined ? false : true;

  return (
    <Route {...rest} path={path} render={
      props => {
        if (authed) {
          return <Component {...rest} path={path} loggedInStaff = {loggedInStaff} {...props} />
        } else {
          return <Redirect to={
            {
              pathname: '/login',
              redirectToPath: path
            }
          } />
        }
      }
    } />
  )
  }