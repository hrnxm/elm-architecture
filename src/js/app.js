const elmNode = document.querySelector('#elm');

const app = Elm.Main.init({
    node: elmNode,
    flags: {
        currentTime: new Date().toLocaleTimeString()
    }
})

const ws = new WebSocket('wss://echo.websocket.org');

// elm -> js
app.ports.sendMessage.subscribe((message) => {
    ws.send(message)
});

ws.onmessage = (message) => {
    // js -> elm
    app.ports.onMessage.send(message);
}