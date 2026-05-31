# 🐳 Gitea com Docker Compose

Este projeto cria um servidor **Gitea** usando Docker, com persistência local de dados para facilitar backup, migração e manutenção.

O Gitea é uma alternativa leve ao GitHub, ideal para:

* Hospedar repositórios Git privados
* Controle de versão interno
* Desenvolvimento colaborativo
* Ambientes locais ou corporativos
* Backup de projetos pessoais

---

# 📁 Estrutura do Projeto

Após iniciar o container, a estrutura será:

```
gitea-docker/
│
├── compose.yaml
├── README.md
│
└── gitea/
    ├── git/
    ├── gitea.db
    ├── conf/
    ├── log/
    └── attachments/
```

A pasta:

```
./gitea
```

armazenará todos os dados importantes.

---

# 🚀 Como iniciar o Gitea

## 1️⃣ Criar pasta do projeto

```bash
mkdir gitea-docker
cd gitea-docker
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

O Docker irá baixar automaticamente a imagem do Gitea.

---

## 3️⃣ Acessar o Gitea

Abra no navegador:

```
http://localhost:3000
```

---

# ⚙️ Configuração inicial

Na primeira execução aparecerá a tela de instalação.

Use as configurações recomendadas:

```
Database Type: SQLite3
Database Path: /data/gitea/gitea.db
Site Title: Gitea
Repository Root Path: /data/git
```

Depois:

* Clique em **Install Gitea**
* Crie o usuário **Administrador**

---

# 🔐 Portas utilizadas

| Porta | Função        |
| ----- | ------------- |
| 3000  | Interface Web |
| 222   | SSH para Git  |

Exemplos:

```
http://localhost:3000
```

SSH:

```
ssh -p 222 git@localhost
```

---

# 📦 Persistência de dados

Todos os dados ficam armazenados em:

```
./gitea
```

Isso inclui:

* Repositórios Git
* Usuários
* Issues
* Wikis
* Configurações
* Banco SQLite
* Logs

⚠️ **Nunca delete essa pasta sem backup.**

---

# 💾 Backup do Gitea

Para fazer backup completo:

Copie a pasta:

```
./gitea
```

Exemplo:

```bash
zip -r backup-gitea.zip gitea
```

Ou:

```bash
tar -czvf backup-gitea.tar.gz gitea
```

---

# 🔄 Restaurar Backup

Para restaurar:

1. Pare o container:

```bash
docker compose down
```

2. Substitua a pasta:

```
./gitea
```

3. Inicie novamente:

```bash
docker compose up -d
```

---

# 🔁 Importar repositório do GitHub

Você pode migrar projetos facilmente.

## Passos:

1. Acesse:

```
http://localhost:3000
```

2. Faça login

3. Clique em:

```
+ → New Migration
```

4. Escolha:

```
GitHub
```

5. Cole a URL:

```
https://github.com/usuario/repositorio
```

---

## Repositórios privados

Se o repositório for privado:

1. Acesse GitHub

```
Settings → Developer Settings
→ Personal Access Tokens
```

2. Gere um token

3. Cole no campo:

```
Access Token
```

4. Clique:

```
Migrate Repository
```

O repositório será importado.

---

# 🔧 Comandos úteis

## Parar o Gitea

```bash
docker compose down
```

---

## Reiniciar

```bash
docker compose restart
```

---

## Atualizar Gitea

```bash
docker compose pull
docker compose up -d
```

---

## Ver logs

```bash
docker logs gitea_server
```

---

# 🧪 Requisitos

Antes de iniciar, instale:

* Docker Desktop

Download:

https://www.docker.com/products/docker-desktop/

---

# 🧠 Dicas importantes

✔ Faça backup regularmente
✔ Use senha forte para administrador
✔ Atualize o Gitea periodicamente
✔ Evite desligar o container abruptamente

---

# 🚀 Melhorias futuras possíveis

Este ambiente pode ser expandido com:

* 🗄️ Banco MySQL
* 🐘 PostgreSQL
* 🔐 HTTPS (SSL)
* 🌐 Nginx Proxy Manager
* 📦 Backup automático
* 👥 LDAP / Active Directory
* 📡 Acesso remoto seguro
* 🐳 Docker Registry interno

---

# 🏁 Conclusão

Este projeto fornece um **servidor Git completo usando Gitea**, com persistência local e fácil manutenção.

Ideal para:

* Desenvolvimento local
* Hospedagem interna de código
* Backup de repositórios
* Ambientes corporativos
* Projetos pessoais
* Controle de versões profissional

---
