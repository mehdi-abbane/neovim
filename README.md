# Neovim Configuration Requirements

This document lists the dependencies required for my Neovim setup, including external tools and Neovim plugins installed via Mason.

## System Requirements

Ensure you have the following installed on your system before setting up Neovim.

### External Dependencies (Outside Neovim)

These must be installed separately:

- **Mono** (`mono-complete`) – Required for OmniSharp (C# LSP)
- **Node.js** – Required for some LSPs and formatters (e.g., Prettier, TypeScript LSP)
- **.NET SDK** – Required for OmniSharp
- **Rust** (`rustc` and `cargo`) – Required for `rust-analyzer` and Rust development
- **C++ Compiler** (GCC/G++) – Required for C++ development (`clangd` can be used for LSP)
- **Lua** – Required for lua language

### Neovim Plugins & Mason Packages

Inside Neovim, the following packages are installed via `Mason`:

#### Language Servers

- `css-lsp`
- `html-lsp`
- `lua-language-server`
- `omnisharp`
- `omnisharp-mono`
- `pyright`
- `rust-analyzer`
- `typescript-language-server`

#### Formatters

- `black` (Python)
- `clang-format` (C, C++)
- `prettier` (JavaScript, TypeScript, HTML, CSS, etc.)
- `rustfmt` (Rust)
- `stylua` (Lua)


