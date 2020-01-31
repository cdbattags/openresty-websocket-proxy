const express = require('express')
const path = require('path')
const app = express()

require('express-ws')(app)

const port = 9300

app.set('view engine', 'pug')

app.set(
    'views',
    path.join(__dirname, '/views')
)

app.use(
    express.static(
        path.join(__dirname, '/public')
    )
)

app.ws('/ws/websocket-test', (ws, req) => {
    console.log(req.headers)

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