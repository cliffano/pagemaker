all: ci
ci: clean lint test

clean:
	cd examples && \
	  make -f ../src/Makefile-pagemaker clean

deps-extra-apt:
	apt-get install -y markdownlint

lint:
	checkmake src/Makefile-pagemaker
	mdl -s .mdl-style.rb $(shell find . -path ./stage -prune -o -path ./examples/node_modules -prune -o -name "*.md" -print) 

test:
	cd examples && \
	  make -f ../src/Makefile-pagemaker deps-extra-apt ci update-dotfiles update-to-latest update-to-main && \
	  make -f ../src/Makefile-pagemaker update-to-version TARGET_PAGEMAKER_VERSION=0.10.0

release-major:
	rtk release --release-increment-type major

release-minor:
	rtk release --release-increment-type minor

release-patch:
	rtk release --release-increment-type patch

release: release-minor

.PHONY: all ci clean lint release release-major release-minor release-patch test