# Immich

Solução auto-hospedada para gerenciamento de fotos e vídeos, alternativa ao Google Fotos.

Acesso: [http://localhost:2283](http://localhost:2283)

---

## Recursos

| Recurso             | Detalhe                        |
| ------------------- | ------------------------------ |
| Web                 | http://localhost:2283          |
| Container servidor  | `immich-server`                |
| Container banco     | `immich-database` (PostgreSQL) |
| Container cache     | `immich-redis`                 |
| Container ML        | `immich-machine-learning`      |
| Uploads             | `./volumes/upload/`            |
| Banco de dados      | `./volumes/database/`          |

---

## Primeiro acesso

1. Acesse http://localhost:2283
2. Crie o usuário administrador
3. Comece a fazer upload

## Backup

Faça backup regularmente de:
- `./volumes/database/`
- `./volumes/upload/`
