import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
        ItemHomepage('Lihat Proyek', Icons.folder),
        ItemHomepage('Tambah Proyek', Icons.add_circle),
        ItemHomepage('Logout', Icons.logout),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPortfolio'),
      ),
     body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            children: [
                const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                            child: InfoCard(
                                title: 'NPM',
                                content: '2506594692',
                            ),
                        ),
                        Expanded(
                            child: InfoCard(
                                title: 'Nama',
                                content: 'Hanna Zerlina',
                                ),
                        ),
                        Expanded(
                            child: InfoCard(
                                title: 'Kelas',
                                content: 'PBP E',
                                ),
                        ),
                    ],
                ),
                const SizedBox(height: 24),
                const Text('Selamat datang di MyPortfolio Mobile!'),
                GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    children: items.map((item) => ItemCard(item)).toList(),
                ),
            ],
        ),
        ),
    );
  }
}

class InfoCard extends StatelessWidget {
    final String title;
    final String content;

    const InfoCard({
        super.key,
        required this.title,
        required this.content,
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;

  ItemHomepage(this.name, this.icon);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu menekan tombol ${item.name}!'),
              ),
            );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}