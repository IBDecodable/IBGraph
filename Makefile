PREFIX?=/usr/local

build:
		swift build --disable-sandbox -c release --static-swift-stdlib

clean_build:
		rm -rf .build
		make build

portable_zip: build
		rm -rf portable_ibgraph
		mkdir portable_ibgraph
		mkdir portable_ibgraph/bin
		cp -f .build/release/ibgraph portable_ibgraph/bin/ibgraph
		cp -f LICENSE portable_ibgraph
		cd portable_ibgraph
		(cd portable_ibgraph; zip -yr - "bin" "LICENSE") > "./portable_ibgraph.zip"
		rm -rf portable_ibgraph

install: build
		mkdir -p "$(PREFIX)/bin"
		cp -f ".build/release/ibgraph" "$(PREFIX)/bin/ibgraph"

current_version:
		@cat .version

bump_version:
		$(eval NEW_VERSION := $(filter-out $@,$(MAKECMDGOALS)))
		@echo $(NEW_VERSION) > .version
		@sed 's/__VERSION__/$(NEW_VERSION)/g' script/Version.swift.template > Sources/IBGraphFrontend/Version.swift
		git commit -am"Bump version to $(NEW_VERSION)"

publish:
		brew update && brew bump-formula-pr --tag=$(shell git describe --tags) --revision=$(shell git rev-parse HEAD) ibgraph
		COCOAPODS_VALIDATOR_SKIP_XCODEBUILD=1 pod trunk push IBGraph.podspec

%:
	@:
