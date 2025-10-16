# 🎧 metadata-audio.sh

Skrip Bash otomatis untuk **membersihkan metadata lama**, **menambahkan cover art eksternal**, dan **menulis ulang tag audio secara rapi**.  
Didesain agar file musik kamu tampil sempurna di semua pemutar seperti *VLC, iTunes, foobar2000, dan Android Music Player.*

---

## 📜 Deskripsi Umum

`metadata-audio.sh` dibuat untuk mempermudah proses *re-tagging* audio dengan hasil bersih dan konsisten.  
Skrip ini bekerja otomatis untuk:
- Menghapus semua tag lama tanpa sisa.
- Menulis ulang metadata baru (artist, title, album, genre, comment).
- Menambahkan cover art eksternal (jika tersedia).
- Menyimpan hasil konversi di folder `render/` agar file asli tetap aman.
- Mencatat proses ke file `process.log`.

---

## ⚙️ Alur Kerja

1. **Inisialisasi**
   - Membuat folder `render/`.
   - Menghapus isi log lama dan membuat `process.log` baru.

2. **Pengecekan Cover Art**
   - Mencari file `cover.jpg`, `cover.png`, `cover.webp`, atau `cover.jpeg`.
   - Jika tidak ditemukan, menampilkan peringatan dan tetap melanjutkan tanpa cover.

3. **Pemrosesan File Audio**
   - Mendukung format: `.mp3`, `.m4a`, `.flac`, `.wav`, `.ogg`
   - Membaca metadata lama menggunakan `ffprobe`.
   - Jika nama file berbentuk `Artis - Judul`, akan otomatis dipisah menjadi tag.
   - Prioritas metadata:
     ```
     Argumen CLI > Metadata lama > Nama file
     ```
   - Menentukan nilai default untuk album: `Japan`.

4. **Proses Encode Ulang**
   - Jika cover eksternal ada:
     ```bash
     ffmpeg -i input -i cover -map 0:a -map 1 ...
     ```
   - Jika tidak ada cover eksternal:
     ```bash
     ffmpeg -i input -map_metadata -1 ...
     ```
   - Hasil file tersimpan di `render/`.

5. **Output**
   - File hasil akan muncul di `render/`.
   - Status sukses/gagal dicatat di `process.log`.

---

## 🧩 Fitur Utama

✅ Membersihkan metadata lama sepenuhnya  
✅ Mendukung banyak format audio  
✅ Tidak menimpa file asli  
✅ Parsing otomatis dari nama file  
✅ Log lengkap untuk setiap proses  
✅ Otomatis mendeteksi dan menanam cover art eksternal  

---

## 🧰 Tools yang Digunakan

- **Bash**
- **FFmpeg**
- **FFprobe**
- **Coreutils (ls, cut, xargs)**

---

## 🏷️ Metadata Default

| Tag | Nilai |
|------|--------|
| Artist | Berdasarkan argumen atau nama file |
| Title | Berdasarkan argumen atau nama file |
| Album | Japan |
| Genre | Japan |
| Comment | by MUNONS |
| Cover | cover eksternal (jika tersedia) |

---

## 📦 Struktur Output Folder

```
📁 .
├── metadata-audio.sh
├── cover.jpg (opsional)
├── song1.mp3
├── song2.flac
├── process.log
└── 📁 render/
    ├── song1.mp3
    └── song2.mp3
```

---

## 💡 Contoh Penggunaan

Menambahkan metadata secara manual:
```bash
bash metadata-audio.sh "YOASOBI" "Idol" "Japan Hits"
```

Tanpa argumen (otomatis ambil dari nama file atau metadata lama):
```bash
bash metadata-audio.sh
```

Output terminal:
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

## 🧑‍💻 Informasi Teknis

| Keterangan | Nilai |
|-------------|--------|
| **Script Name** | metadata-audio.sh |
| **Version** | 1.0 |
| **Author** | [MUNONS](https://github.com/munons) |
| **Created** | 2025-09-10 |
| **Updated** | 2025-10-16 |
| **License** | Free for personal use |
| **GitHub** | [https://github.com/munons](https://github.com/munons) |

---

## 🔧 Troubleshooting

- **Cover tidak muncul:** pastikan file cover bernama `cover.jpg/png/webp` dan berada di folder yang sama.  
- **FFmpeg error:** cek versi ffmpeg terbaru (`ffmpeg -version`).  
- **File tidak diproses:** pastikan ekstensi file audio sesuai (mp3, m4a, flac, wav, ogg).  
- **Output kosong:** periksa `process.log` untuk detail error.

---

> 💬 *"Satu klik untuk audio yang rapi, bersih, dan tampil sempurna di semua pemutar musik."*
