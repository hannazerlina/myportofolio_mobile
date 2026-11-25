import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

import 'support/portfolio_fixture.dart';

Finder field(String label) => find.byWidgetPredicate(
  (widget) => widget is TextField && widget.decoration?.labelText == label,
);

Future<void> openForm(WidgetTester tester) async {
  final api = portfolioFixture(owner: true);
  addTearDown(api.dispose);
  await api.refreshSession();
  await tester.pumpWidget(MyApp(api: api));
  final addCard = find.widgetWithText(ItemCard, 'Tambah Proyek');
  await tester.ensureVisible(addCard);
  await tester.tap(addCard);
  await tester.pumpAndSettle();
  // Let the menu SnackBar finish before tapping controls near the screen bottom.
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

Future<void> saveForm(WidgetTester tester) async {
  final save = find.widgetWithText(ElevatedButton, 'Save');
  await tester.ensureVisible(save);
  await tester.pumpAndSettle();
  await tester.tap(save);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('kartu menambahkan halaman form dan Back kembali ke Home', (
    tester,
  ) async {
    await openForm(tester);
    expect(find.byType(ProjectFormPage), findsOneWidget);
    final navigator = Navigator.of(
      tester.element(find.byType(ProjectFormPage)),
    );
    expect(navigator.canPop(), isTrue);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ProjectFormPage), findsNothing);
    expect(navigator.canPop(), isFalse);

    await openForm(tester);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Home'));
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ProjectFormPage), findsNothing);
    expect(navigator.canPop(), isFalse);
  });

  testWidgets('drawer mengganti halaman tanpa menumpuk salinan route', (
    tester,
  ) async {
    final api = portfolioFixture();
    addTearDown(api.dispose);
    await tester.pumpWidget(MyApp(api: api));
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Tambah Proyek'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(ProjectFormPage))).canPop(),
      isFalse,
    );

    await tester.enterText(field('Nama Proyek'), 'Draft proyek');
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Tambah Proyek'));
    await tester.pumpAndSettle();
    // Selecting the current destination only closes the drawer, keeping the draft.
    expect(find.text('Draft proyek'), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Home'));
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(MyHomePage))).canPop(),
      isFalse,
    );
  });

  testWidgets('isian kosong atau spasi ditolak sebelum dialog muncul', (
    tester,
  ) async {
    await openForm(tester);
    await saveForm(tester);
    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);

    await tester.enterText(field('Nama Proyek'), '   ');
    await tester.enterText(field('Deskripsi Proyek'), '   ');
    await saveForm(tester);
    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('dialog memuat lima isian dan OK mereset semua nilai', (
    tester,
  ) async {
    await openForm(tester);
    await tester.enterText(field('Nama Proyek'), ' Skylite Musicals 2024 ');
    await tester.enterText(
      field('Deskripsi Proyek'),
      ' Music director produksi musikal. ',
    );
    await tester.enterText(field('Peran'), 'Music Director');
    await tester.enterText(field('Tahun'), '2024');
    await tester.enterText(
      field('Tautan Proyek'),
      'https://example.com/project',
    );
    await saveForm(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Nama Proyek: Skylite Musicals 2024'), findsOneWidget);
    expect(
      find.text('Deskripsi: Music director produksi musikal.'),
      findsOneWidget,
    );
    expect(find.text('Peran: Music Director'), findsOneWidget);
    expect(find.text('Tahun: 2024'), findsOneWidget);
    expect(find.text('Tautan: https://example.com/project'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'OK'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    for (final editable in tester.widgetList<EditableText>(
      find.byType(EditableText),
    )) {
      expect(editable.controller.text, isEmpty);
    }

    // A new submission must not reuse optional values from the previous dialog.
    await tester.enterText(field('Nama Proyek'), 'Proyek berikutnya');
    await tester.enterText(field('Deskripsi Proyek'), 'Deskripsi baru');
    await tester.enterText(field('Peran'), 'Penulis');
    await tester.enterText(field('Tahun'), '2026');
    await saveForm(tester);
    expect(find.text('Nama Proyek: Proyek berikutnya'), findsOneWidget);
    expect(find.text('Tautan: -'), findsOneWidget);
  });

  testWidgets('form dan dialog panjang dapat digulir pada layar kecil', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await openForm(tester);
    await tester.enterText(field('Nama Proyek'), 'Proyek layar kecil');
    await tester.enterText(field('Peran'), 'Penulis');
    await tester.enterText(field('Tahun'), '2026');
    await tester.enterText(
      field('Deskripsi Proyek'),
      List.filled(30, 'Deskripsi panjang.').join(' '),
    );
    await saveForm(tester);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
    final dialogScroll = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(Scrollable),
    );
    await tester.scrollUntilVisible(
      find.text('Tautan: -'),
      150,
      scrollable: dialogScroll,
    );
    await tester.pumpAndSettle();
    expect(find.text('Tautan: -').hitTestable(), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'OK'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
