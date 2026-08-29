# File Browser - Docker

Gerenciador de arquivos web leve, pronto para uso com `docker compose up -d`.

* **Imagem:** `filebrowser/filebrowser:latest`
* **Porta:** `8087` (host) -> `80` (container)
* **Acesso padrão:** `http://localhost:8087` | `admin` / `123456789@qwe`

## Estrutura

```
filebrowser/
├── compose.yaml   # orquestração (sem entrypoint.sh externo)
├── instalar.sh    # instalador automatizado idempotente
├── files/         # arquivos expostos em /srv
├── database/      # filebrowser.db
└── config/        # settings.json
```

## Pré-requisitos

* Docker Engine 20.10+ e plugin `docker compose v2`
* Porta `8087` livre (ou ajuste no `compose.yaml:7`)

```bash
docker --version
docker compose version
```

## Instalação Rápida (recomendado)

```bash
chmod +x instalar.sh
./instalar.sh
```

O script faz:
1. Cria `files/`, `database/`, `config/`
2. Gera `compose.yaml` com `user: "0:0"` (evita `chmod: Operation not permitted`)
3. Ajusta permissões (`chmod 777` + `chown 1000:1000`)
4. Executa `docker compose up -d` com criação automática do admin
5. Valida status e exibe URL/credenciais

Reset total (recria admin e DB):

```bash
./instalar.sh --clean
```

## Instalação Manual

```bash
mkdir -p files database config
docker compose up -d
docker logs -f filebrowser
```

Acesse `http://IP-DO-SERVIDOR:8087`

> O `compose.yaml:15-33` já cria o usuário `admin` automaticamente no primeiro `up`. Não é necessário `entrypoint.sh` externo.

## Comandos Úteis

```bash
docker compose ps
docker logs filebrowser --tail 100
docker logs -f filebrowser
docker compose down        # parar
docker compose restart     # reiniciar
docker compose up -d --pull always  # atualizar imagem
```

Alterar senha/criar usuário:

```bash
docker exec filebrowser filebrowser users add meuuser 'minhasenha' --perm.admin --config /config/settings.json --database /database/filebrowser.db
docker exec filebrowser filebrowser users update admin --password 'novaSenha' --config /config/settings.json --database /database/filebrowser.db
```

## Troubleshooting

**`Restarting (1)` + `chmod: /database: Operation not permitted`**
> Corrigido na abordagem atual com `user: "0:0"` e `chmod ... || true` inline. Se vier de instalação antiga, remova `entrypoint.sh` e rode `./instalar.sh --clean`.

**Porta em uso**
```bash
ss -tlnp | grep 8087
# troque em compose.yaml:7 para "8088:80" e refaça up -d
```

**CRLF no Windows**
> `entrypoint.sh`/`instalar.sh` devem estar em `LF`. O `instalar.sh` e o `compose.yaml` atuais já estão normalizados. Se editar no Windows, use `sed -i 's/\r$//' arquivo`.

**Permissão em `/dados` (host root)**
```bash
chmod -R 777 files database config
chown -R 1000:1000 files database config  # opcional
```

## Backup

```bash
tar -czf backup-filebrowser-$(date +%F).tgz files database config compose.yaml
```

## Atualização

```bash
docker compose pull
docker compose up -d
```

## Segurança

Troque a senha padrão após o primeiro acesso em `Configurações > Usuários`. Para produção, considere expor via reverse proxy (Nginx/Traefik) com HTTPS.
