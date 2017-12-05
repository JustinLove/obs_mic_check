module OBSWebSocket.Event exposing (..)

import OBSWebSocket.Data exposing (..)

import Json.Decode exposing (..)

type EventData
  = IgnoredEvent String
  | SwitchScenes Scene
  | SceneItemAdded String String
  | SceneItemRemoved String String
  | SceneItemVisibilityChanged String String Render
  | StreamStatus StreamStatusStruct

event : Decoder EventData
event =
  (field "update-type" string)
  |> andThen (\updateType -> case updateType of
    "SwitchScenes" -> switchScenes
    "TransitionBegin" -> succeed (IgnoredEvent updateType)
    "SceneItemAdded" -> sceneItemAdded
    "SceneItemRemoved" -> sceneItemRemoved
    "SceneItemVisibilityChanged" -> sceneItemVisibilityChanged
    "StreamStarting" -> succeed (IgnoredEvent updateType)
    "StreamStarted" -> succeed (IgnoredEvent updateType)
    "StreamStopping" -> succeed (IgnoredEvent updateType)
    "StreamStopped" -> succeed (IgnoredEvent updateType)
    "StreamStatus" -> streamStatus
    "PreviewSceneChanged" -> succeed (IgnoredEvent updateType)
    _ -> fail "Not a known event update-type"
  )

switchScenes : Decoder EventData
switchScenes =
  map SwitchScenes scene

sceneItemAdded : Decoder EventData
sceneItemAdded =
  map2 SceneItemAdded
    (field "scene-name" string)
    (field "item-name" string)

sceneItemRemoved : Decoder EventData
sceneItemRemoved =
  map2 SceneItemRemoved
    (field "scene-name" string)
    (field "item-name" string)

sceneItemVisibilityChanged : Decoder EventData
sceneItemVisibilityChanged =
  map3 SceneItemVisibilityChanged
    (field "scene-name" string)
    (field "item-name" string)
    (field "item-visible" render)

type alias StreamStatusStruct =
  { streaming : Bool
  , recording : Bool
  }

streamStatus : Decoder EventData
streamStatus =
  map2 StreamStatusStruct
    (field "streaming" bool)
    (field "recording" bool)
  |> map StreamStatus 

