# hadolint ignore=DL3029
FROM --platform=$BUILDPLATFORM python:3.8 as builder

WORKDIR /install

# hadolint ignore=DL4006
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y curl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# hadolint ignore=SC1091
RUN . /root/.cargo/env
RUN rustup toolchain install 1.41.0

COPY requirements.txt /requirements.txt

RUN pip install --prefix=/install -r /requirements.txt

FROM python:3.8-slim

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

CMD ["python", "-m", "binance_trade_bot"]
