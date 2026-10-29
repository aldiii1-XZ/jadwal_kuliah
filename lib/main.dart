import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const JadwalKuliahApp());
}

/// Titik masuk aplikasi Jadwal Kuliah.
class JadwalKuliahApp extends StatelessWidget {
  const JadwalKuliahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwal Kuliah',
      debugShowCheckedModeBanner: false,
      theme: _tema(Brightness.light),
      darkTheme: _tema(Brightness.dark),
      locale: const Locale('id'),
      supportedLocales: const [Locale('id'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
    );
  }
}

/// Tema aplikasi. Satu warna aksen (teal), sisanya skala netral dari
/// ColorScheme Material 3.
ThemeData _tema(Brightness kecerahan) {
  final skema = ColorScheme.fromSeed(
    seedColor: const Color(0xFF0F766E),
    brightness: kecerahan,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: skema,
    scaffoldBackgroundColor: skema.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: skema.surface,
      foregroundColor: skema.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
  );
}
