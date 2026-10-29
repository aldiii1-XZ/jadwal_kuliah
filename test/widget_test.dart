import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jadwal_kuliah/main.dart';
import 'package:jadwal_kuliah/models/jadwal.dart';

void main() {
  test('jamValid: jam selesai harus setelah jam mulai', () {
    expect(
      jamValid(const TimeOfDay(hour: 8, minute: 0),
          const TimeOfDay(hour: 10, minute: 0)),
      isTrue,
    );
    expect(
      jamValid(const TimeOfDay(hour: 10, minute: 0),
          const TimeOfDay(hour: 8, minute: 0)),
      isFalse,
    );
    expect(
      jamValid(const TimeOfDay(hour: 8, minute: 0),
          const TimeOfDay(hour: 8, minute: 0)),
      isFalse,
    );
  });

  testWidgets('layar utama menampilkan jadwal hari Senin', (tester) async {
    await tester.pumpWidget(const JadwalKuliahApp());

    expect(find.text('Jadwal Kuliah'), findsOneWidget);
    expect(find.text('Pemrograman Aplikasi Bergerak 1'), findsOneWidget);
    expect(find.text('2 mata kuliah · 5 jam'), findsOneWidget);
  });

  testWidgets('pindah hari mengganti daftar jadwal', (tester) async {
    await tester.pumpWidget(const JadwalKuliahApp());

    await tester.tap(find.text('Rabu'));
    await tester.pumpAndSettle();

    expect(find.text('Perancangan Sistem Informasi'), findsOneWidget);
    expect(find.text('Pemrograman Aplikasi Bergerak 1'), findsNothing);
  });

  testWidgets('menambah jadwal baru lewat form', (tester) async {
    await tester.pumpWidget(const JadwalKuliahApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Tambah Jadwal'), findsOneWidget);

    await tester.enterText(
        find.byType(TextFormField).first, 'Sistem Informasi Akuntansi');
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Sistem Informasi Akuntansi'), findsOneWidget);
  });
}
