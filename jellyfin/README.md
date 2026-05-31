# 🎬 Jellyfin com Docker Compose

Este projeto cria um servidor **Jellyfin Media Server** usando Docker, permitindo organizar e assistir **filmes, séries, músicas e vídeos** em uma interface moderna via navegador ou aplicativos.

Os arquivos de mídia são armazenados localmente para facilitar organização, backup e acesso rápido.

---

# 📁 Estrutura do Projeto

Após iniciar o container, a estrutura será:

```text
jellyfin-docker/
│
├── compose.yaml
├── README.md
│
├── media/
│   ├── Filmes/
│   ├── Series/
│   ├── Musicas/
│   └── Videos/
│
├── config/
└── cache/
```

Pastas importantes:

```text
./media   → Arquivos de mídia
./config  → Configurações do Jellyfin
./cache   → Cache do sistema
```

---

# 🚀 Como iniciar o Jellyfin

## 1️⃣ Criar pasta do projeto

```bash
mkdir jellyfin-docker
cd jellyfin-docker
```

Copie para dentro:

* `compose.yaml`
* `README.md`

---

## 2️⃣ Iniciar o container

Execute:

```bash
docker compose up -d
```

O Docker irá baixar automaticamente a imagem do Jellyfin.

---

## 3️⃣ Acessar o Jellyfin

Abra no navegador:

```text
http://localhost:8096
```

---

# ⚙️ Configuração inicial

Na primeira execução:

1. Escolha o idioma
2. Crie o usuário administrador
3. Configure bibliotecas
4. Selecione a pasta:

```text
/media
```

Depois disso, o Jellyfin irá identificar automaticamente os arquivos.

---

# 📂 Organização recomendada da pasta media

Uma boa organização ajuda o Jellyfin a reconhecer os conteúdos automaticamente.

## Filmes

```text
media/
└── Filmes/
    └── Filme Nome (2024)/
        └── Filme Nome (2024).mp4
```

---

## Séries

```text
media/
└── Series/
    └── Nome da Serie/
        └── Season 01/
            ├── S01E01.mkv
            ├── S01E02.mkv
```

---

## Músicas

```text
media/
└── Musicas/
    └── Artista/
        └── Álbum/
            └── musica.mp3
```

---

## Vídeos diversos

```text
media/
└── Videos/
```

---

# 📦 Persistência de dados

Todos os dados ficam armazenados localmente.

Isso inclui:

✔ Usuários
✔ Bibliotecas
✔ Metadados
✔ Configurações
✔ Arquivos de mídia

Pastas críticas:

```text
./config
./media
```

⚠️ **Nunca delete essas pastas sem backup.**

---

# 💾 Backup do Jellyfin

Para fazer backup completo:

Copie as pastas:

```text
config/
media/
```

Exemplo:

```bash
zip -r backup-jellyfin.zip config media
```

Ou:

```bash
tar -czvf backup-jellyfin.tar.gz config media
```

---

# 🔄 Restaurar Backup

Para restaurar:

1. Pare o container:

```bash
docker compose down
```

2. Substitua as pastas:

```text
config/
media/
```

3. Inicie novamente:

```bash
docker compose up -d
```

---

# 🔧 Comandos úteis

## Parar o Jellyfin

```bash
docker compose down
```

---

## Reiniciar

```bash
docker compose restart
```

---

## Atualizar Jellyfin

```bash
docker compose pull
docker compose up -d
```

---

## Ver logs

```bash
docker logs jellyfin
```

---

# 🔐 Porta utilizada

| Serviço  | Porta |
| -------- | ----- |
| Jellyfin | 8096  |

Acesso:

```text
http://localhost:8096
```

---

# 🧪 Requisitos

Antes de iniciar, instale:

* Docker Desktop

Download:

https://www.docker.com/products/docker-desktop/

---

# 📺 Apps compatíveis com Jellyfin

Você pode acessar o servidor também por aplicativos.

Disponível para:

* Android
* iOS
* Windows
* Smart TVs
* Fire TV
* Android TV

Basta conectar usando:

```text
http://IP_DO_SERVIDOR:8096
```

---

# 🧠 Dicas importantes

✔ Use nomes corretos nos arquivos
✔ Organize por pastas
✔ Faça backup regularmente
✔ Mantenha o container atualizado
✔ Verifique espaço em disco

---

# 🚀 Melhorias futuras possíveis

Este ambiente pode ser expandido com:

* 🎮 Aceleração por GPU (AMD, Intel ou NVIDIA)
* 🌐 Acesso remoto
* 🔐 HTTPS automático
* 📦 Backup automático
* 🎬 Download automático via MeTube
* 📺 Integração com outros serviços
* 🗂️ Organização automática de mídia

---

# 🎯 Integração recomendada

Se você já usa outros serviços Docker, o Jellyfin combina muito bem com:

* MeTube → baixar vídeos automaticamente
* Gitea → armazenar projetos
* WordPress → criar portais internos

---

# 🏁 Conclusão

Este projeto fornece um **servidor Jellyfin completo**, com persistência local e fácil manutenção.

Ideal para:

* Streaming local
* Organização de filmes
* Organização de séries
* Biblioteca musical
* Servidor multimídia doméstico
* Ambientes internos

---
