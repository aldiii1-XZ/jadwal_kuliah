import 'package:flutter/material.dart';

/// Satu mata kuliah dalam jadwal mingguan.
class Jadwal {
  Jadwal({
    required this.nama,
    required this.dosen,
    required this.ruang,
    required this.hari,
    required this.mulai,
    required this.selesai,
    this.warna = 0,
  });

  final String nama;
  final String dosen;
  final String ruang;
  final String hari;
  final TimeOfDay mulai;
  final TimeOfDay selesai;

  /// Indeks warna strip kartu, lihat [paletWarna].
  final int warna;

  String get jam => '${formatJam(mulai)} - ${formatJam(selesai)}';
}

/// Hari pada jadwal kuliah.
const List<String> daftarHari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

/// Palet strip kartu. Warna hanya dipakai untuk membedakan mata kuliah,
/// bukan hiasan.
const List<Color> paletWarna = [
  Color(0xFF0F766E),
  Color(0xFFB45309),
  Color(0xFF4338CA),
  Color(0xFFBE123C),
  Color(0xFF0E7490),
];

String formatJam(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

int menitKe(TimeOfDay t) => t.hour * 60 + t.minute;

/// Jam selesai harus setelah jam mulai.
bool jamValid(TimeOfDay mulai, TimeOfDay selesai) =>
    menitKe(selesai) > menitKe(mulai);

int durasiMenit(Jadwal jadwal) => menitKe(jadwal.selesai) - menitKe(jadwal.mulai);

String formatDurasi(int totalMenit) {
  final jam = totalMenit ~/ 60;
  final sisa = totalMenit % 60;
  if (jam == 0) return '$sisa menit';
  if (sisa == 0) return '$jam jam';
  return '$jam jam $sisa menit';
}
