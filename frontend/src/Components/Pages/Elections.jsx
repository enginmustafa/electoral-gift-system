import React, { useEffect } from 'react';
import { useState } from 'react';
import { Fetcher } from '../../API/Fetcher';

import { getProperDateFormat } from '../../Utils/DateUtils';

import * as url from '../../Constants/URLs';



export default function Elections({ loggedInStaff, refetchStaffForElection }) {
    const [elections, setElections] = useState([]);

    const elections_fetcher = Fetcher(url.GET_ELECTIONS);
    const closeElection_fetcher = Fetcher(url.CLOSE_ELECTION);
    const electionResults_fetcher = Fetcher(url.GET_ELECTION_RESULTS);
    const electGift_fetcher = Fetcher(url.ELECT_GIFT);

    //filter out elections for current staff
    const filteredElections = () => {
        return elections.filter(election => election.StaffID !== loggedInStaff.StaffID);
    }

    async function fetchElections() {
        const result = await elections_fetcher.exec({
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            }
        });

        if (result.Success) {
            console.log(result.Table)
            setElections(result.Table);
        }
    };

    //fetch elections on initial render
    useEffect(() => {
        fetchElections();
    }, []);

    async function handleCloseElection(electionId) {
        const result = await closeElection_fetcher.exec({
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: { ElectionID: electionId }
        });

        if (result.Success) {
            fetchElections();

            //staff can only have one open election at a time
            refetchStaffForElection();
        }
    };

    async function handleViewElectionResults(electionId) {
        const result = await electionResults_fetcher.exec({
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: { ElectionID: electionId }
        });

        if (result.Success) {
            //implement visualization of election results
        }
    };


    const openElectionsTable = () =>
        filteredElections().map((election) => {
            return <tr hidden={election.Closed}
                key={election.ElectionID}>
                <td>{election.Name}</td>
                <td>{getProperDateFormat(election.Birthdate)}</td>
                <td>{election.CreatedForYear}</td>
                <td>
                    <button
                        hidden={(election.CreatedBy !== loggedInStaff) && election.Closed}
                        onClick={() => { handleCloseElection(election.ElectionID) }}>
                        Close Election</button>
                    {/* 
                        Must extend hidden property of the button below 
                        to hide when current staff already elected a gift for this election
                    */}
                    <button
                        hidden={election.Closed}>
                        Elect Gift</button>
                </td>
                <div id='elect-gift-container'>
                    {/* 
                   This container's visibility must be tirggered on the upper buttons click event trigger.
                   Some checkboxes with a submit button/combobox for each gift might be a good fit for the purpose.
                   After submit must rerender Elections component so that the button triggering this functionality 
                   be hidden to prevent tries for multiple elections.
                */}
                </div>
            </tr>
        }
        );

    const closedElectionsTable = () =>
        filteredElections().map((election) => {
            return <tr hidden={!election.Closed}
                key={election.ElectionID}>
                <td>{election.Name}</td>
                <td>{getProperDateFormat(election.Birthdate)}</td>
                <td>{election.CreatedForYear}</td>
                <td>
                    <button
                        hidden={!election.Closed}
                        onClick={() => { handleViewElectionResults(election.ElectionID) }}>
                        View results</button>
                </td>
                <div id='result-container'>
                    {/* 
                        This container must be shown on user clicking upper 'View results' button.
                        A table view might be a good fit. Result of [electGift_fetcher] contains all votes
                        for the specific election with name of the gift(might be transformed to return GiftID 
                        and match it on FE with cached Gift table for speed optimizations) and null for members
                        that did not vote at all. A message can be shown if null value present to kindly inform
                        the viewer that this member did not vote. 
                    */}
                </div>
            </tr>
        }
        );



    function getTableHead() {
        return (
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Birthdate</th>
                    <th>For year</th>
                </tr>
            </thead>
        );
    }

    return (
        <div className='container'>
            <h3>Open elections</h3>
            <table>
                {getTableHead()}
                <tbody>
                    {openElectionsTable()}
                </tbody>
            </table>

            <h3>Closed elections</h3>
            <table>
                {getTableHead()}
                <tbody>
                    {closedElectionsTable()}
                </tbody>
            </table>
        </div>
    )
};