# NoteDiscovery - Instalação Limpa com pt-BR (Docker)

Este ZIP já contém o idioma pt-BR (locales/pt-BR.json).

## Uso rápido (build local - recomendado, já inclui pt-BR na imagem)
1. Extraia o ZIP
2. docker compose up -d --build
3. Acesse http://localhost:8000 -> Configurações -> Idioma -> Português (Brasil)

## Uso com imagem GHCR (sem build)
1. Extraia, edite docker-compose.yml se necessário (locales já montado como volume)
2. docker compose -f docker-compose.ghcr.yml up -d

## Verificar idioma
GET http://localhost:8000/api/locales  deve listar pt-BR

Volumes:
 - ./data:/app/data  (suas notas)
 - ./locales:/app/locales  (já habilitado neste ZIP - permite editar traduções sem rebuild)
