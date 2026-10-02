# Roadmap & Backlog Técnico: SBL

> Planejamento estratégico e status de desenvolvimento dos 4 módulos canônicos da **Standard BSD Library**.

---

## 1. Módulo Core: Estruturas de Dados & Algoritmos (`<sbl/algo.h>`)

- [ ] Implementar vetor dinâmico tipado (`sbl_vec`) com capacidade geométrica e `<stdckdint.h>`.
- [ ] Implementar Hash Map Robin Hood (`sbl_map`) com busca em tempo amortizado $O(1)$.
- [ ] Implementar Fila de Prioridade / Heap Binário (`sbl_heap`).
- [ ] Implementar Buffer Circular (`sbl_ring`) sem alocação em regime estacionário.
- [ ] Implementar algoritmos de ordenação rápida (pdqsort) e busca binária.

---

## 2. Módulo PRNG: Pseudo-Random Number Generators (`<sbl/prng.h>`)

- [ ] Implementar gerador PCG64 (`sbl_pcg64`) para simulações e games.
- [ ] Implementar gerador Xoshiro256++ (`sbl_xoshiro256pp`) para throughput massivo de 64 bits.
- [ ] Implementar gerador SplitMix64 (`sbl_splitmix64`) para inicialização de sementes.
- [ ] Implementar inicialização segura via `getentropy()` / `/dev/urandom`.
- [ ] Benchmark comparativo comprovando superioridade sobre o `rand()` da libc.

---

## 3. Módulo Crypto: Hashing Leve & Cifras (`<sbl/crypto.h>`)

- [ ] Implementar digest BLAKE3 (`sbl_blake3`).
- [ ] Implementar cifra de fluxo ChaCha20 (`sbl_chacha20`).
- [ ] Implementar digest SHA-256 (`sbl_sha256`) para compatibilidade e verificação.
- [ ] Suporte a hashing de senhas e autenticação de mensagens (MAC).

---

## 4. Módulo Compressão: Codecs Leves (`<sbl/zip.h>`)

- [ ] Implementar compressor streaming DEFLATE / Zip.
- [ ] Implementar descompressor com baixo consumo de memória estática.
- [ ] Suporte a leitura de arquivos compactados diretamente da memória.

---

## 5. Infraestrutura & Build

- [ ] Makefile POSIX silencioso compatível com `bmake` e `gmake`.
- [ ] Suporte a compilação dual: `libsbl.a` (estática) e `libsbl.so` (dinâmica).
- [ ] Quality gates locais e testes automatizados (`make test`).
