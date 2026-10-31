# 🤖 Standard BSD Libraries (SBL) — AI Agent Briefing

> Biblioteca padrão moderna em C23 focada em estruturas de dados, algoritmos, PRNGs modernos, criptografia leve e compressão Zip.

---

## 🧭 Identidade e Papel

O **SBL** é uma biblioteca padrão moderna em C23 focada em estruturas de dados, algoritmos, PRNGs modernos, criptografia leve e compressão Zip.

- **Stack Primária:** C23 estrito (`-std=c23`), POSIX.1-2024, `bmake` / make POSIX
- **Fronteira:** O SBL **não** reimplementa threads, sockets, I/O de rede ou chamadas de filesystem (essas pertencem ao SO + libc POSIX)

---

## 📁 Estrutura Canônica de Arquivos

```text
BSD Lib/
├── .agents/                   # Governança e runbooks locais de IA
├── AGENTS.md                  # Constituição e briefing para agentes de IA
├── LICENSE                    # Licença BSD-3-Clause
├── Makefile                   # Orquestrador POSIX silencioso
├── PHILOSOPHY.md              # Filosofia arquitetural das bibliotecas BSD
├── PRINCIPLES.md              # 22 Princípios de Engenharia aplicados
├── README.md                  # Documentação técnica da SBL
└── TODO.md                    # Roadmap de desenvolvimento
```

---

## ⚠️ Regras Críticas para Agentes de IA

1. **Padrão C23 Estrito:** Código em C deve utilizar exclusivamente primitivas C23 (`<stdckdint.h>`, `nullptr`, `constexpr`, `[[nodiscard]]`). Compilação limpa com `-Wall -Wextra -Wpedantic -Wconversion`.
2. **Invariante Hermetismo de Produção:** A biblioteca e os testes NUNCA podem depender de `.agents/` ou skills. A invariante `rm -rf .agents` deve resultar em 100% de funcionamento.
3. **Invariante Out-of-the-Box:** Modos octais canônicos no Git Index (`0755` para scripts/hooks, `0644` para fontes/headers e documentação).
4. **Linkagem Dual:** O código deve compilar perfeitamente como biblioteca estática (`libsbl.a`) e dinâmica (`libsbl.so`).
5. **Zero Cruft:** Proibição de shims legados, macros proprietárias ou código morto.
6. **Commits Semânticos:** Mensagens no formato `<type>(<scope>): <descrição>` com os verbos autorizados.

---

## 🛡️ Regra da Proatividade e Correção Contínua (Boy Scout Rule)

O agente de IA atua de forma proativa na manutenção e aplicação dos padrões canônicos deste repositório.

Ao identificar linhas ou artefatos fora dos padrões estabelecidos:

1. **Notificar concisamente** o usuário sobre o ajuste realizado.
2. **Corrigir a inconformidade**, aplicando o padrão correspondente:
    - **Comentários Narrativos:** Eliminar comentários óbvios que apenas narram código executável.
    - **Banners Estruturais:** Ajustar réguas para exatamente 64 hífens no topo ou 32 caracteres com `### ` no corpo.
    - **Portabilidade POSIX:** Substituir bashismos (`[[ ]]`, `&>`, arrays, `source`) por sintaxe estrita POSIX `/bin/sh`.
    - **Shebang Universal:** Garantir sempre `#!/usr/bin/env sh` ou `#!/usr/bin/env python3`.
    - **Sequências ANSI & Escapes:** Não use octais (`\033`, `\001`) para caracteres ou escapes. Use `[ -t 1 ] && echo -n $'\e...'` ou notação hexadecimal (`\x01`, `\x1b`). Octal é exclusivo para permissões POSIX (`chmod 0755`, `chmod 0644`, `umask`).
    - **Redirecionamento Seguro:** Envolver destinos em aspas duplas (ex: `> "/dev/null" 2>&1`).
    - **Makefiles:** Assegurar cabeçalho `.POSIX: .SILENT:`, `MAKEFLAGS += --no-print-directory -s`, alinhamento estético de variáveis e zero `@` redundante.
    - **Permissões Canônicas:** Aplicar 4 dígitos octais (`chmod 0755`, `chmod 0644`, `chmod 0700`, `chmod 0600`).
    - **Invariante Out-of-the-Box:** Garantir modos octais corretos no Git Index e auto-cura em tempo de execução sem requerer intervenção manual pós-clone.
    - **Emissão Semântica de UI:** Substituir `echo` avulsos com emojis pelas rotinas canônicas `_ui_*`.
    - **Antifragilidade & Resiliência:** Resolução ativa de caminhos em cascata, auto-cura de permissões (0600 em chaves/segredos) e validação defensiva de pré-requisitos.
    - **Curadoria Cognitiva:** Capturar decisões estruturais e regras tácitas em skills locais compactas (`.agents/skills/`), mantendo-as atualizadas e expurgando ruído obsoleto.
    - **Refatoração Sem Legado:** Expurgar aliases obsoletos, variáveis mortas e shims de compatibilidade em renomeações.
    - **Elevação Antifrágil & Shift Seguro:** Usar o bloco explícito `if [ "$(id -u)" -ne 0 ]` para resolução de `ELEVATE` (evitando término fatal sob `set -e` como root) e proteger todo comando `shift` com validação prévia de parâmetros (`[ "$#" -ge N ] && shift N`).
    - **Simetria de Documentação:** Mover regras ou invariantes universais documentadas erroneamente em sub-membros específicos para o documento de arquitetura do grupo correspondente, eliminando falsas assimetrias.

---

## 🚀 Comandos de Verificação Rápida (Quality Gates)

| Comando             | Finalidade Operacional                                 |
| :------------------ | :----------------------------------------------------- |
| `make help`         | Exibe o menu interativo com alvos disponíveis          |
| `make build`        | Compila as bibliotecas estática e dinâmica em `build/` |
| `make static`       | Compila apenas a biblioteca estática `build/libsbl.a`  |
| `make dynamic`      | Compila apenas a biblioteca dinâmica `build/libsbl.so` |
| `make test`         | Executa os testes unitários da suíte                   |
| `make format`       | Formata fontes C (clang-format) e Markdown Prettier    |
| `make clang-format` | Formata apenas os fontes C com clang-format            |
| `make prettier`     | Formata arquivos Markdown com Prettier                 |
| `make lint`         | Valida formatação sem alterar arquivos                 |
| `make hooks`        | Ativa os githooks locais com permissões `0755`         |
| `make ci`           | Executa validação de lint e integridade                |
| `make install`      | Instala a biblioteca em prefixo do sistema             |
| `make clean`        | Remove artefatos de compilação em `build/`             |

---

## 📖 Referências Obrigatórias

Antes de qualquer modificação neste ecossistema, consulte:

- [README.md](README.md) — Documentação técnica da Standard BSD Libraries
- [PHILOSOPHY.md](PHILOSOPHY.md) — Filosofia arquitetural das bibliotecas BSD
- [PRINCIPLES.md](PRINCIPLES.md) — Os 22 Princípios de Engenharia Soberanos
- [TODO.md](TODO.md) — Roadmap de desenvolvimento
- [LICENSE](LICENSE) — Licença BSD-3-Clause
- [.agents/rules/principles.md](.agents/rules/principles.md) — Regra de Princípios
- [.agents/skills/sbl-c23-engineering/SKILL.md](.agents/skills/sbl-c23-engineering/SKILL.md) — Runbook de Engenharia em C23
