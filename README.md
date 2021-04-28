# OBS -> FTL -> WebRTC Streaming Server on Windows

Original guide: https://pythonawesome.com/a-self-contained-obs-ftl-webrtc-live-streaming-server/

Components:
 - lightspeed-ingest: https://github.com/GRVYDEV/Lightspeed-ingest
 - lightspeed-react: https://github.com/GRVYDEV/Lightspeed-react
 - lightspeed-webrtc: https://github.com/GRVYDEV/Lightspeed-webrtc

# Usage

Run these commands from a WSL2 terminal.

1. Clone the repo and submodules:

```sh
git clone --recursive -j8 https://github.com/danisla/obs-ftl-webrtc
```

```sh
cd obs-ftl-webrtc
```

2. Build the ingest and webrtc windows binaries:

```sh
./scripts/build-lightspeed-ingest-win.sh
```
> This will output the binary: `bin/x86_64/lightspeed-ingest.exe`

```sh
./scripts/build-lightspeed-webrtc-win.sh
```
> This will output the binary: `bin/x86_64/lightspeed-webrtc.exe`

4. Run `bin/x86_64/lightspeed-ingest.exe`
> Starts on port 8084

5. Run `bin/x86_64/lightspeed-webrtc.exe`
> Starts on port 8080

6. Start the react container:

```
docker-compose up -d
```
> Starts on port 8000