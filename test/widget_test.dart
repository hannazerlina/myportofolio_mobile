import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

void main() {
  testWidgets('menampilkan profil dan tiga menu dengan warna berbeda', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hanna Zerlina Razaq Putri Wicaksono'), findsOneWidget);
    expect(find.text('2506594692'), findsOneWidget);
    expect(find.text('PBP E'), findsOneWidget);
    expect(find.byType(ItemCard), findsNWidgets(3));
    final cards = tester.widgetList<ItemCard>(find.byType(ItemCard)).toList();
    expect(cards.map((card) => card.item.color).toSet().length, 3);
    for (final item in MyHomePage.items) {
      expect(find.text(item.name), findsOneWidget);
      expect(find.byIcon(item.icon), findsOneWidget);
      await tester.tap(find.text(item.name));
      await tester.pumpAndSettle();
      expect(
        find.text('Kamu telah menekan tombol ${item.name}!'),
        findsOneWidget,
      );
      if (item.name == 'Tambah Proyek') {
        Navigator.of(tester.element(find.byType(ProjectFormPage))).pop();
        await tester.pumpAndSettle();
      }
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    }
  });

  testWidgets('halaman dapat discroll pada layar kecil', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MyApp());
    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(
      find.text('Logout'),
      150,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Logout'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
