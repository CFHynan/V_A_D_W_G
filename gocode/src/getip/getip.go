// File: getip.go - a REST based service which returns the container IP when called via /getip

package main

import(

  "bytes"
  "fmt"
  "github.com/gorilla/mux"
  "log"
  "net"
  "net/http"

)

func main(){

  router := mux.NewRouter().StrictSlash(true)
  router.HandleFunc("/", errorWeave)
  router.HandleFunc("/getip", getIP)

  log.Fatal(http.ListenAndServe(":80", router))

}

func errorWeave(w http.ResponseWriter, r *http.Request){

  fmt.Fprintln(w, "Hi there ! try calling /getip in order to retrieve the IP of a Weave registered container.")

}

func getIP(w http.ResponseWriter, r *http.Request){

  var theips bytes.Buffer
  ief, _ := net.InterfaceByName("ethwe")
  addrs, _ := ief.Addrs()

  for _, a := range addrs{

    if ipnet, ok := a.(*net.IPNet); ok && !ipnet.IP.IsLoopback(){

      theips.WriteString(ipnet.IP.String())
      theips.WriteString("\n")

    }
  }

  fmt.Fprintln(w, theips.String())

}
