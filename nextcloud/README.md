# Nextcloud + OnlyOffice com Docker Compose

Este projeto sobe uma stack completa com:

- Nextcloud
- MariaDB
- Redis
- OnlyOffice Document Server

Os serviços foram definidos no arquivo [compose.yaml](compose.yaml) e usam variáveis de ambiente a partir de um arquivo `.env`.

## Requisitos

- Docker
- Docker Compose

## Arquivos

- [compose.yaml](compose.yaml): serviços da stack
- [.env.example](</e:/STACKS/nextcloud/.env.example>): exemplo de configuração

## Como usar

1. Crie seu arquivo `.env` a partir do exemplo:

```powershell
Copy-Item .env.example .env
```

2. Edite o arquivo `.env` e troque as senhas padrão:

- `MYSQL_ROOT_PASSWORD`
- `MYSQL_PASSWORD`
- `NEXTCLOUD_ADMIN_PASSWORD`
- `ONLYOFFICE_JWT_SECRET`

3. Suba os containers:

```powershell
docker compose up -d
```

4. Acesse os serviços:

- Nextcloud: `http://localhost:8080`
- OnlyOffice: `http://localhost:8081`

## Variáveis principais

| Variável | Descrição | Valor padrão |
| --- | --- | --- |
| `MYSQL_ROOT_PASSWORD` | Senha do root do MariaDB | `change-me-root` |
| `MYSQL_DATABASE` | Nome do banco do Nextcloud | `nextcloud` |
| `MYSQL_USER` | Usuário do banco | `nextcloud` |
| `MYSQL_PASSWORD` | Senha do usuário do banco | `change-me-db` |
| `NEXTCLOUD_ADMIN_USER` | Usuário administrador inicial | `admin` |
| `NEXTCLOUD_ADMIN_PASSWORD` | Senha do administrador inicial | `change-me-admin` |
| `NEXTCLOUD_TRUSTED_DOMAINS` | Domínios confiáveis do Nextcloud | `localhost 127.0.0.1` |
| `NEXTCLOUD_PORT` | Porta publicada do Nextcloud | `8080` |
| `ONLYOFFICE_PORT` | Porta publicada do OnlyOffice | `8081` |
| `ONLYOFFICE_JWT_ENABLED` | Habilita JWT no OnlyOffice | `true` |
| `ONLYOFFICE_JWT_SECRET` | Segredo JWT usado na integração | `change-me-jwt` |

## Integração do OnlyOffice no Nextcloud

Depois que os containers estiverem no ar:

1. Entre no painel do Nextcloud com o usuário administrador.
2. Instale o app `ONLYOFFICE`.
3. Abra as configurações do app.
4. Configure o endereço do serviço de documentos como:

```text
http://onlyoffice/
```

5. Configure o JWT com o mesmo valor definido em `ONLYOFFICE_JWT_SECRET`.

## Comandos úteis

Subir a stack:

```powershell
docker compose up -d
```

Ver logs:

```powershell
docker compose logs -f
```

Parar a stack:

```powershell
docker compose down
```

Parar e remover volumes:

```powershell
docker compose down -v
```

## Persistência de dados

Os dados ficam armazenados em volumes Docker:

- `db_data`
- `redis_data`
- `nextcloud_data`
- `onlyoffice_data`
- `onlyoffice_logs`
- `onlyoffice_lib`
- `onlyoffice_db`

## Observações

- Esta configuração é adequada para ambiente local, laboratório ou homologação.
- Para produção, use HTTPS com proxy reverso e ajuste `NEXTCLOUD_TRUSTED_DOMAINS` para o domínio real.
- O valor de `ONLYOFFICE_JWT_SECRET` deve ser forte e mantido igual no Nextcloud e no OnlyOffice.
