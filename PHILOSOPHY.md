# Filosofia Arquitetural: Standard BSD Libraries (SBL)

O **Standard BSD Libraries (SBL)** existe para preencher a lacuna entre a biblioteca padrão do C clássico (ANSI/C99) e as necessidades contemporâneas de sistemas de alto desempenho em **C23**, sem se transformar em um monólito inflado.

Ele busca ser a **STL do C++**, só que leve, elegante e simples de usar em **C puro**, inspirando-se na estabilidade lendária da **SDL** e na disciplina do **jeito POSIX**.

---

## O Quarteto da Harmonia: `libc + POSIX + SDL + SBL`

O ecossistema é projetado para eliminar qualquer ambiguidade de fronteiras:

- **`libc + POSIX`:** O alicerce do sistema operacional. Gerencia arquivos, chamadas de sistema, processos, threads (`pthread`), sinais e sockets.
- **`SDL (SDL3)`:** A interface universal com o hardware multimídia. Gerencia janelas, display de GPU (`SDL_GPU`), eventos de periféricos e áudio (`SDL_Sound`).
- **`SBL`:** O arsenal de estruturas de dados e algoritmos de alta densidade. Fornece vetores dinâmicos, tabelas hash, PRNGs modernos, hashing leve e compactação Zip.

As camadas são **estritamente complementares e não concorrentes**. Nenhuma invade o escopo da outra.

---

## A Fronteira do Sistema Operacional (A Linha Vermelha)

A falha comum de muitos projetos de "biblioteca padrão alternativa" é tentar abstrair o que o sistema operacional já faz melhor do que qualquer um. O SBL estabelece uma linha clara:

1. **O que NÃO fazemos:**
    - **Não criamos abstrações sobre Threads:** O `pthread` do POSIX é o padrão ouro e não precisa de wrappers superficiais.
    - **Não criamos abstrações sobre Sockets e Rede:** O subsistema de rede do FreeBSD/Linux (`kqueue`, `epoll`, sockets BSD clássicos) pertence à camada de infraestrutura.
    - **Não criamos abstrações sobre o Filesystem:** O VFS do kernel e as chamadas POSIX (`openat`, `fstat`, `readlink`) são diretas e expressivas.
    - **Não reinventamos Gráficos ou Áudio:** Para periféricos, janelas e mídia, delegamos integralmente à **SDL3**.

2. **O que NÓS fazemos com maestria:**
    - Algoritmos e estruturas de dados de alta densidade informacional.
    - Geradores estatisticamente perfeitos de números pseudo-aleatórios (PRNGs).
    - Primitivas de hashing criptográfico e cifras leves.
    - Codecs de compressão sem dependências externas.

---

## O Padrão C23 & Segurança por Construção

O SBL adota **C23** (`-std=c23`) como baseline absoluto:

- **Imunidade a Overflow:** Cálculos de alocação e indexação utilizam primitivas com verificação de estouro de `<stdckdint.h>`.
- **Prevenção de Esquecimento:** Funções críticas de alocação e verificação são marcadas com o atributo `[[nodiscard]]`.
- **Tipagem Clara:** Uso de `nullptr`, tipos de largura exata de `<stdint.h>` e alinhamento via `<stdalign.h>`.
- **Zero-Cruft:** Proibição de macros opacas ou dialetos proprietários; todo código compila limpo com `-Wall -Wextra -Wpedantic -Wconversion`.

---

## Os 4 Pilares BSD

- **FreeBSD (Eficiência):** Layout de memória _cache-friendly_, estruturas de dados compactas e linkagem estática (`libsbl.a`) para binários autocontidos.
- **OpenBSD (Correção):** Auditoria direta de cada linha, código legível e fail-fast imediato em condições anômalas.
- **NetBSD (Portabilidade):** Conformidade rigorosa com POSIX.1-2024 e compilação nativa via `bmake`.
- **DragonFlyBSD (Concorrência Limpa):** Funções e algoritmos puramente reentrantes, thread-safe por ausência de variáveis estáticas globais.
