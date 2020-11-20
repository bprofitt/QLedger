# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:1.11
ENV LEDGER_AUTH_TOKEN=testtoken
ENV MIGRATION_FILES_PATH=file:///go/src/github.com/RealImage/QLedger/migrations/postgres
ENV PORT=7000

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/RealImage/QLedger

# Build the QLedger command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN go install github.com/RealImage/QLedger

# Add aws-env for db connect string
RUN wget https://github.com/Droplr/aws-env/raw/master/bin/aws-env-linux-amd64 -O /bin/aws-env
RUN chmod +x /bin/aws-env

CMD ["/bin/bash", "-c", "eval $(AWS_ENV_PATH=/dev/ AWS_REGION=eu-west-1 /bin/aws-env) && /go/bin/QLedger"]
# Run the QLedger command by default when the container starts.
#ENTRYPOINT /go/bin/QLedger

# Document that the service listens on port 7000.
EXPOSE 7000
