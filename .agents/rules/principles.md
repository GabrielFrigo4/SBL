# Regras Canônicas de Domínio & Regras Locais: Standard BSD Libraries (SBL)

> Regras de governança estrita e restrições de arquitetura para agentes de IA operando no repositório **SBL** (`Personal/Systems/BSD Lib`).

---

## 1. O Padrão C23 & Qualidade do Código

1. **Compilação Estrita C23:** Todo código C deve utilizar exclusivamente primitivas contemporâneas do **C23** (`-std=c23`). É mandatório compilar limpo sem warnings com `-Wall -Wextra -Wpedantic -Wconversion -Werror`.
2. **Imunidade a Overflow Aritmético:** Toda operação de alocação dinâmica, cálculo de tamanho de buffer ou indexação deve utilizar primitivas de verificação de estouro de `<stdckdint.h>` (`ckd_add`, `ckd_mul`).
3. **Atributo `[[nodiscard]]` Obrigatório:** Toda função que aloca memória, retorna código de erro, status de operação ou ponteiro novo deve ser decorada com `[[nodiscard]]`.
4. **Tipagem Exata & Alinhamento:** Uso mandatório de `nullptr`, tipos de largura fixa de `<stdint.h>` (`uint64_t`, `size_t`) e ponteiros tipados opacos.

---

## 2. A Linha Vermelha do Sistema Operacional

1. **Proibição de Reimplantação de I/O e Rede:** O SBL **NÃO** deve criar wrappers ou reimplementar sockets, protocolos de rede, I/O de arquivos ou chamadas de sistema POSIX. O kernel e a libc POSIX cuidam disso.
2. **Proibição de Wrappers sobre Threads:** O subsistema `pthread` do POSIX é a autoridade nativa. O SBL provê apenas estruturas de dados e algoritmos reentrantes e thread-safe.
3. **Escopo Canônico dos 4 Módulos:** O código deve residir estritamente nos 4 domínios:
    - `<sbl/algo.h>`: Algoritmos e estruturas de dados dinâmicas.
    - `<sbl/prng.h>`: PRNGs modernos (PCG64, Xoshiro256++, SplitMix64).
    - `<sbl/crypto.h>`: Hashing criptográfico leve (BLAKE3, ChaCha20, SHA-256).
    - `<sbl/zip.h>`: Codecs de compressão streaming no formato DEFLATE/Zip.

---

## 3. Compilação, Linkagem & Invariantes

1. **Linkagem Dual:** Todo módulo deve ser compilável como biblioteca estática (`libsbl.a`) e dinâmica (`libsbl.so`).
2. **Compatibilidade `bmake`:** Makefiles devem ser estritamente compatíveis com o `bmake` do FreeBSD/NetBSD e com o `make` POSIX.
3. **Invariante Hermetismo de Produção:** Nenhuma linha de código em `src/` ou `include/` pode depender de `.agents/` ou skills. A deleção `rm -rf .agents` deve manter o repositório 100% funcional.
