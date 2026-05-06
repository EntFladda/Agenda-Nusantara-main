# Quick Reference Guide - Agenda Nusantara

## Instalasi & Menjalankan

```bash
# Instalasi dependencies
flutter pub get

# Jalankan di emulator
flutter run

# Build APK untuk production
flutter build apk --release
```

## Login Credentials

- **Username**: user
- **Password**: user

## File Structure

```
lib/
├── main.dart                      # Entry point
├── models/
│   └── task.dart                  # Task model
├── database/
│   └── database_helper.dart       # SQLite operations
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── add_important_task_screen.dart
│   ├── add_regular_task_screen.dart
│   ├── task_list_screen.dart
│   └── settings_screen.dart
└── widgets/
    └── dashboard_card.dart
```

## Key Functions

### DatabaseHelper

```dart
// Get all tasks
List<Task> tasks = await DatabaseHelper().getAllTasks();

// Insert task
int id = await DatabaseHelper().insertTask(task);

// Update task
await DatabaseHelper().updateTask(updatedTask);

// Delete task
await DatabaseHelper().deleteTask(taskId);

// Get completed tasks count
int count = await DatabaseHelper().getCompletedTasksCount();

// Get incomplete tasks count
int count = await DatabaseHelper().getIncompleteTasksCount();

// Validate user
bool isValid = await DatabaseHelper().validateUser(username, password);

// Update password
bool success = await DatabaseHelper().updatePassword(username, oldPwd, newPwd);
```

## Navigation

```dart
// Navigate to home
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => HomeScreen(username: username)),
);

// Navigate and update stats
Navigator.of(context).push(...).then((_) => _loadTaskStats());

// Pop/go back
Navigator.of(context).pop();

// Replace (logout)
Navigator.of(context).pushReplacement(...);
```

## Common Code Snippets

### Create Task
```dart
final task = Task(
  title: titleController.text,
  description: descriptionController.text,
  dueDate: selectedDate,
  category: 'penting', // or 'biasa'
  isCompleted: false,
  createdAt: DateTime.now(),
);
await DatabaseHelper().insertTask(task);
```

### Update Task Completion Status
```dart
final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
await DatabaseHelper().updateTask(updatedTask);
```

### Show Date Picker
```dart
final DateTime? picked = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2100),
);
```

### Show SnackBar
```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Pesan di sini')),
);
```

## Color Codes

| Element | Color | Hex Code |
|---------|-------|----------|
| Primary (Teal) | Beranda, Settings | #4ECCA7 |
| Important Tasks | Red | #CC3333 |
| Regular Tasks | Green | #52B788 |
| Error/Delete | Red | #DC3545 |
| Background | White | #FFFFFF |
| Text Primary | Black | #000000 |
| Text Secondary | Gray | #808080 |

## Important Notes

1. **Default User**: Username dan password default adalah "user"
2. **Database**: Semua data disimpan lokal, tidak online
3. **Date Format**: Format tanggal menggunakan Indonesia (dd MMM yyyy)
4. **Locale**: Aplikasi sudah dikonfigurasi untuk Indonesian locale
5. **Dependencies**: Pastikan semua dependencies di pubspec.yaml sudah terupdate

## Troubleshooting

| Error | Solusi |
|-------|--------|
| "Flutter command not found" | Tambahkan Flutter ke PATH |
| "No device found" | Buka emulator terlebih dahulu |
| "Database locked" | Restart aplikasi |
| "Build gradle error" | `flutter clean` dan `flutter pub get` |
| "Login failed" | Pastikan credentials benar (user/user) |

## Development Tips

- **Hot Reload**: Tekan `r` saat aplikasi running
- **Debug Mode**: Gunakan `flutter run` atau `flutter run --debug`
- **Release Mode**: Gunakan `flutter run --release`
- **View Logs**: `flutter logs`
- **Check Devices**: `flutter devices`

## Performance Tips

1. Gunakan `const` untuk widget yang tidak berubah
2. Gunakan `ListView.builder` untuk list panjang
3. Dispose controller di `StatefulWidget`
4. Gunakan `FutureBuilder` untuk async operations
5. Hindari rebuild yang tidak perlu dengan `setState`

## Testing Checklist

- [ ] Login dengan kredensial benar
- [ ] Login dengan kredensial salah (error message)
- [ ] Tambah tugas penting
- [ ] Tambah tugas biasa
- [ ] Tandai tugas selesai
- [ ] Hapus tugas (swipe)
- [ ] Lihat daftar semua tugas
- [ ] Ubah password dengan benar
- [ ] Ubah password dengan password lama salah (error)
- [ ] Logout dan login ulang
- [ ] Statistik update setelah tambah/hapus tugas
- [ ] Grafik tampil dengan benar

## Useful Flutter Commands

```bash
# Run dengan device tertentu
flutter run -d <device_id>

# Build untuk specific target
flutter build apk --target-platform android-arm64

# Clean build cache
flutter clean

# Get all packages
flutter pub get

# Upgrade packages
flutter pub upgrade

# Format code
flutter format lib/

# Analyze code
flutter analyze

# Run tests
flutter test
```

---

Untuk informasi lebih lengkap, lihat README.md dan TECHNICAL_DOCUMENTATION.md
