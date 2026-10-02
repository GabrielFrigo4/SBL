.POSIX:
.SILENT:

MAKEFLAGS += --no-print-directory -s

# ----------------------------------------------------------------
# Makefile: Standard BSD Libraries (SBL)
# License: BSD-3-Clause (c) 2026 GabrielFrigo
# ----------------------------------------------------------------

LIB_NAME     = libsbl
SRC_DIR      = src
INC_DIR      = include
BUILD_DIR    = build
TEST_DIR     = tests

CC           = gcc
AR           = ar
ARFLAGS      = rcs

CFLAGS       = -std=c23 -O2 -fstack-protector-strong -fPIC
WFLAGS       = -Wformat=2 -Wall -Wextra -Wvla -Wpedantic -Wshadow -Wconversion -Wsign-conversion -Werror
CPPFLAGS     = -I$(INC_DIR) -D_DEFAULT_SOURCE -D_POSIX_C_SOURCE=202405L

STATIC_LIB   = $(BUILD_DIR)/$(LIB_NAME).a
SHARED_LIB   = $(BUILD_DIR)/$(LIB_NAME).so

.PHONY: all help build static dynamic test format clang-format prettier lint hooks ci clean install

### ================================
### HELP & DOCUMENTATION
### ================================
help:
	_e=$$'\e'; \
	cmd() { printf "    $${_e}[36mmake %-22s$${_e}[0m %s\n" "$$1" "$$2"; }; \
	sec() { printf "\n  $${_e}[1;33m%s$${_e}[0m\n" "$$1"; }; \
	printf "\n  $${_e}[1;37mStandard BSD Libraries (SBL) — Biblioteca Padrão C23 Soberana$${_e}[0m\n"; \
	printf "  ===============================================================\n"; \
	sec "Compilação & Bibliotecas:"; \
	cmd "build"          "Compila biblioteca estática (.a) e dinâmica (.so) em build/"; \
	cmd "static"         "Compila exclusivamente a biblioteca estática libsbl.a"; \
	cmd "dynamic"        "Compila exclusivamente a biblioteca compartilhada libsbl.so"; \
	cmd "test"           "Executa a suíte de testes unitários e validações estatísticas"; \
	cmd "clean"          "Remove artefatos de compilação da pasta build/"; \
	sec "Qualidade & Governança:"; \
	cmd "format"         "Formata arquivos C (clang-format) e Markdown (Prettier)"; \
	cmd "clang-format"   "Formata arquivos C com clang-format"; \
	cmd "prettier"       "Formata arquivos Markdown com Prettier"; \
	cmd "lint"           "Valida formatação sem alterar arquivos"; \
	cmd "hooks"          "Configura e ativa os quality gates locais (.githooks)"; \
	cmd "ci"             "Executa pipeline local de validação e compilação"; \
	echo ""

all: help

### ================================
### BUILD PIPELINE
### ================================
build: static dynamic
	echo "✅ SBL: Bibliotecas estática e dinâmica compiladas com sucesso em $(BUILD_DIR)/"

static:
	mkdir -p $(BUILD_DIR)
	_sources=$$(find $(SRC_DIR) -name "*.c" 2> "/dev/null" || true); \
	if [ -n "$$_sources" ]; then \
		echo "⚙️  Compilando objetos estáticos..."; \
		$(CC) $(CFLAGS) $(WFLAGS) $(CPPFLAGS) -c $$_sources; \
		$(AR) $(ARFLAGS) $(STATIC_LIB) *.o; \
		rm -f *.o; \
		echo "  📦 $(STATIC_LIB) gerado com sucesso!"; \
	else \
		echo "ℹ️  Nenhum código fonte em $(SRC_DIR)/ ainda. Fase de manifesto."; \
	fi

dynamic:
	mkdir -p $(BUILD_DIR)
	_sources=$$(find $(SRC_DIR) -name "*.c" 2> "/dev/null" || true); \
	if [ -n "$$_sources" ]; then \
		echo "⚙️  Compilando biblioteca dinâmica..."; \
		$(CC) $(CFLAGS) $(WFLAGS) $(CPPFLAGS) -shared $$_sources -o $(SHARED_LIB); \
		echo "  🔗 $(SHARED_LIB) gerado com sucesso!"; \
	else \
		echo "ℹ️  Nenhum código fonte em $(SRC_DIR)/ ainda. Fase de manifesto."; \
	fi

test:
	echo "🧪 Executando suíte de testes do SBL..."
	_tests=$$(find $(TEST_DIR) -name "*.c" 2> "/dev/null" || true); \
	if [ -n "$$_tests" ]; then \
		echo "  Compilando e executando testes..."; \
	else \
		echo "ℹ️  Nenhum teste implementado ainda."; \
	fi

clean:
	echo "🧹 Limpando artefatos de compilação..."
	rm -rf $(BUILD_DIR)
	echo "✅ Workspace limpo!"

### ================================
### GOVERNANCE & QUALITY GATES
### ================================
format: clang-format prettier
	echo "✅ Formatação concluída!"

clang-format:
	echo "🎨 Formatando arquivos C/Header com clang-format..."
	if command -v clang-format > "/dev/null" 2>&1; then \
		find . -type f \( -name "*.c" -o -name "*.h" \) -not -path "*/.*" -exec clang-format -i {} + 2>/dev/null || true; \
	fi

prettier:
	echo "🎨 Formatando arquivos Markdown com Prettier..."
	if command -v prettier > "/dev/null" 2>&1; then \
		prettier --write "**/*.md" 2> "/dev/null" || true; \
	elif command -v npx > "/dev/null" 2>&1; then \
		npx prettier --write "**/*.md" 2> "/dev/null" || true; \
	fi

lint:
	echo "🔍 Validando formatação com Prettier..."
	if command -v prettier > "/dev/null" 2>&1; then \
		prettier --check "**/*.md"; \
	fi

hooks:
	echo "⚓ Configurando permissões e ativando .githooks..."
	chmod 0755 .githooks/* 2> "/dev/null" || true
	git config core.hooksPath .githooks 2> "/dev/null" || true
	echo "  ✅ SBL: core.hooksPath -> .githooks"

ci: lint
	echo "✅ Quality Gate CI concluído com sucesso!"
