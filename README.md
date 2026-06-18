<div align="center">
  <h1>🚀 DAPOY PANEL</h1>
  <p><b>Solusi Pamungkas VPS IP Private & Manajemen Server Kelas Enterprise</b></p>
  <p>Ubah Mini PC, Server Rumahan, atau VPS IP Private Anda Menjadi Server Global Profesional dalam 1 Klik!</p>
</div>

---

## 🌟 Mengapa Harus Dapoy Panel?

Punya server murah tapi **tidak punya IP Public**? Atau langganan ISP rumahan (Indihome/Biznet) tapi IP-nya dinamis dan diblokir dari luar? 

**Dapoy Panel** adalah sistem kontrol server revolusioner yang dirancang khusus untuk memecahkan masalah tersebut. Dengan integrasi mulus ke teknologi **Cloudflare Tunnel**, Dapoy Panel mampu "menembus" tembok internet dan meng-online-kan website/aplikasi Anda ke seluruh dunia **TANPA PERLU IP PUBLIC IPv4**, tanpa repot *port forwarding*, dan tanpa bayar IP Statis mahal!

---

## 🔥 Fitur Utama (The Killer Features)

### 1. 🌍 Private to Global (Cloudflare Tunneling)
- **Tanpa IP Public:** Jadikan localhost atau IP Private VPS Anda bisa diakses dari seluruh dunia (misal: `aplikasi.domainanda.com`).
- **Auto-SSL & DDoS Protection:** Langsung mendapat gembok hijau HTTPS dan perlindungan keamanan level enterprise dari Cloudflare.
- **1-Click Expose:** Tidak perlu paham perintah Linux. Cukup ketik nama subdomain dan port, website Anda langsung *Online* mendunia! 

### 2. 🤖 Auto-Pilot Deployment (Webhook CI/CD)
Pernah bayangkan punya fitur auto-deploy ala Vercel atau Heroku di server Anda sendiri?
- **Universal Webhook:** Cukup pasang URL Webhook Dapoy Panel ke GitHub. Setiap kali Anda (atau tim) melakukan *Push* kode baru, server akan **otomatis menarik update (Git Pull)** dan me-restart sistem secara diam-diam (Background).
- **Zero-Touch Update:** Tinggalkan cara kuno (masuk FTP -> hapus file -> upload ZIP). Semua terjadi dalam hitungan detik secara gaib!

### 3. 📦 Node.js / PM2 Manager
- Tampilan Visual (GUI) mewah untuk mengatur aplikasi Node.js/Python Anda.
- **Start, Stop, Restart, dan Delete** aplikasi hanya dengan satu kali klik.
- Pantau status aplikasi Anda (Online/Offline) tanpa harus membuka layar hitam terminal.

### 4. 🔐 Isolasi Klien SFTP (Multi-Tenant)
Mau jualan hosting atau menyewakan sebagian server Anda ke klien?
- **One-Click SFTP:** Buat akun SFTP untuk klien dengan password rahasia hanya dalam 5 detik.
- **Smart Pathing:** Klien akan terkurung (Isolated) hanya di dalam folder website mereka sendiri. 
- **Fleksibel:** Dukungan penuh untuk *Directory Path* Custom untuk developer tingkat lanjut. Klien tidak akan bisa menghancurkan sistem root Anda.

### 5. 💻 Web Terminal Terintegrasi
- Akses penuh (Root Access) ke terminal server langsung dari dalam *browser*. 
- Eksekusi perintah Linux, cek log, dan perbaiki masalah dari mana saja, bahkan dari HP, tanpa perlu aplikasi SSH pihak ketiga (Putty/Termius).

### 6. ⚡ Smart Auto-Installer "Sapu Jagat"
Kami tahu waktu Anda berharga. Instalasi Dapoy Panel dilengkapi dengan script sakti:
- Cukup tempel 1 baris kode di VPS kosong, lalu tidur.
- Script akan otomatis memesangkan **Nginx**, **PHP**, **Node.js**, **PM2**, hingga **Dapoy Panel** secara langsung (tanpa aaPanel).
- Saat Anda bangun, layar Terminal akan menyajikan struk indah berisi semua *Username, Password*, dan URL akses ke panel Anda.

### 7. 🛡️ Kode Alien (Anti-Theft Obfuscation)
Untuk Anda yang berbisnis, *source code* panel ini dilapisi sistem *Obfuscation* (diacak menjadi bahasa alien). Kode Anda aman dari pencurian, modifikasi ilegal, atau penjiplakan oleh klien yang usil.

---

## 🚀 Cara Install Dapoy Panel

Kami telah menyediakan skrip instalasi "Sapu Jagat" yang akan mengurus SEMUA hal (mulai dari Nginx, PHP, Node.js, PM2, hingga Dapoy Panel itu sendiri).

1. Login ke VPS Anda menggunakan SSH (pastikan menggunakan user `root` atau `sudo`).
2. Jalankan perintah ajaib berikut:

```bash
curl -sSL https://raw.githubusercontent.com/syahmuhamadrizky/dapoy-panel-release/main/install.sh | sudo bash
```

3. Tunggu hingga proses selesai (biasanya sekitar 5-10 menit tergantung kecepatan server).
4. Saat selesai, terminal akan menampilkan **URL Login, Username, dan Password** Anda!

---

## 🗺️ Penjelasan Menu Navigasi

Dapoy Panel dirancang sesederhana mungkin agar Anda tidak tersesat. Berikut adalah panduan singkat tentang apa saja yang bisa Anda lakukan di tiap menu:

1. **📊 Dashboard**  
   Layar utama yang menampilkan ringkasan kondisi VPS Anda. Mulai dari pemakaian CPU, RAM, penyimpanan (Disk), hingga grafik penggunaan secara *real-time*.
2. **☁️ Tunnel Manager**  
   Pusat kendali ajaib! Di sini Anda bisa menginstal Cloudflared, *login* ke akun Cloudflare Anda, dan membuat nama Tunnel (lorong) untuk menghubungkan VPS tanpa IP Public ke internet global.
3. **🌐 Web Manager**  
   Tempat untuk membuat dan mengatur *Virtual Host* (website) Nginx. Anda bisa memilih nama domain, versi PHP, dan mengaktifkan Cloudflare Tunnel langsung dengan 1 kali klik. Anda juga bisa membuat akun SFTP terpisah khusus untuk setiap website!
4. **📦 App Manager**  
   Spesialis untuk aplikasi Node.js, Python, atau script *background*. Anda bisa mendaftarkan aplikasi,将它annya dengan auto-deploy GitHub, dan memantaunya menggunakan PM2 GUI.
5. **📁 File Manager**  
   Sistem penjelajah *file* lengkap! Anda bisa mengunggah (upload), mengunduh, mengedit kode secara langsung, *copy*, *paste*, atau mengekstrak file ZIP langsung dari *browser*.
6. **🐬 phpMyAdmin**  
   Menu ini akan menghasilkan token rahasia sekali pakai (One-Time Token) lalu membawa Anda langsung ke phpMyAdmin untuk mengelola database MySQL/MariaDB dengan sangat aman.
7. **🔧 Terminal SSH**  
   Terminal *web-based* yang cantik. Tidak butuh aplikasi Putty! Masukkan password root VPS Anda, dan Anda siap mengeksekusi perintah Linux apapun layaknya hacker di film-film.
8. **⚙️ Pengaturan Sistem**  
   Pusat kontrol Dapoy Panel itu sendiri. Di sini Anda bisa mengubah Identitas Panel (Nama & Logo), mengatur kredensial akses SSH dan Cloudflare API Token, hingga memperbarui versi panel (System Update) secara nirkabel (OTA).

---

## 🎯 Siapa yang Wajib Menggunakan Dapoy Panel?

1. **Pengguna Server Rumahan (Home Server)** yang ingin *hosting* website tanpa berlangganan IP Static.
2. **Pemburu VPS Murah** (VPS NAT, IPv6 Only, atau IP Private) yang ingin performa tinggi dengan harga miring.
3. **Developer & Freelancer** yang butuh manajemen auto-deploy GitHub (CI/CD) yang tidak bikin pusing.
4. **Penyedia Hosting Kecil-kecilan** yang butuh membagi resource server untuk klien (menggunakan SFTP terisolasi).

---

## 💖 Dukung Pengembangan (Donate)

Proyek ini dibangun dengan penuh semangat untuk membantu komunitas Developer dan penggiat Server di Indonesia. Jika aplikasi ini membantu Anda dalam menghemat biaya server, memudahkan pekerjaan, atau menghasilkan profit untuk bisnis Anda, secangkir kopi dari Anda akan sangat berarti untuk pengembangan fitur selanjutnya! ☕

**Gopay:** `087777999907`

<div align="center">
  <img src="https://img.shields.io/badge/Gopay-087777999907-00AED6?style=for-the-badge&logo=gojek&logoColor=white" alt="Gopay">
</div>

---

> **Dapoy Panel — Bukan Sekadar Panel, Ini Adalah Gerbang Menuju Dunia.** 🚀
