#!/bin/bash

# Menampilkan ASCII Art
clear
echo "MADOSARTO"
echo "==============="
echo "=    ==    ==   ="
echo "=   =  =  =  =  ="
echo "=  =    = =   = ="
echo "= =      =    = ="
echo "==        ==    ="
echo "= =      =    = ="
echo "=  =    = =   = ="
echo "=   =  =  =  =  ="
echo "=    ==    ==   ="
echo ""
echo "Hostsae Indonesia"
echo "==========================="
echo "=    ++++     ++++     =   ="
echo "=   +    +   +    +    =   ="
echo "=  +      +  +      +   =   ="
echo "= +        + +        +   =   ="
echo "==          ==          ==  ="
echo "= +        + +        +   =   ="
echo "=  +      +  +      +   =   ="
echo "=   +    +   +    +    =   ="
echo "=    ++++     ++++     =   ="
echo "==========================="
echo ""
echo "Script auto installer Node PWR."
echo "Lanjutkan dengan menekan tombol Enter..."
read -p "Tekan Enter untuk melanjutkan instalasi Node..." 

# Memperbarui sistem
echo "Memperbarui sistem..."
sudo apt update && sudo apt upgrade -y

# Menginstal Java
echo "Menginstal Java..."
sudo apt install -y default-jdk

# Mengunduh perangkat lunak validator node
echo "Mengunduh validator.jar dan config.json..."
wget https://github.com/pwrlabs/PWR-Validator/releases/download/13.2.30/validator.jar -O validator.jar
wget https://github.com/pwrlabs/PWR-Validator/raw/refs/heads/main/config.json -O config.json

# Menyiapkan kata sandi
echo "Menyiapkan kata sandi..."
sudo nano password
echo "File kata sandi telah dibuat."

# Mengimpor kunci validator (opsional)
echo "Apakah Anda ingin mengimpor kunci pribadi? (y/n)"
read import_key
if [[ "$import_key" == "y" ]]; then
    echo "Silakan masukkan kunci pribadi Anda:"
    read private_key
    sudo java -jar validator.jar --import-key $private_key password
    echo "Kunci pribadi telah diimpor."
fi

# Menjalankan node validator menggunakan screen
echo "Menyiapkan node validator untuk berjalan di screen..."
echo "Silakan masukkan alamat IP server Anda:"
read server_ip
screen -dmS validator_node sudo java -jar validator.jar password $server_ip --compression-level 0

# Mendapatkan alamat dari validator node
echo "Untuk mendapatkan alamat validator, jalankan perintah berikut:"
echo "curl localhost:8085/address/"

# Pesan selesai
echo "Pemasangan node validator selesai!"
echo "Node sedang berjalan di latar belakang dalam sesi 'screen' yang bernama 'validator_node'."
echo "Anda dapat terhubung kembali ke sesi screen dengan perintah: screen -r validator_node"
