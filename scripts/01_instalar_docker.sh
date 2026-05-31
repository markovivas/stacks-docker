#!/bin/bash

set -e

echo "Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y

echo "Removendo versões antigas do Docker (se existirem)..."
sudo apt remove -y docker docker-engine docker.io docker-doc docker-compose podman-docker containerd runc || true

echo "Instalando dependências..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "Adicionando chave GPG da Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "Adicionando repositório oficial da Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Atualizando lista de pacotes..."
sudo apt update

echo "Instalando Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Habilitando Docker no boot..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adicionando usuário atual ao grupo docker..."
sudo usermod -aG docker $USER

echo " Instalação concluída!"
echo "️ Faça logout/login ou reinicie para usar Docker sem sudo."
