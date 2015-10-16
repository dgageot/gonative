PKG=github.com/dgageot/gonative
WORKSPACE=$(shell pwd)/Godeps/_workspace
CANONICAL=$(WORKSPACE)/src/$(PKG)
GODEP=$(WORKSPACE)/bin/godep
export GOPATH:=$(WORKSPACE)

BUILD=build

default: workspace $(CANONICAL) $(GODEP) fmt
	$(GODEP) go $(BUILD) -v $(PKG)

$(GODEP):
	go get github.com/tools/godep

workspace: $(GODEP)
	$(GODEP) restore

$(CANONICAL):
	mkdir -p $(WORKSPACE)/src/github.com/dgageot
	ln -s $(shell pwd) $(WORKSPACE)/src/$(PKG)

fmt:
	go fmt ./...

clean:
	go clean -i -r $(PKG)

test:
	go test -cover
