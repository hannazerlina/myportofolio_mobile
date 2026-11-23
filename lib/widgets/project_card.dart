import 'package:material_ui/material_ui.dart';

/// One action shown on the portfolio home page.
class ItemHomepage {
  const ItemHomepage(this.name, this.icon, this.color, {this.buildPage});

  final String name;
  final IconData icon;
  final Color color;
  final WidgetBuilder? buildPage;
}

class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {super.key});

  final ItemHomepage item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
              ),
            );
          final buildPage = item.buildPage;
          if (buildPage != null) {
            // Push keeps Home in the stack for the system Back button.
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(builder: buildPage),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
