all: ci
ci: clean lint test

clean:
	cd examples && \
	  make -f ../src/Makefile-pagemaker clean

lint:
	checkmake src/Makefile-pagemaker

test:
	cd examples && \
	  make -f ../src/Makefile-pagemaker deps-extra-apt ci update-dotfiles update-to-latest update-to-main && \
	  make -f ../src/Makefile-pagemaker update-to-version TARGET_DOCO_VERSION=0.9.0

release-major:
	rtk release --release-increment-type major

release-minor:
	rtk release --release-increment-type minor

release-patch:
	rtk release --release-increment-type patch

release: release-minor

.PHONY: all ci clean lint release release-major release-minor release-patch test