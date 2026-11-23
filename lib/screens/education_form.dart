import 'package:material_ui/material_ui.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  static const _maxTextLength = 200;
  static final _yearPattern = RegExp(r'^[0-9]{4}$');

  final _formKey = GlobalKey<FormState>();
  final _institution = TextEditingController();
  final _program = TextEditingController();
  final _startYear = TextEditingController();
  final _endYear = TextEditingController();
  bool _isOngoing = false;

  @override
  void dispose() {
    _institution.dispose();
    _program.dispose();
    _startYear.dispose();
    _endYear.dispose();
    super.dispose();
  }

  String? _validateText(String? value, String label) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '$label wajib diisi.';
    if (text.runes.length > _maxTextLength) {
      return '$label maksimal $_maxTextLength karakter.';
    }
    return null;
  }

  int? _parseYear(String text) {
    if (!_yearPattern.hasMatch(text)) return null;
    final year = int.parse(text);
    return year > 0 ? year : null;
  }

  String? _validateStartYear(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Tahun masuk wajib diisi.';
    if (_parseYear(text) == null) return 'Masukkan tahun dengan 4 digit.';
    return null;
  }

  String? _validateEndYear(String? value) {
    final text = value?.trim() ?? '';
    if (_isOngoing || text.isEmpty) return null;
    final end = _parseYear(text);
    if (end == null) return 'Masukkan tahun dengan 4 digit.';
    final start = _parseYear(_startYear.text.trim());
    if (start != null && end < start) {
      return 'Tahun selesai tidak boleh sebelum tahun masuk.';
    }
    return null;
  }

  void _showSummary() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final end = _endYear.text.trim();
    final endLabel = _isOngoing || end.isEmpty ? 'Masih berlangsung' : end;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ringkasan Pendidikan'),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Institusi: ${_institution.text.trim()}'),
            const SizedBox(height: 8),
            Text('Program studi: ${_program.text.trim()}'),
            const SizedBox(height: 8),
            Text('Tahun masuk: ${_startYear.text.trim()}'),
            const SizedBox(height: 8),
            Text('Tahun selesai: $endLabel'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pendidikan'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _institution,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Nama institusi',
                        hintText: 'Contoh: Universitas Indonesia',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _validateText(value, 'Nama institusi'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _program,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Program studi',
                        hintText: 'Contoh: Sistem Informasi',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _validateText(value, 'Program studi'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _startYear,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Tahun masuk',
                        hintText: 'Contoh: 2025',
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateStartYear,
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Masih menempuh pendidikan'),
                      value: _isOngoing,
                      onChanged: (value) => setState(() => _isOngoing = value),
                    ),
                    if (!_isOngoing) ...[
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _endYear,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Tahun selesai (opsional)',
                          hintText: 'Contoh: 2029',
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateEndYear,
                      ),
                    ],
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: _showSummary,
                      icon: const Icon(Icons.check),
                      label: const Text('Simpan'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
