# Directories
SRC_DIR := src
OUT_DIR := out
OBJ_DIR := $(OUT_DIR)/obj
BIN := game
OUT := $(OUT_DIR)/$(BIN)
INCLUDE_FLAGS := -Iinclude

CC := gcc
PKGCONFIG = pkg-config
RAYLIB_CFLAGS := $(shell $(PKGCONFIG) --cflags raylib)
RAYLIB_LDLIBS := $(shell $(PKGCONFIG) --libs raylib)
CFLAGS := $(INCLUDE_FLAGS) -std=c99 -Wshadow -Wall -Wextra -Wpedantic -MMD -MP $(RAYLIB_CFLAGS)

# Link flags (paths/frameworks/libs go on link step)
LDFLAGS =
LDLIBS := $(RAYLIB_LDLIBS)

# Lint flags
LINT_FLAGS := --enable=all --inconclusive

SOURCE_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SOURCE_FILES))

# Profiles
ifeq ($(PROD),1)
	CFLAGS += -O3 -DNDEBUG
else
	CFLAGS += -g -O0 -DDEBUG -fno-omit-frame-pointer -fsanitize=address,undefined
	LDFLAGS += -fsanitize=address,undefined
endif

# Default goal
.DEFAULT_GOAL := build

build: $(OUT)

# Link: objects first, libs at the end; ensure OUT_DIR exists before (order-only)
$(OUT): $(OBJ_FILES) | $(OUT_DIR)
	$(CC) $^ -o $@ $(LDFLAGS) $(LDLIBS)

# Compile: only CFLAGS; ensure OBJ_DIR
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Directories as targets
$(OUT_DIR) $(OBJ_DIR):
	mkdir -p $@

build-and-run: build
	./$(OUT)

clean:
	rm -rf $(OUT_DIR)

format:
	clang-format $(SRC_DIR)/*.c -i

generate-comp-commands:
	bear -- make -B

lint:
	cppcheck $(SRC_DIR) --force

# Header deps
-include $(OBJ_FILES:.o=.d)

.PHONY: build build-and-run clean format generate-comp-commands lint
