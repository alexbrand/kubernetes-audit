ifeq ($(origin VERSION), undefined)
  VERSION=$(git rev-parse --short HEAD)
endif
GOOS=$(shell go env GOOS)
GOARCH=$(shell go env GOARCH)
REPOPATH = kismatic/kubernetes-audit

build: vendor
	go build -o bin/audit -ldflags "-X $(REPOPATH).Version=$(VERSION)" ./cmd/audit

test: bin/glide
	go test $(shell ./bin/glide novendor)

vet: bin/glide
	go vet $(shell ./bin/glide novendor)

fmt: bin/glide
	go fmt $(shell ./bin/glide novendor)

run:
	./bin/audit

vendor: bin/glide
	./bin/glide install

bin/glide:
	@echo "Downloading glide"
	mkdir -p bin
	curl -L https://github.com/Masterminds/glide/releases/download/0.10.2/glide-0.10.2-$(GOOS)-$(GOARCH).tar.gz | tar -xz -C bin
	mv bin/$(GOOS)-$(GOARCH)/glide bin/glide
	rm -r bin/$(GOOS)-$(GOARCH)
