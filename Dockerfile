# ビルドするGoのバージョンでイメージを選択
FROM golang:1.11.5 as builder
# 作業用ディレクトリを設定
WORKDIR /go/src/app
# リポジトリのソースをコンテナに追加
COPY . .
# Go 1.11で追加されたモジュール機能を使用する
ENV GO111MODULE=on
# 依存パッケージを取得
RUN go mod vendor
# ソースをビルド
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./main.go

# 軽量イメージにするためaplineイメージを使う
FROM alpine:latest
# 不要なキャッシュ削除, 証明書インストール
RUN apk --no-cache add ca-certificates
# 作業ディレクトリを指定
WORKDIR /root/
# 上記のgolangイメージでビルドした実行ファイルをコピー
COPY --from=builder /go/src/app/main .
# Dockerイメージ起動時にプログラムを実行する
CMD ./main
