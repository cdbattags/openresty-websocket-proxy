class WebSocketTestService {
    constructor() {
        this.channel = 'websocket_test_channel';
        this.webSocketURL = 'ws://0.0.0.0:9300/websocket-test';
    }

    /**
     * Run a simple test to check if a WebSocket connection can be established
     * and data transmitted. The test will fail if it does not
     * receive a response after a predetermined amount of time.
     * @return {Promise} - the promise wrapped result of the test
     */
    runTest() {
        return new Promise((resolve, reject) => {
            const websocket = new WebSocket(this.webSocketURL);

            websocket.onopen = (e) => {
                websocket.send('Testing, testing, 1-2-3. Is this thing on?');
            };

            websocket.onmessage = (e) => {
                websocket.close();
                resolve('Websocket test passed!');
            };

            websocket.onerror = (e) => {
                websocket.close();
                reject('Websocket test failed!', e);
            };

            setTimeout(() => {
                websocket.close();
                reject('No response received after 10 seconds. Websocket test failed!');
            }, 10000);
        });
    }
}

new WebSocketTestService().runTest()