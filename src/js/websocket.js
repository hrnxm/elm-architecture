'use strict'

// used just to mimic `echo.websocket.org` because it became slow

class WebSocket {
    constructor(url) {
        this.handler = null;
    }

    set onmessage(handler) {
        if (typeof handler === 'function') {
            this.handler = handler;
        }
    }

    send(string) {
        if (typeof this.handler === 'function') {
            setTimeout(() => {
                this.handler(string)
            }, 300); // simulate delay
        }
    }
}