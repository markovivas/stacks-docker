# Paperless-ngx

Sistema de gerenciamento de documentos open-source. Organiza, indexa e disponibiliza busca em documentos digitalizados.

Acesso: [http://localhost:8000](http://localhost:8000)

---

## Recursos

| Recurso               | Detalhe                          |
| --------------------- | -------------------------------- |
| Web                   | http://localhost:8000            |
| Container servidor    | `paperless-webserver`            |
| Container banco       | `paperless-db` (PostgreSQL)      |
| Container broker      | `paperless-broker` (Redis)       |
| Documentos            | `./volumes/media/`               |
| Pasta consumo         | `./volumes/consume/`             |

---

## Primeiro acesso

1. Crie o superusuário:
```bash
docker exec -it paperless-webserver python manage.py createsuperuser
```

2. Acesse http://localhost:8000

3. Coloque documentos na pasta `./volumes/consume/`

O Paperless processa e classifica automaticamente os documentos.

## Backup

Faça backup de:
- `./volumes/database/`
- `./volumes/data/`
- `./volumes/media/`
