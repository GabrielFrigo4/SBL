# Filosofia do Projeto: Standard BSD Libraries (SBL)

O **Standard BSD Libraries (SBL)** nasceu para ser uma suíte completa, moderna e modular de bibliotecas para a linguagem C, acabando com a necessidade de reescrever utilitários básicos ou passar por "dores de cabeça com bobeiras" no desenvolvimento em C.

---

## 💡 O Nome, Referências e Integração com a SDL

O acrônimo **SBL** faz referência proposital a dois ícones do desenvolvimento de software:
- **STL** (*Standard Template Library* do C++): A ideia de ser uma biblioteca padrão rica, utilitária e abrangente.
- **SDL** (*Simple DirectMedia Layer*): A sonoridade e a simplicidade de integração.

> 📌 **Nota sobre Multimídia, Gráficos e Periféricos**:
> O SBL **não** reinventará a roda em tarefas de baixo nível relativas a janelas, áudio, GPU/Vulkan/OpenGL, teclado, mouse ou webcams. Toda essa infraestrutura de mídia e periféricos é deliberadamente delegada à **SDL**, com a qual o SBL se integra perfeitamente.

O ecossistema mantém o padrão de nomenclatura curto **S<X>L** (como `-lsbl`, `-lsel`, `-lstl`, `-lscl`, `-lsml`).

---

## 🎯 O Padrão da Linguagem: C23

Um dos pilares fundamentais do SBL é **nunca ficar preso ao passado**. O projeto adota estritamente a versão mais moderna do padrão C disponível — atualmente **C23** (`-std=c23`). Aproveitamos os novos recursos, tipos, melhorias de sintaxe e segurança trazidos pelo C23 para entregar código limpo e expressivo.

---

## 🛡️ Os 4 Pilares das Filosofias BSD

O SBL herda e combina as melhores filosofias dos quatro grandes sistemas operacionais BSD:

1. ⚡ **FreeBSD — Ser Eficiente**:
   Foco em alto desempenho, uso racional de memória e throughput máximo em cada função disponibilizada.

2. 🔒 **OpenBSD — Ser Simples, Auditável e Seguro**:
   Código claro, sem trechos obscuros, escrito com mentalidade *secure-by-default*, fácil de auditar e livre de vulnerabilidades comuns.

3. 🌐 **NetBSD — Ser Portável**:
   Estar pronto para rodar em qualquer lugar. O código deve ser limpo e aderente aos padrões para facilitar a portabilidade entre arquiteturas e sistemas operacionais.

4. 🚀 **DragonFlyBSD — Sem travas para o paralelo e sem medo de arquitetar o futuro**:
   Arquitetura preparada para concorrência moderna, evitando travamentos desnecessários (lockless/parallel-first) e sem medo de inovar ou buscar as melhores estruturas possíveis.

---

## 🛠️ Ferramental de Build

Seguindo a tradição Unix/BSD, todo o sistema de compilação dos Makefiles da suíte SBL é construído utilizando o **`bmake`** (o `make` tradicional do NetBSD e FreeBSD).
