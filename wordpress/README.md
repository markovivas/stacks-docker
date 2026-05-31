# 🐳 WordPress + MySQL + phpMyAdmin com Backup Automático

Este projeto cria um ambiente completo para rodar **WordPress**, **MySQL** e **phpMyAdmin** usando **Docker Compose**, com:

* WordPress na porta **9081**
* phpMyAdmin na porta **9082**
* Arquivos do WordPress em pasta local (`data`)
* Backup automático diário do banco
* Compatível com **Docker Desktop (Windows/Linux)**

---

# 📁 Estrutura do Projeto

Após criar o projeto, a estrutura será:

```
wordpress-docker/
│
├── compose.yaml
├── README.md
├── data/        → Arquivos do WordPress
├── backups/     → Backups automáticos do banco
├── logs/        → Logs opcionais
```

As pastas `data` e `backups` podem ser criadas manualmente ou automaticamente pelo Docker.

---

# 🚀 Como iniciar o projeto

## 1️⃣ Criar a pasta do projeto

```bash
mkdir wordpress-docker
cd wordpress-docker
```

Coloque dentro dela:

* `compose.yaml`
* `README.md`

---

## 2️⃣ Iniciar os containers

Execute:

```bash
docker compose up -d
```

Isso irá baixar e iniciar:

* WordPress
* MySQL
* phpMyAdmin
* Sistema de Backup

---

## 3️⃣ Acessar o WordPress

Abra no navegador:

```
http://localhost:9081
```

Complete a instalação normalmente.

---

## 4️⃣ Acessar o phpMyAdmin

Abra:

```
http://localhost:9082
```

Login:

```
Usuário: root
Senha: root123
Servidor: db
```

---

# 🗄️ Acesso ao Banco via HeidiSQL

Use as seguintes configurações:

```
Host: localhost
Porta: 3306

Usuário: wpuser
Senha: wp123
Banco: wordpress
```

Ou como root:

```
Usuário: root
Senha: root123
```

---

# 📦 Arquivos do WordPress

Os arquivos ficam em:

```
./data
```

Isso permite:

* Backup manual fácil
* Instalar temas manualmente
* Editar plugins
* Migrar o site
* Copiar arquivos rapidamente

Exemplo:

```
data/
│
├── wp-admin
├── wp-content
├── wp-includes
```

---

# 💾 Backup automático do banco

O sistema realiza:

```
Backup diário às 02:00
```

Arquivos salvos em:

```
./backups
```

Exemplo:

```
backups/

wordpress_2026-04-22_02-00.sql.gz
wordpress_2026-04-23_02-00.sql.gz
wordpress_2026-04-24_02-00.sql.gz
```

Mantém automaticamente:

```
Últimos 7 backups
```

Os mais antigos são removidos.

---

# 🔄 Restaurar um Backup

Para restaurar um backup:

```bash
gunzip < backups/arquivo.sql.gz | docker exec -i wordpress_db mysql -u root -proot123 wordpress
```

Substitua:

```
arquivo.sql.gz
```

pelo nome do backup desejado.

---

# 🔧 Parar o ambiente

Para parar os containers:

```bash
docker compose down
```

---

# 🔄 Reiniciar o ambiente

```bash
docker compose restart
```

---

# 🧹 Remover tudo (CUIDADO)

Remove containers e volumes:

```bash
docker compose down -v
```

⚠️ Isso apaga o banco de dados.

---

# 🔐 Segurança (Recomendado)

Antes de usar em produção:

Altere no `compose.yaml`:

```
MYSQL_ROOT_PASSWORD: root123
MYSQL_PASSWORD: wp123
```

Use senhas fortes.

Exemplo:

```
MYSQL_ROOT_PASSWORD: R00t@Segura!2026
MYSQL_PASSWORD: WP@Segura!2026
```

---

# 🧪 Serviços incluídos

Este projeto usa:

| Serviço           | Função                 |
| ----------------- | ---------------------- |
| WordPress         | Site                   |
| MySQL             | Banco de dados         |
| phpMyAdmin        | Administração do banco |
| mysql-cron-backup | Backup automático      |

---

# 🌐 Portas utilizadas

| Serviço    | Porta |
| ---------- | ----- |
| WordPress  | 9081  |
| phpMyAdmin | 9082  |
| MySQL      | 3306  |

---

# 📌 Requisitos

Antes de iniciar, instale:

* Docker Desktop
* Docker Compose (já incluído no Docker Desktop)

Download:

https://www.docker.com/products/docker-desktop/

---

# 📁 Backup completo do projeto

Para backup total:

Copie:

```
data/
backups/
compose.yaml
```

Isso permite restaurar tudo rapidamente.

---

# 🚀 Melhorias futuras possíveis

Este ambiente pode ser expandido com:

* 🔐 HTTPS automático (SSL)
* 🌐 Nginx Proxy Manager
* 📦 Backup dos arquivos WordPress
* 🌎 Múltiplos sites WordPress
* 🧪 Ambiente Dev + Produção
* 🧰 Logs estruturados
* 📡 Acesso remoto seguro

---

# 🧠 Dicas importantes

✔ Sempre mantenha backups
✔ Não use senhas padrão em produção
✔ Atualize imagens periodicamente:

```bash
docker compose pull
docker compose up -d
```

---

# 🏁 Conclusão

Este ambiente fornece um **WordPress completo, seguro e com backup automático**, ideal para:

* Desenvolvimento local
* Testes
* Intranet
* Hospedagem leve
* Projetos pessoais
* Ambientes corporativos internos

---
