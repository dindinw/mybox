package provider_test

import (
    "fmt"
    "mybox/provider"
)

func ExampleTest() {
    fmt.Println(provider.Getname())
    // Output: VirtualBox
}
