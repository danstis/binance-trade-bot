FROM --platform=$BUILDPLATFORM python:3.8 as builder

WORKDIR /install

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=SC1091,DL3008,DL3029
RUN apt-get update && apt-get install --no-install-recommends -y curl 
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . /root/.cargo/env 
RUN rustup toolchain install 1.41.0

COPY requirements.txt /requirements.txt

RUN pip install --prefix=/install -r /requirements.txt

FROM python:3.8-slim

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

CMD ["python", "-m", "binance_trade_bot"]
