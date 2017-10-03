FROM debian:latest

ENV GOPATH /go
ENV USER git

RUN apt-get update
RUN apt-get install -y git golang sqlite3 wget tar

RUN wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
RUN tar -xvf go1.8.3.linux-amd64.tar.gz
RUN mv go /usr/local

RUN mkdir -p $GOPATH/src/github.com/gogits
WORKDIR $GOPATH/src/github.com/gogits
RUN git clone --depth=1 -b develop https://github.com/gogits/gogs
WORKDIR $GOPATH/src/github.com/gogits/gogs
RUN go build -tags "sqlite"

EXPOSE 3000
EXPOSE 22

VOLUME ["/data"]

CMD ["./gogs", "web"]
