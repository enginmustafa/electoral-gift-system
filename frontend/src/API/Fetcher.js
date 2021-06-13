
//helper function which being given the url once 
//is capable of making fetch requests to server based on request options
export function Fetcher(url) {

    function imitateResponse() {
        return {
            Table: [],
            Success: false,
            ErrorMessage: 'Fatal error during connection to server.'
        }
    }

    async function exec(requestOptions) {
        let data;

        if (requestOptions.body !== undefined) {
            requestOptions.body = JSON.stringify(requestOptions.body);
        }

        try {
            const response = await fetch(url, requestOptions);
            data = await response.json();
        } catch (error) {
            //avoid dealing with multiple types of objects on components using Fetcher
            data = imitateResponse();
        }

        return data;
    }

    return { exec };
}