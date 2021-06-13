import React, { useRef, useState } from 'react'
import { useHistory } from 'react-router-dom';

import * as url from '../../Constants/URLs';
import { Fetcher } from '../../API/Fetcher';
import { FormGroup } from 'react-bootstrap';


export default function Login({ setLoggedInStaff, location }) {
    const [authMessage, setAuthMessage] = useState('');
    const usernameInput = useRef(null);
    const passwordInput = useRef(null);

    const auth_fetcher = Fetcher(url.AUTH);

    const history = useHistory();

    async function authenticate(username, password) {
        const result = await auth_fetcher.exec({
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: { Username: username, Password: password }
            ,
        });


        if (result.Success) {
            if (typeof result.Table !== 'undefined' && result.Table.length > 0) {
                setAuthMessage('Successfully logged in!');
                setLoggedInStaff(result.Table[0]);
                
                if (location.redirectToPath !== undefined) {
                    history.push(location.redirectToPath);
                }
            }
            else {
                setAuthMessage('Wrong credentials!');
            }
        }
        else {
            setAuthMessage(result.ErrorMessage);
        }
    }

    return (
        <div>
            <div>
                <h1 >You must login to continue!</h1>
            </div>
            <div >
                <label htmlFor="name">Username</label>
                <input ref={usernameInput} type="text" id="name" />
            </div>
            <FormGroup>
                <label htmlFor="name">Password</label>
                <input ref={passwordInput} type="password" id="password" />
            </FormGroup>
            <div>
                <button style={{ marginTop: "1%", marginLeft: "1%" }} color="primary" onClick={() => { authenticate(usernameInput.current.value, passwordInput.current.value) }}>Login</button>{' '}
            </div>
            <div>
                <p >{authMessage}</p>
            </div>
        </div>
    )
};