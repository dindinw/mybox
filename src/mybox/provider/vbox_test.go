package provider

import "testing"


func TestGetName(t *testing.T) {
    const NAME = "VirtualBox"
    if name := Getname(); name != NAME {
        t.Errorf("provider.Getname() = %v, want %v", name, NAME)
    }
}
