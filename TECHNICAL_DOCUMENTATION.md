# Dokumentasi Teknis Agenda Nusantara

## Arsitektur Aplikasi

Aplikasi ini mengikuti struktur Flutter standar dengan pembagian komponen sebagai berikut:

### 1. Layer Model (`lib/models/`)

**Task Model** (`task.dart`)
- Merepresentasikan data tugas
- Fields: id, title, description, dueDate, category, isCompleted, createdAt
- Menyediakan methods: toMap(), fromMap(), copyWith()

### 2. Layer Database (`lib/database/`)

**DatabaseHelper** (`database_helper.dart`)
- Singleton class untuk mengelola koneksi SQLite
- Menyediakan CRUD operations untuk tasks
- Menyediakan validasi dan manajemen user
- Methods utama:
  - `insertTask(Task)` - Menambah tugas baru
  - `updateTask(Task)` - Memperbarui tugas
  - `deleteTask(int id)` - Menghapus tugas
  - `getAllTasks()` - Mengambil semua tugas
  - `getTasksByCategory(String)` - Filter berdasarkan kategori
  - `getCompletedTasksCount()` - Hitung tugas selesai
  - `getIncompleteTasksCount()` - Hitung tugas belum selesai
  - `getTasksCompletedByDate()` - Statistik per hari
  - `validateUser()` - Validasi login
  - `updatePassword()` - Ubah password

### 3. Layer Presentation (`lib/screens/`)

#### LoginScreen
- Halaman awal aplikasi
- Validasi username dan password
- Navigasi ke HomeScreen setelah login berhasil
- UI: Logo, form fields, login button

#### HomeScreen
- Dashboard utama dengan statistik
- Menampilkan:
  - Greeting message dengan tanggal
  - Jumlah tugas selesai dan belum selesai
  - Bar chart statistik per hari (bonus feature)
  - Grid navigation buttons (4 button)
- Navigate ke semua screen lain

#### AddImportantTaskScreen
- Form untuk menambah tugas dengan kategori 'penting' (warna merah)
- Fields: date picker, title, description
- Validasi input sebelum save
- Database insertion dan navigation back

#### AddRegularTaskScreen
- Form untuk menambah tugas dengan kategori 'biasa' (warna hijau)
- Struktur sama dengan AddImportantTaskScreen
- Perbedaan: kategori dan warna

#### TaskListScreen
- List view semua tugas (penting dan biasa)
- Features:
  - Checkbox untuk menandai selesai
  - Visual indicator (panah merah untuk penting, hijau untuk biasa)
  - Swipe to delete
  - Scroll support untuk list panjang

#### SettingsScreen
- Halaman pengaturan user
- Features:
  - Form ubah password
  - Validasi password lama
  - Info developer
  - Logout button

### 4. Layer UI Widgets (`lib/widgets/`)

**DashboardCard**
- Reusable widget untuk menampilkan statistik
- Props: label, count, color
- Digunakan di HomeScreen

## Database Schema

### Table: users
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL
)
```

### Table: tasks
```sql
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT,
  dueDate TEXT NOT NULL,
  category TEXT NOT NULL,
  isCompleted INTEGER NOT NULL DEFAULT 0,
  createdAt TEXT NOT NULL
)
```

## Dependencies

- **sqflite**: Database SQLite untuk mobile
- **path**: Path manipulation utilities
- **intl**: Internalisasi dan formatting (terutama format tanggal)
- **fl_chart**: Library untuk membuat chart/grafik
- **cupertino_icons**: Icon library

## Navigation Flow

```
LoginScreen
    ↓
HomeScreen
    ├── AddImportantTaskScreen
    ├── AddRegularTaskScreen
    ├── TaskListScreen
    ├── SettingsScreen
    │   └── LoginScreen (after logout)
```

## State Management

Aplikasi ini menggunakan StatefulWidget dengan setState() untuk state management yang sederhana. 

## Color Scheme

- Primary: `#4ECCA7` (Teal - Beranda, Settings)
- Important Task: `#CC3333` (Red)
- Regular Task: `#52B788` (Green)
- Background: `#FFFFFF` (White)
- Text Primary: `#000000` (Black)
- Text Secondary: `#808080` (Gray)

## Locale

- Aplikasi menggunakan locale Indonesia ('id_ID') untuk format tanggal
- Format tanggal: `dd MMM yyyy` (contoh: 06 Mei 2026)
- Hari dalam minggu: Sen, Sel, Rab, Kam, Jum, Sab, Min

## Responsive Design

- Menggunakan MediaQuery untuk responsiveness
- Layout disesuaikan untuk berbagai ukuran screen
- Scrollable views untuk content yang panjang

## Error Handling

- Try-catch blocks untuk operasi database
- SnackBar untuk user feedback
- Validasi input sebelum database operation

## Best Practices yang Diimplementasikan

1. **Separation of Concerns**: Pemisahan antara UI, Business Logic, dan Data
2. **Code Reusability**: Widget reusable untuk komponen yang sama
3. **Null Safety**: Menggunakan null safety features dari Dart
4. **Async/Await**: Proper handling of asynchronous operations
5. **Widget Composition**: Membuat custom widgets untuk UI organization
6. **Resource Cleanup**: Proper dispose() implementation di StatefulWidget

## Testing

(Untuk development lebih lanjut)
- Unit tests untuk DatabaseHelper
- Widget tests untuk UI components
- Integration tests untuk navigation flow

## Performance Considerations

1. Database queries dioptimalkan dengan whereArgs
2. FutureBuilder digunakan untuk async operations
3. Images di-cache untuk performa yang lebih baik
4. ListView.builder untuk list yang efisien
