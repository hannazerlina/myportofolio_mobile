import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const items = [
    ItemHomepage('Lihat Proyek', Icons.folder_outlined, Color(0xFF234E99)),
    ItemHomepage(
      'Tambah Proyek',
      Icons.add_circle_outline,
      Color(0xFF26775E),
      buildPage: _projectForm,
    ),
    ItemHomepage(
      'Tambah Pendidikan',
      Icons.school_outlined,
      Color(0xFF6B4A91),
      buildPage: _educationForm,
    ),
    ItemHomepage('Logout', Icons.logout, Color(0xFF9B4A3D)),
  ];

  static Widget _projectForm(BuildContext _) => const ProjectFormPage();

  static Widget _educationForm(BuildContext _) => const EducationFormPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPortfolio'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Wrap keeps identity and action cards readable on narrower screens.
          final width = constraints.maxWidth;
          final columns = width < 440 ? 1 : (width < 720 ? 2 : 3);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hi, I’m Hanna!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Information Systems · Universitas Indonesia'),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, box) {
                        final cardWidth = box.maxWidth < 500
                            ? box.maxWidth
                            : (box.maxWidth - 24) / 3;
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: cardWidth,
                              child: const InfoCard(
                                title: 'NPM',
                                content: '2506594692',
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: const InfoCard(
                                title: 'Name',
                                content: 'Hanna Zerlina Razaq Putri Wicaksono',
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: const InfoCard(
                                title: 'Class',
                                content: 'PBP E',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Menu portofolio',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Pilih menu untuk mencoba aksinya.'),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 1 ? 3 : 1.5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: items.map((item) => ItemCard(item)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
