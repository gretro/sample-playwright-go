FROM golang:1.21.6-bookworm

ENV CGO_ENABLED=0
ENV PLAYWRIGHT_BROWSERS_PATH=/usr/lib/playwright

WORKDIR /build
COPY ./ ./

RUN git init --quiet && \
  go mod download && \
  go install github.com/playwright-community/playwright-go/cmd/playwright@latest && \
  playwright install chromium --with-deps && \
  go build -o ./bin/api main.go

CMD /build/bin/api
