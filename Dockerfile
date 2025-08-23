FROM caddy:2.8-builder AS builder

# Install xcaddy
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# Make sure $GOPATH/bin is in PATH
ENV PATH="/go/bin:${PATH}"

RUN xcaddy build --with github.com/caddy-dns/cloudflare --with github.com/caddy-dns/duckdns

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
