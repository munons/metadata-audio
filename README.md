# 🎧 metadata-audio.sh

Skrip simpel buat **bersihin metadata lama** dan **nambahin cover art otomatis** ke file musik kamu.  
Cocok banget buat yang pengen file audionya tampil rapi dan profesional di semua pemutar 🎶

---

## 💡 Apa yang Skrip Ini Lakuin

- Hapus semua metadata lama (bersih tanpa sisa).
- Tambahin cover art eksternal (kalau ada file `cover.jpg/png/webp`).
- Tulis ulang tag: Artist, Judul, Album, Genre, Comment.
- Simpen hasilnya ke folder `render/` biar file asli tetap aman.
- Catet proses ke `process.log`.

---

## ⚙️ Cara Pakai di **PC / Laptop (Linux)**

1. Pastikan udah install **ffmpeg** dan **ffprobe**:
   ```bash
   sudo apt install ffmpeg
   ```

2. Taruh skrip `metadata-audio.sh` di folder yang berisi file musik kamu.

3. (Opsional) Tambahin file gambar cover:
   ```
   cover.jpg / cover.png / cover.webp
   ```

4. Jalankan skripnya:
   ```bash
   bash metadata-audio.sh [ARTIST] [TITLE] [ALBUM]
   ```

   Contoh:
   ```bash
   bash metadata-audio.sh "YOASOBI" "Idol" "Japan Hits"
   ```

   Kalau kamu nggak isi argumen, skrip bakal otomatis baca dari metadata lama,  
   atau dari nama file misalnya `YOASOBI - Idol.mp3`.

---

## 📱 Cara Pakai di **Android (Termux)**

> ⚠️ Langkah ini udah dites dan berjalan lancar di Android 13–14 (Termux terbaru).

### 1. Instal Termux & ffmpeg
Buka Termux lalu jalankan perintah ini:
```bash
pkg update && pkg upgrade -y
pkg install ffmpeg -y
```

### 2. Buat folder kerja
Misalnya di `~/musiccleaner`:
```bash
mkdir ~/musiccleaner
cd ~/musiccleaner
```

### 3. Pindahin skrip dan file musik
Salin `metadata-audio.sh` ke folder itu, lalu juga taruh file musik kamu di situ.
Kamu bisa pakai aplikasi **CX File Explorer** atau **ZArchiver** buat pindahin file ke folder Termux.

Contohnya:
```
~/musiccleaner/
├── metadata-audio.sh
├── cover.jpg
├── YOASOBI - Idol.mp3
```

### 4. Kasih izin eksekusi skrip
```bash
chmod +x metadata-audio.sh
```

### 5. Jalankan!
```bash
bash metadata-audio.sh
```
Atau kalau mau isi manual:
```bash
bash metadata-audio.sh "YOASOBI" "Idol" "Japan Hits"
```

### 6. Hasilnya
Cek folder `render/`:
```bash
ls render
```
Semua hasil ada di situ — file asli tetap aman 👍

---

## 📂 Struktur Folder

```
📁 .
├── metadata-audio.sh
├── cover.jpg (opsional)
├── YOASOBI - Idol.mp3
├── process.log
└── 📁 render/
    └── YOASOBI - Idol.mp3
```

---

## 🏷️ Tag Default

| Tag | Nilai |
|------|--------|
| Album | Japan |
| Genre | Japan |
| Comment | by MUNONS |

---

## 🧰 Tools yang Dipakai

- **Bash**
- **FFmpeg**
- **FFprobe**
- (Android pakai Termux)

---

## 🧑‍💻 Info Skrip

| Info | Detail |
|------|--------|
| Nama | metadata-audio.sh |
| Versi | 1.4 |
| Author | [MUNONS](https://github.com/munons) |
| Dibuat | 10 Sep 2025 |
| Update Terakhir | 16 Okt 2025 |
| Lisensi | Free for personal use |

---

## 🧾 Contoh Output

```
✅ Pakai cover eksternal: cover.jpg
🎧 Processing: YOASOBI - Idol.mp3
   🎵 Artist: YOASOBI
   🎶 Title : Idol
   💿 Album : Japan Hits
✅ Selesai → render/YOASOBI - Idol.mp3
🎯 Semua proses selesai! File hasil ada di folder 'render/'
```

---

## 🧠 Tips Tambahan

- Kalau cover nggak muncul → pastikan file `cover.jpg/png/webp` ada di folder yang sama.  
- Kalau Termux error "permission denied" → coba `chmod +x metadata-audio.sh`.  
- Semua file dikonversi ke `.mp3` (320kbps) biar bisa diputar di semua device.  
- Genre dan Album default-nya “Japan”, bisa diganti lewat argumen.  
- File asli aman — hasil baru disimpan di folder `render/`.

---

> 🎶 “Satu klik di Termux, semua lagu kamu langsung rapi dan tampil keren di pemutar musik!”
