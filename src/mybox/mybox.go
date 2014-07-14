package main

import ( "fmt"
         "mybox/provider"
)

func main() {
    fmt.Printf("MYBOX Version 2.0\n")
    fmt.Printf("VM Provider is %s \n",provider.Getname())
}