package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hello server1")
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Starting server on :8090")
	http.ListenAndServe(":8090", nil)
}
