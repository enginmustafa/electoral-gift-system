import { BrowserRouter as Router, Route } from 'react-router-dom'
import { useEffect, useState } from 'react';

import PrivateRoute from './Components/Routes/PrivateRoute'

import MainLayout from './Components/Layouts/MainLayout';

import Elections from './Components/Pages/Elections';
import Staff from './Components/Pages/Staff';
import Login from './Components/Pages/Login';

import * as url from './Constants/URLs';

import './App.css';
import { Fetcher } from './API/Fetcher';

function App() {
  //preserving state on parent that multiple components will use
  //might implement a state management tool to centralize this 
  const [loggedInStaff, setLoggedInStaff] = useState(undefined);
  const [staffForElection, setStaffForElection] = useState([]);

  const staff_fetcher = Fetcher(url.STAFF)

  async function refetchStaffForElection() {
    const result = await staff_fetcher.exec({
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: loggedInStaff.StaffID
    });
  
    if (result.Success) {
      setStaffForElection(result.Table);
    }
  };

  //load staff on initial render
  useEffect(() => {
    if(loggedInStaff) {
      refetchStaffForElection();
    }
  }, [loggedInStaff]);


  return (
    <Router>
      <MainLayout>
        <PrivateRoute path={"/"} exact={true} loggedInStaff={loggedInStaff} staffForElection={staffForElection} refetchStaffForElection={refetchStaffForElection} component={Staff} />
        <PrivateRoute path={"/elections"} loggedInStaff={loggedInStaff} refetchStaffForElection={refetchStaffForElection} component={Elections} />
        <Route path={"/login"} render={(props) => <Login {...props} setLoggedInStaff={setLoggedInStaff} />} />
      </MainLayout>
    </Router>
  );
}

export default App;
