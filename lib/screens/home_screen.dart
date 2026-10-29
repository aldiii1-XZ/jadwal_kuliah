import 'package:flutter/material.dart';

import '../data/data_contoh.dart';
import '../models/jadwal.dart';
import '../widgets/kartu_jadwal.dart';
import 'detail_screen.dart';
import 'form_screen.dart';

/// Layar utama: daftar jadwal per hari.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Jadwal> _semuaJadwal = List.of(dataContoh);
  String _hariTerpilih = daftarHari.first;

  List<Jadwal> get _jadwalHariIni {
    final daftar =
        _semuaJadwal.where((jadwal) => jadwal.hari == _hariTerpilih).toList();
    daftar.sort((a, b) => menitKe(a.mulai).compareTo(menitKe(b.mulai)));
    return daftar;
  }

  void _pesan(String teks) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(teks)));
  }

  Future<void> _bukaForm({Jadwal? awal}) async {
    final hasil = await Navigator.push<Jadwal>(
      context,
      MaterialPageRoute(builder: (_) => FormScreen(awal: awal)),
    );
    if (hasil == null) return;
    setState(() {
      if (awal == null) {
        _semuaJadwal.add(hasil);
      } else {
        final posisi = _semuaJadwal.indexOf(awal);
        if (posisi >= 0) _semuaJadwal[posisi] = hasil;
      }
      _hariTerpilih = hasil.hari;
    });
    _pesan(awal == null ? 'Jadwal ditambahkan.' : 'Jadwal diperbarui.');
  }

  Future<void> _bukaDetail(Jadwal jadwal) async {
    final aksi = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(jadwal: jadwal)),
    );
    if (aksi == 'hapus') {
      setState(() => _semuaJadwal.remove(jadwal));
      _pesan('Jadwal dihapus.');
    } else if (aksi == 'ubah') {
      await _bukaForm(awal: jadwal);
    }
  }

  @override
  Widget build(BuildContext context) {
    final jadwalHariIni = _jadwalHariIni;
    final totalMenit =
        jadwalHariIni.fold(0, (jumlah, jadwal) => jumlah + durasiMenit(jadwal));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kuliah'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                for (final hari in daftarHari)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(hari),
                      selected: hari == _hariTerpilih,
                      onSelected: (_) => setState(() => _hariTerpilih = hari),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Text(
              jadwalHariIni.isEmpty
                  ? 'Belum ada jadwal hari $_hariTerpilih.'
                  : '${jadwalHariIni.length} mata kuliah · ${formatDurasi(totalMenit)}',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: jadwalHariIni.isEmpty
                ? const _KeadaanKosong()
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
                    children: [
                      for (final jadwal in jadwalHariIni)
                        KartuJadwal(
                          jadwal: jadwal,
                          onTap: () => _bukaDetail(jadwal),
                        ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bukaForm(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}

/// Tampilan saat satu hari tidak punya jadwal.
class _KeadaanKosong extends StatelessWidget {
  const _KeadaanKosong();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.event_busy_outlined, size: 48, color: scheme.outline),
          const SizedBox(height: 12),
          Text('Hari ini kosong', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(
            'Tekan tombol Tambah untuk mengisi jadwal.',
            style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
