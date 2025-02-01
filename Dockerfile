# Use the official Golang image as a builder
FROM golang:1.20 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source code into the container
COPY . .

# Build the Go application
RUN go mod init hello-world && go mod tidy && go build -o hello-world

# Use a minimal image for running the application
FROM alpine:latest

# Set the working directory
WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/hello-world .

# Run the application
CMD ["./hello-world"]