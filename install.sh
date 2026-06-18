#!/bin/bash
# ==========================================
# DAPOY PANEL Standalone Installer (Tanpa aaPanel!)
# ==========================================
# Script ini akan menginstall Dapoy Panel secara otomatis TANPA aaPanel.
# Nginx & PHP diinstal langsung dari repository resmi.

# Warna untuk output
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${GREEN}==========================================${RESET}"
echo -e "${GREEN}  Dapoy Panel Standalone Installer      ${RESET}"
echo -e "${GREEN}  (Zero aaPanel - Faster & Lighter!)    ${RESET}"
echo -e "${GREEN}==========================================${RESET}"

# 1. Pastikan dijalankan sebagai Root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: Script ini harus dijalankan sebagai ROOT!${RESET}"
  echo -e "Silakan ketik 'sudo su' lalu jalankan ulang script ini."
  exit 1
fi

# 2. Update System & Install Dependensi Dasar
echo -e "${YELLOW}[1/5] Memperbarui sistem dasar...${RESET}"
if [ -x "$(command -v apt-get)" ]; then
    PM="apt-get"
    $PM update -y > /dev/null 2>&1
    $PM install -y curl wget git unzip sudo jq ca-certificates gnupg lsb-release > /dev/null 2>&1
elif [ -x "$(command -v yum)" ]; then
    PM="yum"
    $PM install -y epel-release > /dev/null 2>&1
    $PM install -y curl wget git unzip sudo jq > /dev/null 2>&1
else
    echo -e "${RED}Error: Package manager tidak dikenali. Harus Debian/Ubuntu atau RHEL/CentOS.${RESET}"
    exit 1
fi

# 3. Instalasi Nginx & PHP (Tanpa aaPanel!)
echo -e "${YELLOW}[2/5] Menginstall Nginx & PHP...${RESET}"
if [ "$PM" == "apt-get" ]; then
    # Nginx dari repository resmi
    wget -qO /tmp/nginx_signing_key.opensuse.org https://nginx.org/keys/nginx_signing.key > /dev/null 2>&1
    apt-key add /tmp/nginx_signing_key.opensuse.org > /dev/null 2>&1
    echo "deb http://nginx.org/packages/debian $(lsb_release -cs) nginx" > /etc/apt/sources.list.d/nginx.list
    
    # PHP dari Ondrej repository
    add-apt-repository -y ppa:ondrej/php > /dev/null 2>&1
    
    $PM update -y > /dev/null 2>&1
    $PM install -y nginx php8.2 php8.2-fpm php8.2-mysql php8.2-cli php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip > /dev/null 2>&1
    
elif [ "$PM" == "yum" ]; then
    # Nginx dari EPEL atau nginx repo
    $PM install -y nginx > /dev/null 2>&1
    # PHP dari Remi
    $PM install -y yum-utils > /dev/null 2>&1
    yum-config-manager --enable remi-php82 > /dev/null 2>&1
    $PM install -y php php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-zip > /dev/null 2>&1
fi

# Start & enable services
systemctl enable nginx > /dev/null 2>&1
systemctl enable php*-fpm > /dev/null 2>&1
systemctl start nginx > /dev/null 2>&1
systemctl start php*-fpm > /dev/null 2>&1

echo -e "${GREEN}✓ Nginx & PHP berhasil diinstal!${RESET}"

# Instalasi Docker & Docker Compose
echo -e "${YELLOW}[3/5] Menginstall Docker & Docker Compose...${RESET}"
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com | bash > /dev/null 2>&1
    systemctl enable docker > /dev/null 2>&1
    systemctl start docker > /dev/null 2>&1
fi
if ! command -v docker-compose &> /dev/null; then
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose > /dev/null 2>&1
    chmod +x /usr/local/bin/docker-compose > /dev/null 2>&1
fi
echo -e "${GREEN}✓ Docker & Docker Compose berhasil diinstal!${RESET}"

# 4. Instalasi Node.js (LTS) dan PM2
echo -e "${YELLOW}[4/5] Menginstall Lingkungan Node.js & PM2...${RESET}"
if [ "$PM" == "apt-get" ]; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - > /dev/null 2>&1
    apt-get install -y nodejs > /dev/null 2>&1
elif [ "$PM" == "yum" ]; then
    curl -fsSL https://rpm.nodesource.com/setup_20.x | bash - > /dev/null 2>&1
    yum install -y nodejs > /dev/null 2>&1
fi
npm install -g pm2 > /dev/null 2>&1

echo -e "${GREEN}✓ Node.js & PM2 berhasil diinstal!${RESET}"

# 5. Instalasi Dapoy Panel (Di /opt/dapoy-panel)
echo -e "${YELLOW}[5/6] Mengunduh Dapoy Panel...${RESET}"
TARGET_DIR="/opt/dapoy-panel"

if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Direktori sudah ada, menghapus...${RESET}"
    rm -rf "$TARGET_DIR"
fi

git clone https://github.com/syahmuhamadrizky/dapoy-panel-release.git "$TARGET_DIR"

echo -e "${YELLOW}[6/6] Mengkonfigurasi dan Menjalankan Dapoy Panel...${RESET}"
cd "$TARGET_DIR"
npm install --production > /dev/null 2>&1

# Set default .env jika belum ada
if [ ! -f ".env" ]; then
    echo "DASHBOARD_USERNAME=admin" > .env
    echo "DASHBOARD_PASSWORD=admin" >> .env
    echo "PORT=3000" >> .env
fi

# Jalankan dengan PM2 sebagai Root (karena ini panel server)
pm2 start server.js --name dapoy-panel
pm2 save
pm2 startup | grep "sudo env" | bash

# Setup Nginx reverse proxy
cat > /etc/nginx/conf.d/dapoy.conf << 'EOF'
server {
    listen 80;
    server_name _;
    
    client_max_body_size 100M;
    
    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_cache_bypass $http_upgrade;
    }
}
EOF

systemctl restart nginx

VPS_IP=$(curl -s ifconfig.me)

echo -e "\n${GREEN}==========================================${RESET}"
echo -e "${GREEN}🎉 INSTALASI SELESAI DENGAN SUKSES! 🎉${RESET}"
echo -e "${GREEN}==========================================${RESET}\n"

echo -e "${CYAN}--- AKSES DAPOY PANEL ---${RESET}"
echo -e "URL Login : http://${VPS_IP}"
echo -e "Username  : admin"
echo -e "Password  : admin"
echo -e ""
echo -e "${YELLOW}--- AKSES NODE MANAGER (PM2) ---${RESET}"
echo -e "pm2 status"
echo -e ""
echo -e "${YELLOW}--- WEB ROOT ---${RESET}"
echo -e "Nginx document root: /usr/share/nginx/html"
echo -e "Dapoy Panel www dir: /www/dp/www"
echo -e ""
echo -e "${RED}⚠️  PENTING:${RESET} Harap segera ganti password default di menu Pengaturan Dapoy Panel!"
echo -e "==========================================\n"
