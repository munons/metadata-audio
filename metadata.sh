#!/bin/bash
# ======================================================
# Script Name : metadata-audio.sh
# Version     : 1.4
# Description : Tambah cover art + metadata audio bersih tanpa sisa tag lama
# Author      : munons
# Created     : 2025-09-10
# Updated     : 2025-10-16
# License     : Free for personal use
# GitHub      : https://github.com/munons
# Copyright   : © 2025 by MUNONS
# ======================================================

mkdir -p render
logfile="process.log"
: >"$logfile"

# Cek cover eksternal
cover=$(ls cover.{jpg,jpeg,png,webp} 2>/dev/null | head -n 1)
if [ -n "$cover" ]; then
  echo "✅ Pakai cover eksternal: $cover"
else
  echo "⚠️ Tidak ada cover eksternal, akan pakai cover bawaan (jika ada)"
fi

# Argumen opsional: Artis, Judul, Album
artis_arg="$1"
judul_arg="$2"
album_arg="$3"
album_default="Japan"

for f in *.{mp3,MP3,m4a,M4A,flac,FLAC,wav,WAV,ogg,OGG}; do
  [ -e "$f" ] || continue
  filename="${f%.*}"
  echo "🎧 Processing: $f"

  # Ambil metadata lama (jika ada)
  artis_exist=$(ffprobe -v error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$f")
  judul_exist=$(ffprobe -v error -show_entries format_tags=title  -of default=noprint_wrappers=1:nokey=1 "$f")

  # Parsing nama file “Artis - Judul”
  if [[ "$filename" == *" - "* ]]; then
    artis_file=$(echo "$filename" | cut -d '-' -f1 | xargs)
    judul_file=$(echo "$filename" | cut -d '-' -f2- | xargs)
  else
    artis_file="$filename"
    judul_file="$filename"
  fi

  # Prioritas metadata: argumen > metadata lama > nama file
  artis="${artis_arg:-${artis_exist:-$artis_file}}"
  judul="${judul_arg:-${judul_exist:-$judul_file}}"
  album="${album_arg:-$album_default}"

  out="render/${filename}.mp3"

  echo "   🎵 Artist: $artis"
  echo "   🎶 Title : $judul"
  echo "   💿 Album : $album"

  if [ -n "$cover" ]; then
    # Ada cover eksternal
    ffmpeg -y -i "$f" -i "$cover" \
      -map 0:a -map 1 \
      -map_metadata -1 \
      -c:a libmp3lame -b:a 320k \
      -metadata artist="$artis" \
      -metadata title="$judul" \
      -metadata album="$album" \
      -metadata genre="Japan" \
      -metadata comment="by MUNONS" \
      -metadata:s:v title="Cover Art" \
      -metadata:s:v comment="by MUNONS" \
      -disposition:v attached_pic \
      "$out" >>"$logfile" 2>&1
  else
    # Tidak ada cover eksternal → tetap encode ulang dengan metadata baru
    ffmpeg -y -i "$f" \
      -map_metadata -1 \
      -c:a libmp3lame -b:a 320k \
      -metadata artist="$artis" \
      -metadata title="$judul" \
      -metadata album="$album" \
      -metadata genre="Japan" \
      -metadata comment="by MUNONS" \
      "$out" >>"$logfile" 2>&1
  fi

  if [ $? -eq 0 ]; then
    echo "✅ Selesai → $out"
  else
    echo "❌ Gagal: $f (lihat $logfile)"
  fi
done

echo "🎯 Semua proses selesai! File hasil ada di folder 'render/'"