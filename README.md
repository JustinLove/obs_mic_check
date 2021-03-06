# OBS Mic-Check

Check that [OBS Studio](https://obsproject.com/) audio state and active video sources are synchronized, e.g., when "BRB" is showing, mic should be off, and vice-versa. Also includes alarms for dropped frames.

## Requirements

- [OBS Studio](https://obsproject.com/)
- [obs-websockets](https://github.com/Palakis/obs-websocket)
- [Elm](http://elm-lang.org/) to build from source

## Usage

Data is stored in browser local storage and will not be synchronized between different browsers.

Application two sections: Audio Alarms (e.g. mic-check) and Dropped Frames alarms.

### Audio Alarms

Add Sources/patterns that you care about ("BRB", "Starting Soon", etc.)

The application has a set of *sources* with associated microphone states and a timeout. One of the *visible* sources will be considered active, and the microphone rules willl be evaluated. If the conditions match for the timeout period, an alarm will be raised. When no selected sources are visible, a default set of microphone rules will be evaluated.

#### Examples

- **BRB** - alarm if mic *on* for more than *5 seconds*
- **Starting soon** - alarm if mic *on* for more than *5 seconds*
- **Stream over** - alarm if mic *on* for more than *5 minutes*
- **None of the above** - alarm if mic *off* for more than *5 seconds*

### Dropped Frames

Shows current dropped frame rate. You may configure the sample window for alarms, as well as the percent of dropped frames to alarm at.

While streaming, a graph of dropped frames is shown.

## Building

`elm-make src/OBSMicCheck.elm --output public/obs-mic-check.js` 

`bin/monitor.bat` runs that command through the cli for the node watch package

The `reactor.html` is not generally usable because it does not support ports (persistence)

## Credits

Alert sounds: [`pup_alert.mp3`](https://freesound.org/people/willy_ineedthatapp_com/sounds/167337/) by `willy_ineedthatapp_com`
Icons: [IcoMoon - Free](https://icomoon.io/#icons-icomoon) ([CC BY 4.0](http://creativecommons.org/licenses/by/4.0/))
