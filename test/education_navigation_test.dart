import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

import 'support/portfolio_fixture.dart';

Future<void> _chooseDrawerItem(WidgetTester tester, String label) async {
  await tester.tap(find.byTooltip('Open navigation menu'));
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(ListTile, label));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('kartu Pendidikan membuka form dan tombol Back kembali ke Home', (
    tester,
  ) async {
    final api = portfolioFixture();
    addTearDown(api.dispose);
    await tester.pumpWidget(MyApp(api: api));
    final card = find.widgetWithText(ItemCard, 'Tambah Pendidikan');
    await tester.ensureVisible(card);
    await tester.tap(card);
    await tester.pumpAndSettle();
    expect(find.byType(EducationFormPage), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(EducationFormPage), findsNothing);

    await tester.ensureVisible(card);
    await tester.tap(card);
    await tester.pumpAndSettle();
    await _chooseDrawerItem(tester, 'Home');
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(MyHomePage))).canPop(),
      isFalse,
    );
  });

  testWidgets('drawer membuka Pendidikan, Proyek, dan Home dari rute utama', (
    tester,
  ) async {
    final api = portfolioFixture();
    addTearDown(api.dispose);
    await tester.pumpWidget(MyApp(api: api));
    await _chooseDrawerItem(tester, 'Tambah Pendidikan');
    expect(find.byType(EducationFormPage), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(EducationFormPage))).canPop(),
      isFalse,
    );

    await _chooseDrawerItem(tester, 'Home');
    expect(find.byType(MyHomePage), findsOneWidget);
    await _chooseDrawerItem(tester, 'Tambah Pendidikan');
    await _chooseDrawerItem(tester, 'Tambah Proyek');
    expect(find.byType(ProjectFormPage), findsOneWidget);
    await _chooseDrawerItem(tester, 'Home');
    expect(find.byType(MyHomePage), findsOneWidget);
  });
}
