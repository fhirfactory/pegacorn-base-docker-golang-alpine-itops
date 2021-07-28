FROM golang:1.16.1-alpine3.13 as go-builder

RUN apk add --no-cache gcc g++

WORKDIR $GOPATH/src/github.com/grafana/grafana

COPY go.mod go.sum embed.go ./
COPY cue cue
COPY public/app/plugins public/app/plugins
COPY pkg pkg
COPY build.go package.json ./

RUN go mod verify

RUN go run build.go build