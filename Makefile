# Makefile for building Rust project with musl using Docker

# Project settings
PROJECT_DIR := $(CURDIR)
#PROJECT_DIR := /ahome/bsherwood/git/rustybgp
TARGET := x86_64-unknown-linux-musl
#RELEASE_DIR := $(PROJECT_DIR)/target/$(TARGET)/release
BUILD_IMAGE := ghcr.io/rust-cross/rust-musl-cross:$(TARGET)

# Docker run command
#DOCKER_RUN := podman run --userns=keep-id --rm -v "$(PROJECT_DIR)":/home/rust/src -e CARGO_TARGET_DIR=/tmp/target $(BUILD_IMAGE)
DOCKER_RUN := podman run --userns=keep-id --rm -v "$(PROJECT_DIR)":/home/rust/src $(BUILD_IMAGE)

.PHONY: build clean

# Default target
build:
	sudo $(DOCKER_RUN) cargo build --release

# Custom command to copy the binary (adjust the binary name as needed)
#copy-binary:
#        cp $(RELEASE_DIR)/<your_binary_name> .

# Clean target directory
clean:
	$(DOCKER_RUN) cargo clean

run:
	sudo ./target/x86_64-unknown-linux-musl/debug/rustybgpd --any-peers --as-number 65001 --router-id 192.158.1.30
	#sudo ./target/x86_64-unknown-linux-musl/debug/rustybgpd -f rustybgp.conf

