FROM golang:latest

ENV GOPATH /go

RUN apt-get update ; apt-get install -y git
RUN mkdir -p $GOPATH/src/github.com/gogits
WORKDIR $GOPATH/src/github.com/gogits
RUN git clone --depth=1 -b develop https://github.com/gogits/gogs
WORKDIR $GOPATH/src/github.com/gogits/gogs
RUN go build

EXPOSE 3000
EXPOSE 22

VOLUME ["/data"]

CMD ["./gogs", "web"]
