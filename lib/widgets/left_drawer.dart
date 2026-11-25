import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list.dart';

enum PortfolioPage { home, projects, projectForm, educationForm }

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, this.currentPage = PortfolioPage.home});

  final PortfolioPage currentPage;

  void _openPage(BuildContext context, PortfolioPage destination) {
    final navigator = Navigator.of(context);
    navigator.pop(); // Close the drawer before checking the page stack.
    if (destination == currentPage) return;

    if (destination == PortfolioPage.home && navigator.canPop()) {
      navigator.pop(); // Reuse Home when a card pushed a form above it.
      return;
    }

    navigator.pushReplacement<void, void>(
      MaterialPageRoute<void>(
        builder: (context) => switch (destination) {
          PortfolioPage.home => const MyHomePage(),
          PortfolioPage.projects => const ProjectListPage(),
          PortfolioPage.projectForm => const ProjectFormPage(),
          PortfolioPage.educationForm => const EducationFormPage(),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MyPortfolio',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text('Hanna Zerlina', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            selected: currentPage == PortfolioPage.home,
            onTap: () => _openPage(context, PortfolioPage.home),
          ),
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('Lihat Proyek'),
            selected: currentPage == PortfolioPage.projects,
            onTap: () => _openPage(context, PortfolioPage.projects),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Tambah Proyek'),
            selected: currentPage == PortfolioPage.projectForm,
            onTap: () => _openPage(context, PortfolioPage.projectForm),
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Tambah Pendidikan'),
            selected: currentPage == PortfolioPage.educationForm,
            onTap: () => _openPage(context, PortfolioPage.educationForm),
          ),
        ],
      ),
    );
  }
}
