#!/bin/bash
# Ubuntu Server for Proxmox (USP) v1.0

LOG="/var/log/usp.log"
exec > >(tee -a "$LOG") 2>&1

RED='\033[0;31m';GREEN='\033[0;32m';YELLOW='\033[1;33m';BLUE='\033[0;34m';NC='\033[0m'

msg(){ echo -e "${GREEN}==>${NC} $1"; }
warn(){ echo -e "${YELLOW}==>${NC} $1"; }

[ "$EUID" -ne 0 ] && { echo "Execute como root."; exit 1; }

update_system(){
 msg "Atualizando sistema..."
 apt update && apt upgrade -y
 apt autoremove -y
 apt autoclean
}

expand_disk(){
 if vgs ubuntu-vg >/dev/null 2>&1; then
   FREE=$(vgs --noheadings -o vg_free --units m --nosuffix ubuntu-vg|xargs|cut -d. -f1)
   if [ "$FREE" -gt 0 ]; then
      msg "Expandindo LVM..."
      lvextend -l +100%FREE -r /dev/ubuntu-vg/ubuntu-lv
   else
      warn "Nenhum espaço livre encontrado no VG."
   fi
 else
   warn "VG ubuntu-vg não encontrado."
 fi
}

install_docker(){
 if command -v docker >/dev/null; then warn "Docker já instalado."; return; fi
 msg "Instalando Docker..."
 apt install -y ca-certificates curl gnupg lsb-release
 install -m0755 -d /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 chmod a+r /etc/apt/keyrings/docker.gpg
 echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" > /etc/apt/sources.list.d/docker.list
 apt update
 apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
 systemctl enable --now docker
 if [ -n "$SUDO_USER" ]; then usermod -aG docker "$SUDO_USER"; fi
}

install_samba(){
 if dpkg -s samba >/dev/null 2>&1; then warn "Samba já instalado."; return; fi
 msg "Instalando Samba..."
 apt install -y samba
 mkdir -p /dados
 chmod 777 /dados
 cp /etc/samba/smb.conf /etc/samba/smb.conf.bak.$(date +%F-%H%M%S)
 cat >> /etc/samba/smb.conf <<EOF

[dados]
path=/dados
browseable=yes
read only=no
guest ok=yes
force user=nobody
force group=nogroup
create mask=0777
directory mask=0777
public=yes
writable=yes
EOF
 systemctl enable --now smbd nmbd
 command -v ufw >/dev/null && ufw allow samba || true
}

install_cockpit(){
 if dpkg -s cockpit >/dev/null 2>&1; then warn "Cockpit já instalado."; return; fi
 msg "Instalando Cockpit..."
 apt install -y cockpit cockpit-machines
 systemctl enable --now cockpit.socket
 command -v ufw >/dev/null && ufw allow 9090/tcp || true
}

install_qemu(){
 if dpkg -s qemu-guest-agent >/dev/null 2>&1; then warn "QEMU Guest Agent já instalado."; return; fi
 msg "Instalando QEMU Guest Agent..."
 apt install -y qemu-guest-agent
 systemctl enable --now qemu-guest-agent
}

info(){
 IP=$(hostname -I|awk '{print $1}')
 clear
 echo "====================================="
 echo " Ubuntu Server for Proxmox"
 echo "====================================="
 echo "Hostname : $(hostname)"
 echo "IP       : $IP"
 echo "Kernel   : $(uname -r)"
 echo "Ubuntu   : $(lsb_release -ds 2>/dev/null)"
 echo
 df -h /
 echo
 echo "Docker   : $(command -v docker >/dev/null && echo Instalado || echo Nao)"
 echo "Samba    : $(dpkg -s samba >/dev/null 2>&1 && echo Instalado || echo Nao)"
 echo "Cockpit  : $(dpkg -s cockpit >/dev/null 2>&1 && echo Instalado || echo Nao)"
 echo "QEMU GA  : $(dpkg -s qemu-guest-agent >/dev/null 2>&1 && echo Instalado || echo Nao)"
 echo
 echo "Cockpit : https://$IP:9090"
 echo "Samba   : \\\\$IP\\dados"
 read -p "Enter..."
}

provision(){
 update_system
 expand_disk
 install_docker
 install_samba
 install_cockpit
 install_qemu
 msg "Provisionamento concluído!"
}

while true; do
clear
cat <<MENU
===========================================
 Ubuntu Server for Proxmox v1.0
===========================================

1 - Provisionamento Completo

2 - Expandir Disco

3 - Instalar Docker

4 - Instalar Samba

5 - Instalar Cockpit

6 - Instalar QEMU Guest Agent

7 - Atualizar Sistema

8 - Mostrar Informações

9 - Sair

===========================================
MENU
read -p "Escolha: " op
case $op in
1) provision;;
2) expand_disk;;
3) install_docker;;
4) install_samba;;
5) install_cockpit;;
6) install_qemu;;
7) update_system;;
8) info;;
9) exit 0;;
*) echo "Opção inválida"; sleep 1;;
esac
done
