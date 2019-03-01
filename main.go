package main

import (
	"fmt"
	"log"
	"net/http"
)

func handleHello(w http.ResponseWriter, r *http.Request) {
	// レスポンスボディでOK!を出力する
	fmt.Fprint(w, "OK!")
}

func main() {
	// パスにAPIを登録
	http.HandleFunc("/", handleHello)
	// 80ポートを開放して、サーバを起動
	if err := http.ListenAndServe(":80", nil); err != nil {
		log.Fatal(err)
	}
}
