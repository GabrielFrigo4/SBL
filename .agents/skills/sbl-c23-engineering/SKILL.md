---
name: sbl-c23-engineering
description: >-
    Runbook cognitivo e guia arquitetural para engenharia de software na Standard BSD Library (SBL).
    Use ao implementar ou auditar módulos em C23, estruturas de dados de alta densidade,
    geradores de números pseudo-aleatórios modernos (PCG64, Xoshiro256++, SplitMix64),
    hashing criptográfico leve (BLAKE3, ChaCha20, SHA-256) e codecs de compressão Zip em conformidade com bmake.
---

# SBL C23 Engineering Runbook

Este runbook instrui agentes de Inteligência Artificial no desenvolvimento de módulos da **Standard BSD Library (SBL)**, garantindo conformidade rigorosa com o padrão C23, segurança aritmética e alto throughput sem inchaço.

---

## 1. Padrões de Código em C23

### Aritmética Segura com `<stdckdint.h>`

Nunca realize multiplicações ou adições diretas de tamanhos ao alocar memória:

```c
#include <stdckdint.h>
#include <stdlib.h>

[[nodiscard]] void *sbl_alloc_array(size_t count, size_t elem_size) {
    size_t total_bytes;
    if (ckd_mul(&total_bytes, count, elem_size)) {
        return nullptr; /* Overflow detectado imediatamente */
    }
    return malloc(total_bytes);
}
```

### Atributos Modernos & Nullptr

- Use sempre `nullptr` em vez de `NULL` ou `0`.
- Decore funções de alocação e verificação com `[[nodiscard]]`.
- Use `constexpr` para constantes de compilação em vez de macros `#define`.

---

## 2. A Tríade de Geradores de Números Pseudo-Aleatórios (PRNGs)

O `rand()` da libc é proibido por ser enviesado e lento. O SBL provê 3 geradores de alta precisão:

| Gerador          |  Estado  |    Velocidade    | Uso Recomendado                                |
| :--------------- | :------: | :--------------: | :--------------------------------------------- |
| **PCG64**        | 128 bits |   Ultra-Rápido   | Jogos, simulações estatísticas, Monte Carlo    |
| **Xoshiro256++** | 256 bits | Máxima no x86_64 | Throughput linear massivo, permutações grandes |
| **SplitMix64**   | 64 bits  |   Instantâneo    | Seeding e inicialização de geradores maiores   |

### Seeding Seguro

Inicialize a semente consumindo o kernel via `getentropy(buf, sizeof(buf))` no FreeBSD/OpenBSD/Linux, com fallback defensivo para `/dev/urandom`.

---

## 3. Criptografia & Hashing Sem Bloat

- **BLAKE3:** O algoritmo padrão para cálculo de hash de alta velocidade, operando com arquitetura em árvore de Merkle.
- **ChaCha20:** Cifra de fluxo pura de 256 bits sem dependência de hardware AES dedicado, garantindo imunidade a ataques de temporização (_timing attacks_).
- **Sem dependência de OpenSSL:** Toda primitiva deve ser autocontida, com zero alocações na stack de criptografia.

---

## 4. Estruturas de Dados Dinâmicas (`<sbl/algo.h>`)

- **Robin Hood Hash Map:** Mantenha fator de carga $< 0.85$, armazenando distâncias de deslocamento (_probe distance_) para minimizar o pior caso de busca.
- **Vetor Geométrico:** Fator de crescimento $1.5\times$ ou $2\times$ controlado via `ckd_mul`.
- **Zero Estado Global:** Todas as funções devem receber o ponteiro de contexto explicitamente como primeiro parâmetro.
