import 'package:flutter/material.dart';

import '../models/jadwal.dart';

/// Layar tambah/ubah jadwal.
class FormScreen extends StatefulWidget {
  const FormScreen({super.key, this.awal});

  /// Kalau diisi, form dipakai untuk mengubah jadwal ini.
  final Jadwal? awal;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nama;
  late final TextEditingController _dosen;
  late final TextEditingController _ruang;
  late String _hari;
  late TimeOfDay _mulai;
  late TimeOfDay _selesai;

  @override
  void initState() {
    super.initState();
    final awal = widget.awal;
    _nama = TextEditingController(text: awal?.nama ?? '');
    _dosen = TextEditingController(text: awal?.dosen ?? '');
    _ruang = TextEditingController(text: awal?.ruang ?? '');
    _hari = awal?.hari ?? daftarHari.first;
    _mulai = awal?.mulai ?? const TimeOfDay(hour: 8, minute: 0);
    _selesai = awal?.selesai ?? const TimeOfDay(hour: 10, minute: 0);
  }

  @override
  void dispose() {
    _nama.dispose();
    _dosen.dispose();
    _ruang.dispose();
    super.dispose();
  }

  Future<void> _pilihJam({required bool mulai}) async {
    final hasil = await showTimePicker(
      context: context,
      initialTime: mulai ? _mulai : _selesai,
    );
    if (hasil == null) return;
    setState(() {
      if (mulai) {
        _mulai = hasil;
      } else {
        _selesai = hasil;
      }
    });
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    final nama = _nama.text.trim();
    Navigator.pop(
      context,
      Jadwal(
        nama: nama,
        dosen: _dosen.text.trim().isEmpty ? '-' : _dosen.text.trim(),
        ruang: _ruang.text.trim().isEmpty ? '-' : _ruang.text.trim(),
        hari: _hari,
        mulai: _mulai,
        selesai: _selesai,
        warna: widget.awal?.warna ?? nama.hashCode % paletWarna.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ubah = widget.awal != null;
    final jamOke = jamValid(_mulai, _selesai);

    return Scaffold(
      appBar: AppBar(title: Text(ubah ? 'Ubah Jadwal' : 'Tambah Jadwal')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nama,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nama mata kuliah',
                border: OutlineInputBorder(),
              ),
              validator: (nilai) => (nilai == null || nilai.trim().isEmpty)
                  ? 'Nama mata kuliah wajib diisi.'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dosen,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Dosen pengampu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ruang,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Ruang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _hari,
              decoration: const InputDecoration(
                labelText: 'Hari',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final hari in daftarHari)
                  DropdownMenuItem(value: hari, child: Text(hari)),
              ],
              onChanged: (nilai) => setState(() => _hari = nilai ?? _hari),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _TombolJam(
                    label: 'Mulai',
                    jam: formatJam(_mulai),
                    onTap: () => _pilihJam(mulai: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TombolJam(
                    label: 'Selesai',
                    jam: formatJam(_selesai),
                    onTap: () => _pilihJam(mulai: false),
                  ),
                ),
              ],
            ),
            if (!jamOke)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Jam selesai harus setelah jam mulai.',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: jamOke ? _simpan : null,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kotak pilih jam yang membuka dialog waktu.
class _TombolJam extends StatelessWidget {
  const _TombolJam({
    required this.label,
    required this.jam,
    required this.onTap,
  });

  final String label;
  final String jam;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        alignment: Alignment.centerLeft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(jam, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
