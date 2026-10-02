# Standard BSD Libraries (SBL)

[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg?logo=open-source-initiative&logoColor=white)](LICENSE)
[![C Standard: C23](https://img.shields.io/badge/C_Standard-C23-blue.svg?logo=c&logoColor=white)](PHILOSOPHY.md)
[![POSIX: 2024](https://img.shields.io/badge/POSIX-2024-purple.svg?logo=freebsd&logoColor=white)](PHILOSOPHY.md)
[![Build: bmake / POSIX](https://img.shields.io/badge/Build-bmake_%2F_POSIX-orange.svg?logo=gnu-make&logoColor=white)](Makefile)
[![Linkage: Static & Dynamic](https://img.shields.io/badge/Linkage-Static_%26_Dynamic-green.svg)](Makefile)

O **Standard BSD Libraries (SBL)** é uma biblioteca padrão moderna, modular e de alta performance para a linguagem C (padrão **C23**), projetada para expandir o ecossistema C onde a biblioteca padrão clássica é arcaica, limitada ou insegura, **sem inflar o binário e sem reinventar o sistema operacional**.

---

## A Filosofia: A "STL do C++" para C Puro (com Estabilidade SDL e Jeito POSIX)

O **SBL** nasceu com uma ambição clara: fornecer a ergonomia e o poder da **STL do C++** (vetores, dicionários, algoritmos, heaps) para quem ama e programa em **C puro**, mantendo o design minimalista, a estabilidade inabalável da **SDL** e a disciplina do **jeito POSIX**.

### O Quarteto da Harmonia: `libc + POSIX + SDL + SBL`

Em projetos construídos sob esta filosofia, nunca existe a dúvida: _"Devo usar SDL ou SBL? POSIX ou SBL?"_. As quatro camadas são **rigorosamente complementares e não concorrentes**:

| Camada             | Papel Fundamental            | O que resolve                                                                                      | O que NÃO faz                                                                    |
| :----------------- | :--------------------------- | :------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------- |
| **`libc + POSIX`** | **O Sistema Operacional**    | Sockets de rede, arquivos, VFS, chamadas de sistema, threads (`pthread`) e sinais                  | Não provê estruturas de dados genéricas de alto desempenho nem PRNGs modernos    |
| **`SDL (SDL3)`**   | **Hardware & Multimídia**    | Janelas nativas, display GPU (`SDL_GPU`), eventos de input, áudio (`SDL_Sound`) e periféricos      | Não implementa algoritmos de propósito geral, hash tables ou compressão de dados |
| **`SBL`**          | **Algoritmos & Utilitários** | Vetores dinâmicos tipados em C23, hash tables Robin Hood, PRNGs (PCG64/Xoshiro), crypto leve e Zip | Não cria camadas artificiais sobre o kernel, threads, rede ou janelas            |

Nenhuma biblioteca invade o espaço da outra. Usar **`libc + POSIX + SDL + SBL`** é ter o ferramental completo de engenharia de software contemporânea em C23 sem depender de frameworks gigantescos ou runtimes alienígenas.

---

## Os 4 Módulos Centrais

```text
sbl/
├── sbl.h          # Header guarda-chuva canônico
├── algo.h         # Estruturas de dados & algoritmos genéricos C23
├── prng.h         # PRNGs de alta velocidade & qualidade estatística
├── crypto.h       # Hashing criptográfico leve & ciphers modernos
└── zip.h          # Compressão rápida (DEFLATE / LZ4-style)
```

### 1. Estruturas de Dados & Algoritmos (`<sbl/algo.h>`)

- Vetores dinâmicos tipados com controle estrito de capacidade e crescimento geométrico.
- Tabelas hash com _open addressing_ e resolução Robin Hood / Swiss Tables para latência previsível de busca $O(1)$.
- Filas de prioridade (Binary Heaps) e buffers circulares sem alocação em regime estacionário.
- Imunidade a overflow aritmético utilizando primitivas nativas do C23 (`<stdckdint.h>`).

### 2. Geradores Pseudo-Aleatórios Modernos (`<sbl/prng.h>`)

O clássico `rand()` da libc é estatisticamente falho, lento e enviesado. O SBL substitui essa defasagem por implementações de ponta:

- **PCG64** (Permuted Congruential Generator): Perfeito para simulações e jogos de alta performance.
- **Xoshiro256++**: O estado da arte para throughput massivo em 64 bits.
- **SplitMix64**: Gerador determinístico rápido para inicialização e seeding.
- **Seeding Criptográfico**: Inicialização segura via `getentropy()` (BSD/Linux) ou `/dev/urandom`.

### 3. Criptografia & Hashing Leve (`<sbl/crypto.h>`)

Hashing veloz e primitivas criptográficas sem as centenas de megabytes de dependência do OpenSSL:

- **BLAKE3**: O padrão moderno de hashing criptográfico ultra-veloz.
- **ChaCha20**: Cifra de fluxo de alto desempenho para proteção local e CSPRNG.
- **SHA-256**: Digest canônico para integridade de arquivos e verificação.

### 4. Compressão & Arquivamento (`<sbl/zip.h>`)

- Compressor e descompressor streaming compatível com o formato DEFLATE/Zip.
- Codec leve para persistência rápida em disco com zero dependências externas.

---

## Filosofia & Pilares BSD

O projeto é guiado pelas qualidades fundamentais dos 4 grandes BSDs:

- **FreeBSD**: Foco em **eficiência**, baixa latência e linkagem estática (`libsbl.a`) ou dinâmica (`libsbl.so`).
- **OpenBSD**: Foco em **segurança**, auditoria visual e atributos `[[nodiscard]]` estritos.
- **NetBSD**: Foco em **portabilidade universal** e compatibilidade com `bmake`.
- **DragonFlyBSD**: Foco em **estruturas de dados amigáveis ao cache** e operações puras sem estado global.

Consulte [PHILOSOPHY.md](PHILOSOPHY.md) para o manifesto arquitetural completo.

---

## Compilação & Uso

O SBL foi concebido para ser consumido diretamente via `bmake` ou `make` POSIX:

```sh
# Compilar bibliotecas (estática e dinâmica)
make build

# Executar testes unitários
make test

# Instalar headers em /usr/local/include/sbl e biblioteca em /usr/local/lib
make install
```

Para linkar em seus projetos:

```sh
# Linkagem estática (zero dependências em runtime)
cc -std=c23 main.c -lsbl -o app

# Linkagem dinâmica
cc -std=c23 main.c -Wl,-Bdynamic -lsbl -o app
```

---

## Licença

Distribuído sob a licença soberana **BSD 3-Clause**. Veja o arquivo [LICENSE](LICENSE) para detalhes.
