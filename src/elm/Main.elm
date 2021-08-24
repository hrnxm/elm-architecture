module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import WebSocket


type alias InputParams =
    { currentTime : String }


type alias Model =
    { timeOfInitialization : String
    , messages : List String
    , typedValue : String
    }


type Msg
    = Input String
    | Click
    | MessageReceived String


main : Program InputParams Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : InputParams -> ( Model, Cmd msg )
init { currentTime } =
    ( Model currentTime [] "", Cmd.none )


view : Model -> Html Msg
view model =
    let
        viewMessage message =
            li [] [ text message ]
    in
    div []
        [ input [ type_ "text", onInput Input, value model.typedValue ] []
        , button [ onClick Click ] [ text "Send" ]
        , ul [] <| List.map viewMessage model.messages
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input str ->
            ( { model | typedValue = str }
            , Cmd.none
            )

        Click ->
            ( { model | typedValue = "" }
            , WebSocket.sendMessage model.typedValue
            )

        MessageReceived message ->
            ( { model | messages = message :: model.messages }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ WebSocket.onMessage MessageReceived
        ]
