# Simple LUT Apply Script

## Description
This small CLI Tool uses ffmpeg to apply a LUT as video filter on a supported video. The main idea comes from the need to apply a "default" LUT on a 10 Bit video file created by DJI Drones to have a fast check if the camera settings are good enough.

## Usage
The compile tool can be used in multiple ways

- apply one specific LUT
`lut_apply -s ~/Documents/LUT_DIR/LUT.cube -f VIDEO.mp4`

- select and apply one specific LUT from a directory
`lut_apply -l ~/Documents/LUT_DIR -f VIDEO.mp4`

- apply all LUTs in a directory for comparison
`lut_apply -a -l ~/Documents/LUT_DIR/LUT.cube -f VIDEO.mp4`

The parameter `-s` overwrites `-a and -l`.

## Build it yourself

`go mod tidy`
`go build -o lut_apply`

### Build Script

The build script uses features of Bash v4. To have it installed on a Mac you need to install it seperately with `brew install bash`.
The script cross compiles all supported OS and Arch combinations and outputs them to the `dist` dir.
