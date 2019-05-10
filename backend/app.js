const express = require('express')
const app = express()

require('express-ws')(app)

const port = 9300

app.set('view engine', 'pug')

app.use(express.static('public'))

app.ws('/ws/websocket-test', (ws, req) => {
    ws.on('message', (msg) => {
        console.log("websocket message received: ", msg)
        ws.send("Reading you loud and clear!")
        ws.terminate()
    })
    console.log("websocket running")
    console.log(req.upgrade)
})

app.get('/', function (req, res) {
    res.render('index')
})

app.listen(port, () => console.log(`App server listening on port ${port}!`))