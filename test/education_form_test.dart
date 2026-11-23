import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';

Finder _field(String label) => find.byWidgetPredicate(
  (widget) => widget is TextField && widget.decoration?.labelText == label,
);

Future<void> _enter(WidgetTester tester, String label, String value) async {
  final field = _field(label);
  await tester.ensureVisible(field);
  await tester.pumpAndSettle();
  await tester.enterText(field, value);
}

Future<void> _save(WidgetTester tester) async {
  final save = find.widgetWithText(FilledButton, 'Simpan');
  await tester.ensureVisible(save);
  await tester.pumpAndSettle();
  await tester.tap(save);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('menolak nama kosong, teks panjang, dan tahun yang salah', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: EducationFormPage()));
    await _enter(tester, 'Nama institusi', '  ');
    await _enter(tester, 'Program studi', 'P' * 201);
    await _enter(tester, 'Tahun masuk', '20x5');
    await _enter(tester, 'Tahun selesai (opsional)', '202');
    await _save(tester);

    expect(find.text('Nama institusi wajib diisi.'), findsOneWidget);
    expect(find.text('Program studi maksimal 200 karakter.'), findsOneWidget);
    expect(find.text('Masukkan tahun dengan 4 digit.'), findsNWidgets(2));
    expect(find.byType(AlertDialog), findsNothing);

    await _enter(tester, 'Nama institusi', 'Universitas Indonesia');
    await _enter(tester, 'Program studi', 'Sistem Informasi');
    await _enter(tester, 'Tahun masuk', '2025');
    await _enter(tester, 'Tahun selesai (opsional)', '2024');
    await _save(tester);
    expect(
      find.text('Tahun selesai tidak boleh sebelum tahun masuk.'),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);

    await _enter(tester, 'Tahun selesai (opsional)', '2029');
    await _save(tester);
    expect(find.text('Institusi: Universitas Indonesia'), findsOneWidget);
    expect(find.text('Program studi: Sistem Informasi'), findsOneWidget);
    expect(find.text('Tahun masuk: 2025'), findsOneWidget);
    expect(find.text('Tahun selesai: 2029'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Tutup'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(
      tester.widget<TextField>(_field('Program studi')).controller!.text,
      'Sistem Informasi',
    );
  });

  testWidgets('form dapat disimpan di layar sempit dengan papan ketik tampil', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 580);
    tester.view.viewInsets = const FakeViewPadding(bottom: 240);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpWidget(const MaterialApp(home: EducationFormPage()));

    await _enter(tester, 'Nama institusi', 'Universitas Indonesia');
    await _enter(tester, 'Program studi', 'Sistem Informasi');
    await _enter(tester, 'Tahun masuk', '2025');
    final ongoing = find.widgetWithText(
      SwitchListTile,
      'Masih menempuh pendidikan',
    );
    await tester.ensureVisible(ongoing);
    await tester.pumpAndSettle();
    await tester.tap(ongoing);
    await tester.pumpAndSettle();

    expect(_field('Tahun selesai (opsional)'), findsNothing);
    await _save(tester);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Tahun selesai: Masih berlangsung'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
