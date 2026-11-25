import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

import 'support/portfolio_fixture.dart';

void main() {
  testWidgets('masuk, lihat proyek dari API, lalu keluar', (tester) async {
    final api = portfolioFixture();
    addTearDown(api.dispose);
    await tester.pumpWidget(MyApp(api: api));
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'pemilik');
    await tester.enterText(find.byType(TextFormField).at(1), 'kata-sandi-uji');
    await tester.tap(find.widgetWithText(FilledButton, 'Masuk'));
    await tester.pumpAndSettle();
    expect(find.text('pemilik'), findsOneWidget);

    await tester.tap(find.widgetWithText(ItemCard, 'Lihat Proyek'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skylite Musicals 2024'));
    await tester.pumpAndSettle();
    expect(find.text('Produksi musikal.'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    final logout = find.widgetWithText(ItemCard, 'Logout');
    await tester.ensureVisible(logout);
    await tester.tap(logout);
    await tester.pumpAndSettle();
    expect(find.text('pemilik'), findsNothing);
    expect(find.text('Masuk'), findsOneWidget);
  });
}
