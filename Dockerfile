FROM python:3.8 as builder

WORKDIR /install

COPY requirements.txt /requirements.txt

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=SC1091,DL3008
RUN apt-get update && apt-get install -y curl --no-install-recommends && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    . /root/.cargo/env && \
    rustup toolchain install 1.41.0 && \
    pip install --prefix=/install -r /requirements.txt

FROM python:3.8-slim

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

CMD ["python", "-m", "binance_trade_bot"]
