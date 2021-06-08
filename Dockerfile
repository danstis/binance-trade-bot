# hadolint ignore=DL3029
FROM --platform=$BUILDPLATFORM python:3.9.4 as builder

WORKDIR /install

# hadolint ignore=DL3008,DL3015
RUN apt-get update && apt-get install -y rustc

COPY requirements.txt /requirements.txt
# hadolint ignore=DL3042
RUN pip install --prefix=/install -r /requirements.txt

FROM python:3.9.4

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

CMD ["python", "-m", "binance_trade_bot"]
