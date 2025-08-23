FROM caddy:latest-builder AS builder

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

ENV PATH="/go/bin:${PATH}"

# Print xcaddy version and env info
RUN xcaddy version && go version && env

RUN xcaddy build --with github.com/caddy-dns/cloudflare --with github.com/caddy-dns/duckdns

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
