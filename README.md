# Docker Binary Builder

Simple script for building binaries from source, using a dockerfile.

## How to Use

*Requires docker to be installed on your machine*

Invoke the build script and provide a relative path to the dockerfile:

`./build.sh dockerfile.example`
`./build.sh files/dockerfile.bitcoind`

Sample dockerfiles are provided in the `files/` sub-directory.

## Contribute

Feel free to contribute more dockerfiles! I'll provide more examples as I make them.

## Resources
Dockerfile reference guide:
https://docs.docker.com/engine/reference/builder/