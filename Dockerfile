FROM golang:1.23 as BUILDER

WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .

RUN go build -o prod_app .


FROM gcr.io/distroless/base

COPY --from=BUILDER /app/prod_app .
COPY --from=BUILDER /app/static ./static

EXPOSE 8080

CMD ["./prod_app"]