# hadolint ignore=DL3029
FROM --platform=$BUILDPLATFORM python:3.9.3 as builder

WORKDIR /install

COPY requirements.txt /requirements.txt

# hadolint ignore=SC1091,DL3008,DL3015,DL4006
RUN apt-get update && apt-get install -y curl && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    . /root/.cargo/env && \
    rustup toolchain install 1.41.0 && \
    pip install --prefix=/install -r /requirements.txt

FROM python:3.9.3

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

CMD ["python", "-m", "binance_trade_bot"]
