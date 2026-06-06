# Vaultwarden com Nginx + SSL (Ambiente Local)

## Pré-requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) para Windows (com backend WSL2)
- [OpenSSL](https://slproweb.com/products/Win32OpenSSL.html) — ou use o que vem com [Git Bash](https://git-scm.com/)

## Estrutura

```
vaultwarden/
├── docker-compose.yml
├── myconfig.conf
├── nginx/
│   └── nginx.conf
├── ssl/
│   ├── vaultwarden.crt
│   └── vaultwarden.key
└── README.md
```

## Passo a passo

### 1. Gerar o certificado SSL autoassinado

Abra um terminal (PowerShell, CMD ou Git Bash) na pasta `C:\Users\Marco\Desktop\SENHA` e execute:

```bash
openssl req -x509 -nodes -days 18250 -newkey rsa:4096 -keyout ssl/vaultwarden.key -out ssl/vaultwarden.crt -config myconfig.conf
```

Isso criará os arquivos `ssl/vaultwarden.crt` e `ssl/vaultwarden.key`.

### 2. Subir os containers

```bash
docker compose up -d
```

### 3. Acessar

Abra o navegador em: **https://localhost**

O navegador exibirá um aviso de segurança (certificado autoassinado). Clique em "Avançado" e "Prosseguir".

### 4. Acesso administrativo

Acesse **https://localhost/admin** e informe o `ADMIN_TOKEN` definido no `docker-compose.yml` para gerenciar usuários e configurações.

Para criar sua conta pessoal, vá em **https://localhost** e registre-se normalmente.

## Comandos úteis

| Comando | Descrição |
|---|---|
| `docker compose up -d` | Sobe os containers em segundo plano |
| `docker compose down` | Para e remove os containers |
| `docker compose logs -f` | Acompanha os logs em tempo real |
| `docker compose restart` | Reinicia os containers |

## Personalização

Para usar um IP fixo no lugar de `localhost`, edite os arquivos:

- `myconfig.conf` — campos `CN` e `IP.1`
- `nginx/nginx.conf` — `server_name`
- `docker-compose.yml` — `DOMAIN`

Depois regenere o certificado e recrie os containers.

## Migrar para outro computador

1. Copie a pasta `vaultwarden` inteira para o outro computador (pendrive, rede, etc.)
2. No novo computador, instale o [Docker Desktop](https://www.docker.com/products/docker-desktop/)
3. Abra um terminal na pasta copiada e execute:

```bash
docker compose up -d
```

**Importante:** O certificado SSL já está incluído na pasta `ssl/` e funciona em qualquer máquina, desde que o acesso seja via `localhost`. Se for usar um IP diferente, gere um novo certificado (veja "Personalização").
