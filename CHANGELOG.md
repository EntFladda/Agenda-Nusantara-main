# Changelog

Semua perubahan signifikan dalam proyek Agenda Nusantara akan dicatat di file ini.

## [1.0.0] - 2026-05-06

### Ditambahkan
- Login screen dengan validasi username dan password
- Home screen dengan statistik tugas dan navigation buttons
- Feature tambah tugas penting (kategori penting, warna merah)
- Feature tambah tugas biasa (kategori biasa, warna hijau)
- Halaman daftar tugas dengan checkbox untuk menandai selesai
- Feature swipe to delete untuk menghapus tugas
- Halaman pengaturan untuk mengubah password
- Logout functionality
- SQLite database untuk penyimpanan lokal
- Bar chart untuk statistik tugas selesai per hari (bonus feature)
- Material Design 3 UI
- Support untuk lokalisasi Indonesia

### Features yang Diimplementasikan

#### 1. Halaman Login
- [x] Logo aplikasi di atas
- [x] Nama aplikasi di bawah logo
- [x] Field username dan password
- [x] Login button yang navigasi ke beranda
- [x] Default credentials: user/user
- [x] Error handling untuk login gagal

#### 2. Halaman Beranda
- [x] Label "Tugas Selesai" dan "Tugas Belum Selesai"
- [x] Grafik statistik per hari (bonus)
- [x] 4 navigation buttons (Tambah Penting, Tambah Biasa, Daftar, Pengaturan)
- [x] Greeting message dengan tanggal
- [x] Update statistik real-time

#### 3. Halaman Tambah Tugas Penting
- [x] Date picker untuk tanggal jatuh tempo
- [x] Field untuk judul tugas
- [x] Field untuk deskripsi tugas
- [x] Button simpan untuk menyimpan ke database
- [x] Button kembali untuk kembali ke beranda
- [x] Kategori penting dengan badge merah
- [x] Input validation

#### 4. Halaman Tambah Tugas Biasa
- [x] Sama seperti tambah tugas penting
- [x] Kategori biasa dengan badge hijau
- [x] Disimpan dengan kategori 'biasa'

#### 5. Halaman Daftar Tugas
- [x] ListView menampilkan semua tugas
- [x] Checkbox untuk menandai selesai
- [x] Ikon panah dengan warna berbeda (merah penting, hijau biasa)
- [x] Swipe to delete functionality
- [x] Scroll support untuk list panjang
- [x] Strike-through text untuk tugas selesai

#### 6. Halaman Pengaturan
- [x] Form untuk ubah password
- [x] Validasi password lama
- [x] Input password baru
- [x] Button simpan password
- [x] Info developer (nama, NIM)
- [x] Logout button dengan confirmation
- [x] Validasi minimal karakter password

### Technical Details

#### Database
- [x] SQLite dengan sqflite package
- [x] Auto-initialization saat first launch
- [x] Default user (user/user) auto-created
- [x] Proper schema design
- [x] Efficient queries dengan WHERE clause

#### UI/UX
- [x] Material Design 3
- [x] Responsive layout
- [x] Smooth navigation transitions
- [x] SnackBar untuk feedback
- [x] Loading indicators
- [x] Error messages yang jelas

#### Code Quality
- [x] Clean code structure
- [x] Proper null safety
- [x] Async/await for database operations
- [x] Resource cleanup dengan dispose()
- [x] Error handling dengan try-catch
- [x] Code organization dalam folders

### Bonus Features
- [x] Bar chart statistik tugas per hari
- [x] Indonesian locale support
- [x] Delete confirmation (swipe to delete)
- [x] Password visibility toggle
- [x] Logout confirmation dialog

## Future Enhancements

- [ ] Reminder notifications
- [ ] Task categories/tags
- [ ] Due date reminders
- [ ] Dark mode
- [ ] Biometric authentication
- [ ] Cloud sync (Firebase)
- [ ] Export data functionality
- [ ] Multiple language support
- [ ] Task notes/attachments
- [ ] Recurring tasks

## Known Issues

Tidak ada issue yang diketahui pada versi 1.0.0

## Testing Status

- Manual testing: ✓ Completed
- UI testing: ✓ Completed
- Database testing: ✓ Completed
- Navigation testing: ✓ Completed
- Error handling testing: ✓ Completed

---

Untuk informasi lebih lanjut, lihat TECHNICAL_DOCUMENTATION.md
