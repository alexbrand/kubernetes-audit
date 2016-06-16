package main

import (
	"fmt"
	"io"
	"os"
)

func main() {

	f, err := os.Create("audit.log")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error creating audit log file")
		os.Exit(1)
	}
	defer f.Close()

	io.Copy(f, os.Stdin)
}
