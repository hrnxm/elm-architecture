port module WebSocket exposing (..)

-- elm -> js


port sendMessage : String -> Cmd msg



-- js -> elm


port onMessage : (String -> msg) -> Sub msg
