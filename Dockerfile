FROM golang:1.22-bookworm AS builder

WORKDIR /app

COPY . .

RUN go mod download || true

RUN CGO_ENABLED=0 go build -o main .

FROM gcr.io/distroless/static-debian12

COPY --from=builder /app/main /main

CMD ["/main"]