import 'package:flutter/material.dart';

import '../models/jadwal.dart';

/// Layar detail satu jadwal dengan aksi ubah dan hapus.
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.jadwal});

  final Jadwal jadwal;

  Future<void> _konfirmasiHapus(BuildContext context) async {
    final hapus = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus jadwal ini?'),
        content: Text(
            '${jadwal.nama} (${jadwal.hari}, ${jadwal.jam}) akan dihapus dari daftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (hapus == true && context.mounted) {
      Navigator.pop(context, 'hapus');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Jadwal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(jadwal.nama, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: Text(jadwal.hari)),
              Chip(label: Text(jadwal.jam)),
            ],
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Dosen'),
            subtitle: Text(jadwal.dosen),
          ),
          ListTile(
            leading: const Icon(Icons.place_outlined),
            title: const Text('Ruang'),
            subtitle: Text(jadwal.ruang),
          ),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text('Durasi'),
            subtitle: Text(formatDurasi(durasiMenit(jadwal))),
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context, 'ubah'),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Ubah'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _konfirmasiHapus(context),
                  icon: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  label: Text(
                    'Hapus',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
