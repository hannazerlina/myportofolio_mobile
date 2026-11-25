import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

import 'support/portfolio_fixture.dart';

void main() {
  testWidgets('menampilkan profil dan empat menu dengan warna berbeda', (
    tester,
  ) async {
    final api = portfolioFixture();
    addTearDown(api.dispose);
    await tester.pumpWidget(MyApp(api: api));
    expect(find.text('Hanna Zerlina Razaq Putri Wicaksono'), findsOneWidget);
    expect(find.text('2506594692'), findsOneWidget);
    expect(find.text('PBP E'), findsOneWidget);
    expect(find.byType(ItemCard), findsNWidgets(4));
    final cards = tester.widgetList<ItemCard>(find.byType(ItemCard)).toList();
    expect(cards.map((card) => card.item.color).toSet().length, 4);
    for (final item in MyHomePage.items) {
      expect(find.text(item.name), findsOneWidget);
      expect(find.byIcon(item.icon), findsOneWidget);
      final title = find.text(item.name);
      await tester.ensureVisible(title);
      await tester.tap(title);
      await tester.pumpAndSettle();
      expect(
        find.text(
          item.name == 'Logout'
              ? 'Kamu belum masuk.'
              : 'Kamu telah menekan tombol ${item.name}!',
        ),
        findsOneWidget,
      );
      if (item.buildPage != null) {
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
      }
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    }
  });

  testWidgets('halaman dapat discroll pada layar kecil', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final api = portfolioFixture();
    addTearDown(api.dispose);
    await tester.pumpWidget(MyApp(api: api));
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
