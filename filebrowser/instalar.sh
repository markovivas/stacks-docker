#!/bin/bash
set -e

# File Browser - Instalador Automatico
# Uso: chmod +x instalar.sh && ./instalar.sh
#     ./instalar.sh --clean  (apaga DB/config e recria admin)

PORT="8087"
ADMIN_USER="admin"
ADMIN_PASS='123456789@qwe'
COMPOSE_FILE="compose.yaml"
CLEAN=false

if [[ "$1" == "--clean" ]]; then
  CLEAN=true
fi

echo "======================================"
echo " File Browser - Instalador"
echo "======================================"
echo " Porta: $PORT"
echo " Usuario: $ADMIN_USER"
echo ""

# 1. Checar Docker
if ! command -v docker >/dev/null 2>&1; then
  echo "[ERRO] Docker nao encontrado. Instale o Docker primeiro."
  exit 1
fi
if ! docker compose version >/dev/null 2>&1; then
  echo "[ERRO] 'docker compose' nao encontrado (plugin compose v2)."
  exit 1
fi
echo "[ok] Docker $(docker --version) | $(docker compose version)"

# 2. Criar pastas
echo "[1/5] Criando pastas..."
mkdir -p files database config

# 3. Limpeza se --clean
if [[ "$CLEAN" == true ]]; then
  echo "[clean] Removendo DB/config antigos..."
  docker compose down 2>/dev/null || true
  rm -rf database/filebrowser.db database/* config/settings.json config/*
fi

# 4. Criar compose.yaml (abordagem nova sem entrypoint.sh externo)
echo "[2/5] Gerando $COMPOSE_FILE..."
cat > "$COMPOSE_FILE" <<EOF
services:
  filebrowser:
    image: filebrowser/filebrowser:latest
    container_name: filebrowser
    user: "0:0"
    ports:
      - "$PORT:80"
    volumes:
      - ./files:/srv
      - ./database:/database
      - ./config:/config
    restart: unless-stopped
    entrypoint: ["/bin/sh", "-c"]
    command:
      - |
        set -e
        DB="/database/filebrowser.db"
        CFG="/config/settings.json"
        mkdir -p /srv /database /config
        if [ ! -f "\$\$CFG" ]; then
          echo "[init] config init..."
          filebrowser config init --config "\$\$CFG" --database "\$\$DB" || true
        fi
        if [ ! -f "\$\$DB" ]; then
          echo "[init] criando admin..."
          filebrowser users add admin '$ADMIN_PASS' --perm.admin --config "\$\$CFG" --database "\$\$DB" || true
        else
          filebrowser users find admin --config "\$\$CFG" --database "\$\$DB" >/dev/null 2>&1 || filebrowser users add admin '$ADMIN_PASS' --perm.admin --config "\$\$CFG" --database "\$\$DB" || true
        fi
        echo "[ok] File Browser em http://0.0.0.0:80 root=/srv"
        exec filebrowser --config "\$\$CFG" --database "\$\$DB" --root /srv --address 0.0.0.0 --port 80
EOF

# remover entrypoint.sh legado se existir
if [[ -f entrypoint.sh ]]; then
  echo "[aviso] Removendo entrypoint.sh legado..."
  rm -f entrypoint.sh
fi

# 5. Permissoes (evita Operation not permitted)
echo "[3/5] Ajustando permissoes..."
chmod 777 files database config 2>/dev/null || true
chmod 666 database/* config/* 2>/dev/null || true
# tenta chown para 1000 se possivel (nao falha se nao puder)
chown -R 1000:1000 files database config 2>/dev/null || true
chmod -R 777 files database config 2>/dev/null || true

# 6. Subir
echo "[4/5] Subindo container (docker compose up -d)..."
docker compose down 2>/dev/null || true
docker compose up -d

echo "[5/5] Aguardando inicializacao..."
sleep 3
for i in {1..10}; do
  STATUS=$(docker inspect -f '{{.State.Status}}' filebrowser 2>/dev/null || echo "notfound")
  if [[ "$STATUS" == "running" ]]; then
    break
  fi
  if [[ "$STATUS" == "restarting" ]]; then
    echo "  ...tentativa $i: ainda restarting, aguardando..."
    docker logs filebrowser --tail 20 2>&1 | tail -5
  fi
  sleep 2
done

echo ""
echo "--------------------------------------"
docker ps --filter name=filebrowser --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo "--------------------------------------"
echo ""
docker logs filebrowser --tail 30 2>&1 | tail -20
echo ""
IP=$(hostname -I 2>/dev/null | awk '{print $1}')
if [[ -z "$IP" ]]; then IP="IP-DO-SERVIDOR"; fi

echo "======================================"
echo " File Browser Pronto!"
echo " URL Local:  http://localhost:$PORT"
echo " URL Rede:   http://$IP:$PORT"
echo " Usuario:    $ADMIN_USER"
echo " Senha:      $ADMIN_PASS"
echo "======================================"
echo ""
echo "Comandos uteis:"
echo "  docker logs -f filebrowser"
echo "  docker compose ps"
echo "  docker compose down"
echo "  ./instalar.sh --clean  # resetar admin/DB"
echo ""
# checar porta
if ss -tlnp 2>/dev/null | grep -q ":$PORT "; then
  echo "[ok] Porta $PORT em escuta."
else
  echo "[aviso] Porta $PORT nao parece em escuta. Verifique firewall/conflito."
  echo "  ss -tlnp | grep $PORT"
  echo "  docker logs filebrowser"
fi
