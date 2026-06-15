# HomeLab Dashboard

Dashboard centralizado para todos os serviços Docker do homelab, usando [Homepage](https://gethomepage.dev/).

Acesso: [http://localhost:8082](http://localhost:8082)

---

## Serviços

### Dashboard (Homepage)

Painel centralizado para acessar todos os serviços do homelab.

| Recurso     | Detalhe                     |
| ----------- | --------------------------- |
| Web         | http://localhost:8082       |
| Container   | `homepage_dashboard`        |
| Config      | `./dashboard/config/`       |

---

### Gitea

Servidor Git leve e auto-hospedado, alternativa ao GitHub. Gerencia repositórios privados, issues, wikis e pull requests.

| Recurso     | Detalhe                 |
| ----------- | ----------------------- |
| Web         | http://localhost:3001   |
| SSH         | ssh -p 222 git@localhost |
| Container   | `gitea_server`          |
| Banco       | SQLite3 (interno)       |
| Persistência| `./gitea/`              |

---

### Jellyfin

Servidor de streaming de mídia. Organiza e reproduz filmes, séries, músicas e vídeos via navegador ou apps (Android, TV, Windows).

| Recurso     | Detalhe                   |
| ----------- | ------------------------- |
| Web         | http://localhost:8096     |
| Container   | `jellyfin`                |
| Mídia       | `./media/`                |
| Config      | `./config/`               |

---

### MeTube

Downloader de vídeos e áudios do YouTube e outras plataformas via interface web.

| Recurso      | Detalhe                   |
| ------------ | ------------------------- |
| Web          | http://localhost:8085     |
| Container    | `metube`                  |
| Downloads    | `./downloads/`            |
| Áudio        | `./audio-downloads/`      |

---

### Vaultwarden

Gerenciador de senhas auto-hospedado compatível com Bitwarden. Acesso via HTTPS com certificado SSL próprio.

| Recurso      | Detalhe                    |
| ------------ | -------------------------- |
| Web          | https://localhost          |
| Web (LAN)    | https://192.168.2.100      |
| Container    | `vaultwarden`              |
| Proxy        | `nginx-proxy` (porta 443)  |

---

### Nextcloud + OnlyOffice

Plataforma de colaboração e armazenamento em nuvem com suíte de edição de documentos integrada.

| Recurso        | Detalhe                   |
| -------------- | ------------------------- |
| Nextcloud      | http://localhost:8080     |
| OnlyOffice     | http://localhost:8081     |
| Container app  | `nextcloud-app`           |
| Container db   | `nextcloud-db`            |
| Redis          | `nextcloud-redis`         |
| Container ods  | `onlyoffice-documentserver` |

**Integração OnlyOffice:**
1. Instale o app ONLYOFFICE no Nextcloud
2. Configure o endpoint: `http://onlyoffice/`
3. Use o mesmo `JWT_SECRET` do `.env`

---

### WordPress + MySQL + phpMyAdmin

Gerenciador de conteúdo para criação de sites e blogs, com banco MySQL e phpMyAdmin para administração.

| Recurso      | Detalhe                    |
| ------------ | -------------------------- |
| WordPress    | http://localhost:9081      |
| phpMyAdmin   | http://localhost:9082      |
| Container WP | `wordpress_app`            |
| Container db | `wordpress_db`             |
| MySQL port   | `3306` (host)              |

**Backup automático:** diário às 02:00 em `./backups/` (retém 7 dias).

---

### XAMPP (Apache + PHP + MySQL + MailHog)

Ambiente de desenvolvimento PHP local com Apache 8.2, MySQL, phpMyAdmin e MailHog.

| Recurso        | Detalhe                    |
| -------------- | -------------------------- |
| Apache         | http://localhost:9080      |
| phpMyAdmin     | http://localhost:9077      |
| MailHog        | http://localhost:8025      |
| Container apache | `xampp-apache`           |
| Container mysql  | `xampp-mysql`            |
| MySQL port     | `3307` (host)              |
| Raiz web       | `./site/`                  |

---

### AdGuard Home

Servidor DNS com bloqueio de anúncios e rastreadores.

| Recurso      | Detalhe                    |
| ------------ | -------------------------- |
| Admin        | http://localhost:3000      |
| DNS          | porta 53 (UDP/TCP)         |
| Container    | `adguardhome`              |
| Config       | `./adguard/conf/`          |

---

### Immich

Gerenciamento de fotos e vídeos auto-hospedado, alternativa ao Google Fotos.

| Recurso          | Detalhe                       |
| ---------------- | ----------------------------- |
| Web              | http://localhost:2283         |
| Container server | `immich-server`               |
| Container db     | `immich-database` (PostgreSQL)|
| Uploads          | `./immich/volumes/upload/`    |

---

### Paperless-ngx

Sistema de gerenciamento de documentos. Organiza, indexa e disponibiliza busca em documentos digitalizados.

| Recurso          | Detalhe                            |
| ---------------- | ---------------------------------- |
| Web              | http://localhost:8000              |
| Container server | `paperless-webserver`              |
| Container db     | `paperless-db` (PostgreSQL)        |
| Pasta consumo    | `./paperless/volumes/consume/`     |

---

### Stirling PDF

Ferramenta web para operações em PDF: divisão, união, conversão, compressão e OCR.

| Recurso           | Detalhe                     |
| ----------------- | --------------------------- |
| Web               | http://localhost:8090       |
| Container         | `stirling-pdf`              |

---

## Tabela de Portas

| Serviço            | Porta     |
| ------------------ | --------- |
| Homepage Dashboard | 8082      |
| AdGuard Home       | 3000      |
| AdGuard DNS        | 53        |
| Gitea              | 3001      |
| Gitea SSH          | 222       |
| Immich             | 2283      |
| Jellyfin           | 8096      |
| MeTube             | 8085      |
| Nextcloud          | 8080      |
| OnlyOffice         | 8081      |
| Paperless-ngx      | 8000      |
| Stirling PDF       | 8090      |
| WordPress          | 9081      |
| phpMyAdmin (WP)    | 9082      |
| XAMPP Apache       | 9080      |
| XAMPP phpMyAdmin   | 9077      |
| XAMPP MySQL        | 3307      |
| XAMPP MailHog      | 8025      |
| Vaultwarden        | 443       |

---

## Variáveis de Ambiente (.env)

O `.env` é opcional. Sem ele, os serviços usam valores fixos definidos nos `compose.yaml`:

| Serviço | Sem .env funciona? | Valores hardcoded atuais |
|---------|:------------------:|--------------------------|
| AdGuard Home | Sim | — |
| Dashboard | Sim | — |
| Gitea | Sim | — |
| Jellyfin | Sim | — |
| MeTube | Sim | — |
| Vaultwarden | Sim | `ADMIN_TOKEN` fixo |
| Nextcloud | Sim | `root_password_change_me`, `nextcloud_password_change_me`, `your_jwt_secret_change_me` |
| OnlyOffice | Sim | `your_jwt_secret_change_me` |
| Immich | Sim | `immich_password_change_me` |
| Paperless-ngx | Sim | `paperless_password_change_me`, `change_me_to_a_random_secret_key` |
| Stirling PDF | Sim | — |
| WordPress | Sim | `root123`, `wp123` |
| XAMPP | Sim | `root`, `user` |

⚠️ Recomendo alterar essas senhas antes de expor os serviços à rede.

---

## Comandos úteis

```bash
# Iniciar dashboard
docker compose up -d

# Parar
docker compose down

# Logs
docker logs homepage_dashboard

# Atualizar
docker compose pull && docker compose up -d
```

## Configuração

Edite os arquivos em `./config/`:

- `services.yaml` — serviços e links
- `settings.yaml` — tema, cor, background
- `widgets.yaml` — CPU, memória, relógio
- `bookmarks.yaml` — links favoritos
- `docker.yaml` — status dos containers