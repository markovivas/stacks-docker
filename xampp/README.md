# Ambiente de Desenvolvimento XAMPP (Docker)

Este diretório contém uma pilha Docker configurada para simular um ambiente XAMPP, ideal para desenvolvimento local de aplicações PHP com MySQL.

## 🚀 Serviços Incluídos

A pilha é composta por 4 serviços principais:

1.  **Apache (PHP 8.2)**:
    *   **Porta**: `9080` (Acesse em [http://localhost:9080](http://localhost:9080))
    *   **Configuração**: Baseado no `Dockerfile` local, que instala extensões essenciais como `mysqli`, `pdo_mysql`, `gd`, `intl`, entre outras.
    *   **Volume**: Os arquivos do seu site devem ficar na pasta `./SITE` (mapeada para `/var/www/html` no container).

2.  **MySQL (8.0)**:
    *   **Porta**: `3307` (mapeada para a porta padrão `3306` do container)
    *   **Credenciais**:
        *   **Root Password**: `root`
        *   **Database**: `site`
        *   **User**: `user` / **Password**: `user`
    *   **Persistência**: Os dados do banco são salvos em `./mysql/data`.

3.  **phpMyAdmin**:
    *   **Porta**: `9077` (Acesse em [http://localhost:9077](http://localhost:9077))
    *   **Uso**: Interface gráfica para gerenciar o banco de dados MySQL.

4.  **MailHog**:
    *   **Porta**: `8025` (Acesse em [http://localhost:8025](http://localhost:8025))
    *   **Uso**: Servidor de e-mail "falso" para testes. Ele captura todos os e-mails enviados pela aplicação sem entregá-los de fato, permitindo visualizar o conteúdo e layout.

## 📂 Estrutura de Pastas

*   `./SITE`: Coloque aqui seus arquivos `.php`, `.html`, etc.
*   `./mysql/data`: Pasta criada automaticamente para persistir os dados do banco.
*   `./Dockerfile`: Instruções de montagem da imagem do Apache/PHP.
*   `./php.ini`: Configurações personalizadas do PHP.

## 🔌 Configurações do MySQL

As configurações do MySQL neste ambiente Docker (`compose.yaml`) são:

| Parâmetro | Valor |
|-----------|-------|
| **Host** | `mysql` (dentro da rede Docker) ou `localhost:3307` (de fora) |
| **Usuário** | `root` ou `user` |
| **Senha** | `root` ou `user` |
| **Database** | `site` |

## 🛠️ Comandos Básicos

Para subir o ambiente:
```bash
docker compose up -d
```

Para parar o ambiente:
```bash
docker-compose stop
```

Para remover os containers:
```bash
docker compose down
```

## 📝 Notas
*   O módulo `rewrite` do Apache já está habilitado para suporte a URLs amigáveis (`.htaccess`).
*   O arquivo `php.ini` local é carregado automaticamente pelo container.
