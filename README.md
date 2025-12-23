# macOS raylib C template

A very simple and lean C + raylib template.

Be aware that:

1. This was only tested on macOS
1. This is not meant to be used in a production environment
1. I'm not a professional C programmer

# First steps

1. Install the following tools with Homebrew: `brew install bear clang-format raylib`
1. Run `generate-comp-commands` (this will generate a `compile_commands.json` to allow VSCode to properly work with the project)
1. Update your `~/.zshrc` to export the following:

```
export CPATH="$(brew --prefix)/include:$CPATH"
export LIBRARY_PATH="$(brew --prefix)/lib:$LIBRARY_PATH"
```

## Makefile tasks

- `make` or `make build`: compile the project without running it.
- `make build-and-run`: build the project and launch the resulting binary.
- `make clean`: remove all build artifacts under `out/`.
- `make format`: format all source files with `clang-format`.
- `make generate-comp-commands`: produce `compile_commands.json` for tooling support.

## VSCode tasks / launch config

The template is thought to be used with VSCode. It includes:

1. Basic tasks:
   - build (debug);
   - build (prod);
   - build (debug) and run;
1. Basic launch configuration
1. Quality scripts

## Required extensions:

1. [clangd](vscode:extension/llvm-vs-code-extensions.vscode-clangd)
1. [CodeLLDB](vscode:extension/vadimcn.vscode-lldb)
1. [Clang-Format (optional)](vscode:extension/xaver.clang-format)
