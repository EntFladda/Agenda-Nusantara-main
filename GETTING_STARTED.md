# Getting Started with Agenda Nusantara

Panduan lengkap untuk menjalankan aplikasi Agenda Nusantara.

## Prasyarat

Sebelum memulai, pastikan Anda sudah menginstall:

- **Flutter SDK** (versi 3.0.0 atau lebih tinggi)
  - Download dari: https://flutter.dev/docs/get-started/install
- **Android Studio** atau **Xcode** (untuk emulator)
- **Git** (untuk clone repository)

## Langkah-Langkah Instalasi

### 1. Clone Repository

```bash
git clone https://github.com/username/Agenda-Nusantara-main.git
cd Agenda-Nusantara-main
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Jalankan di Android Emulator

```bash
# Buka emulator Android terlebih dahulu, atau:
flutter emulators --launch <emulator_name>

# Jalankan aplikasi
flutter run
```

### 4. Jalankan di iOS Simulator (macOS only)

```bash
# Buka simulator iOS
open -a Simulator

# Jalankan aplikasi
flutter run
```

### 5. Jalankan di Device Fisik

```bash
# Pastikan device terhubung via USB
flutter devices

# Jalankan aplikasi
flutter run
```

## Pembangunan APK (untuk Production)

```bash
# Build APK
flutter build apk --release

# File APK akan tersimpan di: build/app/outputs/flutter-apk/app-release.apk
```

## Pembangunan Bundle (untuk Google Play Store)

```bash
# Build App Bundle
flutter build appbundle --release

# File Bundle akan tersimpan di: build/app/outputs/bundle/release/app-release.aab
```

## Troubleshooting

### Error: "flutter: command not found"
- Pastikan Flutter SDK sudah ditambahkan ke PATH environment variable
- Jalankan: `flutter doctor` untuk verifikasi instalasi

### Error: "No device found"
- Pastikan emulator Android atau iOS Simulator sudah berjalan
- Untuk device fisik, pastikan USB debugging sudah diaktifkan

### Error: "SDK location not found"
Buat file `local.properties` di folder `android/`:
```
sdk.dir=/path/to/your/android-sdk
flutter.sdk=/path/to/your/flutter
```

### Gradle Build Error
```bash
# Clean dan rebuild
flutter clean
flutter pub get
flutter run
```

## Development Tips

### Hot Reload
Selama aplikasi berjalan, tekan `r` untuk hot reload (perubahan kode langsung terlihat).

### Debug Mode
Aplikasi berjalan dalam debug mode secara default. Untuk mode release:
```bash
flutter run --release
```

### Melihat Logs
```bash
flutter logs
```

## Fitur Aplikasi

### 1. Login
- Username dan password default: `user`
- Credentials dapat diubah di halaman Pengaturan

### 2. Home (Beranda)
- Tampilan statistik tugas selesai dan belum selesai
- Grafik jumlah tugas yang diselesaikan per hari
- Quick navigation buttons ke semua fitur

### 3. Manajemen Tugas
- Tambah tugas penting (merah)
- Tambah tugas biasa (hijau)
- View semua tugas dengan filter
- Tandai tugas sebagai selesai
- Hapus tugas

### 4. Pengaturan
- Ubah password
- Logout

## Database

Aplikasi menggunakan SQLite untuk penyimpanan lokal. Database file tersimpan di:
- Android: `/data/data/com.example.agenda_nusantara/databases/agenda_nusantara.db`
- iOS: `Application Documents/agenda_nusantara.db`

## Support

Untuk bantuan lebih lanjut, silakan buka issue di repository atau hubungi developer.

## License

MIT License - Lihat LICENSE file untuk detail lengkap.
