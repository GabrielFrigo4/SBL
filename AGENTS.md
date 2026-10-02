# 🤖 AGENTS.md — Diretrizes para Agentes de IA no SBL

Bem-vindo ao repositório **Standard BSD Libraries (SBL)** (`Personal/Systems/BSD Lib`). Este documento é a constituição primária e instrução mandatória para agentes de Inteligência Artificial operando nesta base de código.

---

## 1. Identidade e Papel

O **SBL** é uma biblioteca padrão moderna em C23 focada em estruturas de dados, algoritmos, PRNGs modernos, criptografia leve e compressão Zip.

- **Stack:** C23 estrito (`-std=c23`), POSIX.1-2024, `bmake` / make POSIX.
- **Fronteira:** O SBL **não** reimplementa threads, sockets, I/O de rede ou chamadas de filesystem (essas pertencem ao SO + libc POSIX).

---

## 2. Regras Críticas Soberanas

1. **Padrão C23 Estrito:** Código em C deve utilizar exclusivamente primitivas C23 (`<stdckdint.h>`, `nullptr`, `constexpr`, `[[nodiscard]]`). Compilação limpa com `-Wall -Wextra -Wpedantic -Wconversion`.
2. **Invariante Hermetismo de Produção:** A biblioteca e os testes NUNCA podem depender de `.agents/` ou skills. A invariante `rm -rf .agents` deve resultar em 100% de funcionamento.
3. **Invariante Out-of-the-Box:** Modos octais canônicos no Git Index (`0755` para scripts/hooks, `0644` para fontes/headers e documentação).
4. **Linkagem Dual:** O código deve compilar perfeitamente como biblioteca estática (`libsbl.a`) e dinâmica (`libsbl.so`).
5. **Zero Cruft:** Proibição de shims legados, macros proprietárias ou código morto.
6. **Commits Semânticos:** Mensagens no formato `<type>(<scope>): <descrição>` com os verbos autorizados.

---

## 3. Boy Scout Rule

Sempre deixe o acampamento mais limpo do que encontrou:

- [ ] Verifique vazamentos de memória com sanitizers (`-fsanitize=address,undefined`).
- [ ] Garanta que nenhum emoji polua títulos técnicos ou documentações formais.
- [ ] Valide formatação com `make lint` e `make format`.

---

## 4. Comandos de Verificação Rápidos

| Comando       | Descrição                                            |
| :------------ | :--------------------------------------------------- |
| `make help`   | Exibe o menu interativo com alvos disponíveis        |
| `make build`  | Compila as bibliotecas estática e dinâmica em build/ |
| `make test`   | Executa os testes unitários da suíte                 |
| `make format` | Formata C (clang-format) e Markdown (Prettier)       |
| `make lint`   | Valida formatação sem alterar arquivos               |
| `make hooks`  | Ativa os githooks locais com permissões 0755         |
| `make ci`     | Executa validação de lint e integridade              |

---

## 5. Referências Obrigatórias

- [Filosofia Arquitetural](PHILOSOPHY.md)
- [Roadmap Técnico](TODO.md)
- [Regras de Agentes](.agents/rules/principles.md)
