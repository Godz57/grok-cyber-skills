# Grok Cyber Skills — modo D (router + clone)

> Integra [mukul975/Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) (**817 skills**) no Grok **sem copiar o catálogo** pro seu monorepo.

| O que este kit faz | O que **não** faz |
|--------------------|-------------------|
| Clona a lib em `~/.grok/tools/cyber-skills` | Reescreve as 817 skills |
| Router: busca + carrega 1–3 skills sob demanda | Instala 817 skills always-on no Grok |
| Gate legal (só uso autorizado) | Runtime de pentest (use Strix/pentest) |

## Por que modo D

- Progressive disclosure: frontmatter barato → carrega só o necessário  
- `git pull` no toolkit = atualização do upstream  
- Zero ruído no menu de skills do Grok  

## Install

```powershell
cd grok-cyber-skills
.\scripts\install.ps1
# atualizar depois: .\scripts\install.ps1 -Update
```

```bash
./scripts/install.sh
./scripts/install.sh update
```

Isso:

1. Copia skill `cyber` + commands pro `~/.grok`  
2. Clona o repositório das 817 skills em `~/.grok/tools/cyber-skills`  

## Uso

```
/cyber-status              # toolkit + contagem
/cyber-find memory lsass   # busca no index.json
/cyber-run performing-memory-forensics-with-volatility3
/cyber-domain forensics    # lista por palavra no path/name/description
/cyber                     # router
```

Linguagem natural: *“usa cyber skills pra analisar dump de memória”* → o skill `cyber` busca e carrega.

## Legal

Conteúdo dual-use / ofensivo existe na lib.  
**Só** em sistemas próprios, lab autorizado ou com **autorização escrita**.  
O router recusa alvos de terceiro ambíguos.

## Companions

| Kit | Papel |
|-----|--------|
| [grok-pentest](https://github.com/Godz57/grok-pentest) | OWASP vibe apps + scripts |
| [grok-strix](https://github.com/Godz57/grok-strix) | Pentest agentic PoC |
| [grok-craftsman](https://github.com/Godz57/grok-craftsman) | Qualidade de código |
| **cyber-skills** | Playbooks SOC/DFIR/cloud/red team… |

## Upstream

- https://github.com/mukul975/Anthropic-Cybersecurity-Skills  
- Apache 2.0 · projeto comunitário (não afiliado à Anthropic)

## License

MIT (wrapper). O clone do upstream mantém Apache-2.0.
