FROM golang:1.23 AS builder

WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .

RUN go build -o prod_app .


FROM gcr.io/distroless/base

COPY --from=builder /app/prod_app .
COPY --from=builder /app/static ./static

EXPOSE 8080

CMD ["./prod_app"]