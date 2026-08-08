# Standard BSD Libraries (SBL)

[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](LICENSE)
[![C Standard](https://img.shields.io/badge/C-C23-blue.svg)](PHILOSOPHY.md)
[![Build System](https://img.shields.io/badge/Build-bmake-orange.svg)](PHILOSOPHY.md)

O **Standard BSD Libraries (SBL)** é uma suíte modular e moderna de bibliotecas para a linguagem C (padrão **C23**), projetada para ser a "biblioteca padrão" definitiva que elimina as dores de cabeça do desenvolvimento em C.

O nome e conceito são inspirações diretas da STL (do C++) e da sonoridade da SDL, combinando simplicidade, alta modularidade e performance.

---

## 📜 Filosofia & Pilares BSD

O projeto é guiado pelas filosofias dos 4 grandes BSDs:

- ⚡ **FreeBSD**: Foco em **eficiência** e alto desempenho.
- 🔒 **OpenBSD**: Foco em **simplicidade, auditabilidade e segurança**.
- 🌐 **NetBSD**: Foco em **portabilidade extrema**.
- 🚀 **DragonFlyBSD**: Foco em **concorrência/paralelismo avançado** e arquiteturas sem medo de inovar.

Para entender todos os detalhes da nossa visão, leia o documento [PHILOSOPHY.md](PHILOSOPHY.md).

---

## 🧰 Suíte de Módulos (Libraries)

A suíte engloba a biblioteca principal **Standard BSD Library** (`-lsbl`) e um conjunto de bibliotecas focadas em tarefas específicas:

### Standard BSD
* **SBL** (`-lsbl`): Standard BSD Library (biblioteca principal do ecossistema).

### Security & Data
* **SACL** (`-lsacl`): Simple Authentication Credential Library.
* **SDBL** (`-lsdbl`): Simple DataBase Library.

### Mathematical & Optimization
* **SML** (`-lsml`): Simple Mathematical Library.
* **SORL** (`-lsorl`): Simple Operations Research Library.

### Network & Web
* **SNL** (`-lsnl`): Simple Network Library.
* **SWL** (`-lswl`): Simple Web Library.

### System & Concurrency
* **SCL** (`-lscl`): Simple Concurrency Library.
* **SFL** (`-lsfl`): Simple Filesystem Library.

### Utilities & Testing
* **SLL** (`-lsll`): Simple Logging Library.
* **SPL** (`-lspl`): Simple Parsing Library.
* **SUTL** (`-lsutl`): Simple Unit Testing Library.

---

## 🛠️ Requisitos de Compilação & Ferramentas

- **Compilador C**: Compatível com o padrão **C23** (`-std=c23`, ex: GCC 13+ ou Clang 16+).
- **Sistema de Make**: **`bmake`** (o `make` padrão do NetBSD / FreeBSD).

```bash
# Exemplo de compilação utilizando bmake
bmake
```

---

## ⚖️ Licença

Este projeto é distribuído sob a licença **BSD 3-Clause**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
