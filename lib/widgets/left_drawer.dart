import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, this.isProjectForm = false});

  final bool isProjectForm;

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
            selected: !isProjectForm,
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              if (!isProjectForm) return;
              if (navigator.canPop()) {
                // The home card pushed the form above the existing Home route.
                navigator.pop();
              } else {
                navigator.pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Tambah Proyek'),
            selected: isProjectForm,
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              if (!isProjectForm) {
                navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ProjectFormPage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
