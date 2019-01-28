FROM instrumentisto/glide as builder

WORKDIR /go/src
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/main .

FROM scratch
MAINTAINER Wayne Humphrey <wayne@humphrey.za.net>
COPY --from=builder /go/src/build/main server
ENV PORT 3000
EXPOSE 3000
ENTRYPOINT ["/server"]