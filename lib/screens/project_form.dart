import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/auth_page.dart';
import 'package:myportofolio_mobile/services/portfolio_api.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _role = TextEditingController();
  final _year = TextEditingController();
  final _description = TextEditingController();
  final _link = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _role.dispose();
    _year.dispose();
    _description.dispose();
    _link.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    final api = context.read<PortfolioApi>();
    if (!api.canManageProjects) {
      setState(
        () => _error = 'Masuk sebagai pemilik portofolio untuk menyimpan.',
      );
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final project = await api.createProject(
        title: _title.text.trim(),
        role: _role.text.trim(),
        year: int.parse(_year.text.trim()),
        description: _description.text.trim(),
        spotifyUrl: _link.text.trim(),
      );
      if (!mounted) return;
      // Clear the submitted values only after the server confirms the save.
      _formKey.currentState!.reset();
      for (final field in [_title, _role, _year, _description, _link]) {
        field.clear();
      }
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          scrollable: true,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama Proyek: ${project.title}'),
              Text('Peran: ${project.role}'),
              Text('Tahun: ${project.year}'),
              Text('Deskripsi: ${project.description}'),
              Text(
                'Tautan: ${project.spotifyUrl.isEmpty ? '-' : project.spotifyUrl}',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: !_saving,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final api = context.watch<PortfolioApi>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Proyek'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      drawer: const LeftDrawer(currentPage: PortfolioPage.projectForm),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _field(
                    'Nama Proyek',
                    _title,
                    validator: (value) {
                      final text = (value ?? '').trim();
                      if (text.isEmpty) {
                        return 'Nama proyek tidak boleh kosong!';
                      }
                      if (text.runes.length > 200) {
                        return 'Maksimal 200 karakter.';
                      }
                      return null;
                    },
                  ),
                  _field(
                    'Peran',
                    _role,
                    validator: (value) {
                      final text = (value ?? '').trim();
                      if (text.isEmpty) return 'Masukkan peran dalam proyek.';
                      if (text.runes.length > 100) {
                        return 'Maksimal 100 karakter.';
                      }
                      return null;
                    },
                  ),
                  _field(
                    'Tahun',
                    _year,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final year = int.tryParse((value ?? '').trim());
                      return year == null || year < 1 || year > 9999
                          ? 'Masukkan tahun yang valid.'
                          : null;
                    },
                  ),
                  _field(
                    'Deskripsi Proyek',
                    _description,
                    maxLines: 5,
                    validator: (value) => (value ?? '').trim().isEmpty
                        ? 'Deskripsi proyek tidak boleh kosong!'
                        : null,
                  ),
                  _field(
                    'Tautan Proyek',
                    _link,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      final text = (value ?? '').trim();
                      if (text.isEmpty) return null;
                      final url = Uri.tryParse(text);
                      if (url == null ||
                          !url.hasAuthority ||
                          (url.scheme != 'https' && url.scheme != 'http') ||
                          text.runes.length > 200) {
                        return 'Masukkan URL HTTP/HTTPS hingga 200 karakter.';
                      }
                      return null;
                    },
                  ),
                  if (api.username == null)
                    TextButton(
                      onPressed: () => Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => const AuthPage(),
                        ),
                      ),
                      child: const Text('Masuk untuk menyimpan proyek'),
                    ),
                  if (_error != null) ...[
                    Text(
                      _error!,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                    const SizedBox(height: 12),
                  ],
                  ElevatedButton(
                    onPressed: _saving ? null : _save,
                    child: Text(_saving ? 'Menyimpan…' : 'Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
