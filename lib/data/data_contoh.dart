import 'package:flutter/material.dart';

import '../models/jadwal.dart';

/// Data contoh supaya aplikasi langsung ada isinya saat dijalankan.
/// Silakan ganti dengan jadwal asli masing-masing.
final List<Jadwal> dataContoh = [
  Jadwal(
    nama: 'Pemrograman Aplikasi Bergerak 1',
    dosen: 'Pak Farisi',
    ruang: 'Lab Mobile',
    hari: 'Senin',
    mulai: const TimeOfDay(hour: 8, minute: 0),
    selesai: const TimeOfDay(hour: 10, minute: 30),
    warna: 0,
  ),
  Jadwal(
    nama: 'Basis Data',
    dosen: 'Bu Sari',
    ruang: 'A305',
    hari: 'Senin',
    mulai: const TimeOfDay(hour: 13, minute: 0),
    selesai: const TimeOfDay(hour: 15, minute: 30),
    warna: 1,
  ),
  Jadwal(
    nama: 'Pemrograman Web II',
    dosen: 'Pak Rachmat',
    ruang: 'Lab Web',
    hari: 'Selasa',
    mulai: const TimeOfDay(hour: 9, minute: 40),
    selesai: const TimeOfDay(hour: 12, minute: 10),
    warna: 2,
  ),
  Jadwal(
    nama: 'Perancangan Sistem Informasi',
    dosen: 'Dr. Antonius W.',
    ruang: 'B204',
    hari: 'Rabu',
    mulai: const TimeOfDay(hour: 8, minute: 0),
    selesai: const TimeOfDay(hour: 10, minute: 30),
    warna: 3,
  ),
  Jadwal(
    nama: 'Inovasi Digital',
    dosen: 'Tim Dosen',
    ruang: 'C101',
    hari: 'Rabu',
    mulai: const TimeOfDay(hour: 13, minute: 0),
    selesai: const TimeOfDay(hour: 15, minute: 30),
    warna: 4,
  ),
  Jadwal(
    nama: 'Kecerdasan Buatan',
    dosen: 'Bu Ratna',
    ruang: 'Lab AI',
    hari: 'Kamis',
    mulai: const TimeOfDay(hour: 10, minute: 30),
    selesai: const TimeOfDay(hour: 13, minute: 0),
    warna: 0,
  ),
  Jadwal(
    nama: 'Sistem Enterprise',
    dosen: 'Pak Hendra',
    ruang: 'D302',
    hari: 'Jumat',
    mulai: const TimeOfDay(hour: 8, minute: 0),
    selesai: const TimeOfDay(hour: 10, minute: 30),
    warna: 1,
  ),
];
