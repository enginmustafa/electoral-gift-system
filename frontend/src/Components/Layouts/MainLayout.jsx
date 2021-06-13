import React from 'react';
import { Link } from 'react-router-dom';
import './style.css'

export default function MainLayout(props) {
    return (
        <div>
            <div style={{ display: 'inline-block' }}>
                <ul>
                    <li className='nav-component-container'>
                        <Link className='nav-component' to="/">Staff</Link>
                    </li>
                    <li className='nav-component-container'>
                        <Link className='nav-component' to="/elections">Elections</Link>
                    </li>
                </ul>
            </div>
            <div>
                {props.children}
            </div>
        </div>
    )
}