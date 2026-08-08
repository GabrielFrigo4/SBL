# Filosofia do Projeto: Standard BSD Libraries (SBL)

O **Standard BSD Libraries (SBL)** nasceu para ser uma suíte completa, moderna e modular de bibliotecas para a linguagem C, acabando com a necessidade de reescrever utilitários básicos ou passar por "dores de cabeça com bobeiras" no desenvolvimento em C.

---

## 💡 O Nome, Referências e Integração com a SDL

O acrônimo **SBL** faz referência proposital a dois ícones do desenvolvimento de software:
- **STL** (**Standard Template Library** do C++): A ideia de ser uma biblioteca padrão rica, utilitária e abrangente.
- **SDL** (**Simple DirectMedia Layer**): A sonoridade e a simplicidade de integração.

> 📌 **Nota sobre Multimídia, Gráficos e Periféricos**:
> O SBL **não** reinventará a roda em tarefas de baixo nível relativas a janelas, áudio, GPU/Vulkan/OpenGL, teclado, mouse ou webcams. Toda essa infraestrutura de mídia e periféricos é deliberadamente delegada à **SDL** (**Simple DirectMedia Layer**), com a qual o SBL se integra perfeitamente.

O ecossistema mantém o padrão de nomenclatura curto **S<X>L** (como `-lsbl`, `-lsel`, `-lsgl`, `-lstl`, `-lscl`, `-lsml`).

---

## 🎯 O Padrão da Linguagem: C23

Um dos pilares fundamentais do SBL é **nunca ficar preso ao passado**. O projeto adota estritamente a versão mais moderna do padrão C disponível — atualmente **C23** (`-std=c23`). Aproveitamos os novos recursos, tipos, melhorias de sintaxe e segurança trazidos pelo C23 para entregar código limpo e expressivo.

---

## 🛡️ Os 4 Pilares das Filosofias BSD

O SBL herda e combina os 4 grandes pilares dos sistemas operacionais BSD em frases de efeito equilibradas:

1. ⚡ **FreeBSD — Ser Eficiente**:
   Foco em alto desempenho, throughput máximo e uso inteligente de memória.

2. 🔒 **OpenBSD — Ser Seguro e Auditável**:
   Código simples, transparente, sem trechos obscuros e seguro por padrão.

3. 🌐 **NetBSD — Ser Universalmente Portável**:
   Código limpo e padronizado pronto para rodar em qualquer plataforma ou arquitetura.

4. 🚀 **DragonFlyBSD — Ser Paralelo e Inovador**:
   Concorrência moderna sem travas (lockless) e liberdade para projetar o futuro.

---

## 🛠️ Ferramental de Build

Seguindo a tradição Unix/BSD, todo o sistema de compilação dos Makefiles da suíte SBL é construído utilizando o **`bmake`** (o `make` tradicional do NetBSD e FreeBSD).
