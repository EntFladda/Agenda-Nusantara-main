import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'database/database_helper.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await DatabaseHelper().initialize();
  runApp(const AgendaNusantaraApp());
}

class AgendaNusantaraApp extends StatelessWidget {
  const AgendaNusantaraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Nusantara',
      theme: ThemeData(
        primaryColor: const Color(0xFF4ECCA7),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4ECCA7),
          brightness: Brightness.light,
        ),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
