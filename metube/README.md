# 🎬 MeTube com Docker Compose

Este projeto cria um ambiente **MeTube** usando Docker, permitindo baixar vídeos e áudios de diversas plataformas (como YouTube) diretamente pelo navegador.

Os downloads são salvos em pastas locais para facilitar organização, backup e acesso rápido aos arquivos.

---

# 📁 Estrutura do Projeto

Após iniciar o container, a estrutura será:

```text
metube-docker/
│
├── compose.yaml
├── README.md
│
├── downloads/
│   └── (vídeos baixados)
│
└── audio-downloads/
    └── (áudios baixados)
```

As pastas são criadas automaticamente.

---

# 🚀 Como iniciar o MeTube

## 1️⃣ Criar pasta do projeto

```bash
mkdir metube-docker
cd metube-docker
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

O Docker irá baixar automaticamente a imagem do MeTube.

---

## 3️⃣ Acessar o MeTube

Abra no navegador:

```text
http://localhost:8085
```

A interface web será exibida.

---

# 🎬 Como baixar vídeos

1. Copie a URL do vídeo
   Exemplo:

```text
https://www.youtube.com/watch?v=XXXXXXXX
```

2. Cole no campo do MeTube

3. Escolha o formato:

* Vídeo (MP4)
* Somente áudio (MP3 ou similar)

4. Clique em:

```text
Add
```

O download será iniciado automaticamente.

---

# 📂 Organização dos downloads

## Vídeos

Os vídeos são salvos em:

```text
./downloads
```

---

## Áudios

Os arquivos de áudio são salvos em:

```text
./audio-downloads
```

---

# 📦 Persistência de arquivos

Todos os downloads ficam armazenados localmente.

Isso permite:

✔ Acessar arquivos facilmente
✔ Fazer backup rápido
✔ Transferir arquivos para outro computador
✔ Manter histórico de downloads

---

# 💾 Backup dos arquivos

Para fazer backup:

Copie as pastas:

```text
downloads/
audio-downloads/
```

Exemplo:

```bash
zip -r backup-metube.zip downloads audio-downloads
```

Ou:

```bash
tar -czvf backup-metube.tar.gz downloads audio-downloads
```

---

# 🔧 Comandos úteis

## Parar o MeTube

```bash
docker compose down
```

---

## Reiniciar

```bash
docker compose restart
```

---

## Atualizar MeTube

```bash
docker compose pull
docker compose up -d
```

---

## Ver logs

```bash
docker logs metube
```

---

# 🔐 Porta utilizada

| Serviço | Porta |
| ------- | ----- |
| MeTube  | 8081  |

Acesso:

```text
http://localhost:8081
```

---

# 🧪 Requisitos

Antes de iniciar, instale:

* Docker Desktop

Download:

https://www.docker.com/products/docker-desktop/

---

# 🧠 Dicas importantes

✔ Verifique espaço em disco regularmente
✔ Faça backup dos downloads importantes
✔ Use nomes organizados para playlists
✔ Atualize o container periodicamente

---

# 📁 Organização recomendada (opcional)

Se você baixar muitos arquivos, recomendo:

```text
metube-docker/
│
├── downloads/
│   ├── videos/
│   ├── playlists/
│   └── cursos/
│
└── audio-downloads/
    ├── mp3/
    ├── podcasts/
    └── musicas/
```

Isso ajuda muito na organização.

---

# 🚀 Melhorias futuras possíveis

Este ambiente pode ser expandido com:

* 🎵 Conversão automática para MP3
* 🎞️ Qualidade padrão configurável
* 📂 Organização automática por data
* 🔐 Proteção por senha
* 🌐 Acesso remoto
* 📦 Download automático de playlists

---

# 🏁 Conclusão

Este projeto fornece um **MeTube simples e funcional**, com armazenamento persistente e fácil manutenção.

Ideal para:

* Download de vídeos
* Download de músicas
* Backup de conteúdos
* Uso pessoal
* Organização de mídia
* Download de playlists

---
