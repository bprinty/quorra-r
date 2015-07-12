#
# Makefile for building and installing rbio packages.
#
# @author <bprinty@gmail.com>
# ---------------------------------------------------

USER = $(shell echo $$USER)
INSTALL_PATH = $(shell R --silent -e "a <- .libPaths(); print(a)" 2>/dev/null | grep '\[1\] ' | sed 's/\[1\] //g' | sed 's/"//g')
VERSION = $(shell cat quorra/DESCRIPTION | grep 'Version' | sed 's/Version: //g')
BUILD_PATH = build

default: build

help:
	@echo "make [clean | build | install | deploy]"

clean: 
	rm -rf $(BUILD_PATH)

test:
	cd quorra/tests && Rscript testthat.R

check:
	mkdir -p $(BUILD_PATH)
	R CMD check quorra && rm -rf $(BUILD_PATH)/quorra.Rcheck && mv quorra.Rcheck $(BUILD_PATH)/

.PHONY: build
build: check
	mkdir -p $(BUILD_PATH)
	R CMD build quorra && mv quorra_$(ASUTIL_VERSION).tar.gz $(BUILD_PATH)/

.PHONY: install
install: build
	R CMD INSTALL $(BUILD_PATH)/quorra_$(ASUTIL_VERSION).tar.gz --library=$(INSTALL_PATH)

.PHONY: deploy
deploy:
	# include deploy code here