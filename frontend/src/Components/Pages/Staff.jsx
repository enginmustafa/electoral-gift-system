import React, { useState, useEffect } from 'react';
import { Fetcher } from '../../API/Fetcher';

import * as url from '../../Constants/URLs';

import {getProperDateFormat} from '../../Utils/DateUtils';

export default function Staff({ staffForElection, loggedInStaff, refetchStaffForElection }) {

  const staff_fetcher = Fetcher(url.CREATE_ELECTION)

  async function handleCreateElection(staffId, birthDate) {
    const result = await staff_fetcher.exec({
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: { CreateBy: loggedInStaff.StaffID, CreateFor: staffId, Birthdate: birthDate }
    });

    if (result.Success) {
      refetchStaffForElection(result.Table);
    }
  };


  const staffTable = staffForElection.map((member) => (
    <tr key={member.StaffID}>
      <td>{member.Name}</td>
      <td>{getProperDateFormat(member.Birthdate)}</td>
      <td>
        <button onClick={() => { handleCreateElection(member.StaffID, member.Birthdate) }}>Create Election</button>
      </td>
    </tr>
  ));

  return (
    <div className='container'>
      <h3>Staff</h3>
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Birthdate</th>
          </tr>
        </thead>
        <tbody>
          {staffTable}
        </tbody>
      </table>
    </div>
  )
};