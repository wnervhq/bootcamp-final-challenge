package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

var scores = make(map[string]int)
var port = os.Getenv("PORT")

func main() {
	http.HandleFunc("/hello", HelloServer)
	http.HandleFunc("/inc-score", IncrementCounter)
	http.HandleFunc("/get-scores", GetScores)
	http.ListenAndServe(":" + port, nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %s!", r.URL.Path[1:])
}

// IncrementCounter increments some "score" for a user
func IncrementCounter(w http.ResponseWriter, r *http.Request) {
	name, ok := r.URL.Query()["name"]
	if !ok {
		w.WriteHeader(http.StatusOK)
	}
	scores[name[0]] += 1
	w.WriteHeader(http.StatusOK)
}

// GetScores gets all the scores for all users
func GetScores(w http.ResponseWriter, r *http.Request) {
	b, _ := json.Marshal(scores)
	w.WriteHeader(http.StatusOK)
	w.Write(b)
}
