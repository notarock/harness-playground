FROM golang:1.20-alpine as build
LABEL maintainer="Roch D'Amour <roch.damour@arctiq.ca>"
MAINTAINER Roch D'Amour <roch.damour@arctiq.ca>

EXPOSE 8080

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

RUN apk add --no-cache --update ca-certificates

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o playground main.go

FROM scratch

COPY --from=build /app/playground /playground

ENTRYPOINT ["/playground"]
