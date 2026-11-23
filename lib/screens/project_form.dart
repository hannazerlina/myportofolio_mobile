import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  static const _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  String _projectName = '';
  String _description = '';
  String _category = _categories.first;
  String _technologies = '';
  String _projectLink = '';

  void _resetForm() {
    _formKey.currentState!.reset();
    // Clear both the visible fields and the values used by the next dialog.
    setState(() {
      _projectName = '';
      _description = '';
      _category = _categories.first;
      _technologies = '';
      _projectLink = '';
    });
  }

  void _showProject() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Proyek berhasil ditambahkan!'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Proyek: ${_projectName.trim()}'),
              Text('Deskripsi: ${_description.trim()}'),
              Text('Kategori: $_category'),
              Text(
                'Teknologi: ${_technologies.trim().isEmpty ? '-' : _technologies.trim()}',
              ),
              Text(
                'Tautan: ${_projectLink.trim().isEmpty ? '-' : _projectLink.trim()}',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _resetForm();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Proyek'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(currentPage: PortfolioPage.projectForm),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nama Proyek',
                        hintText: 'Nama Proyek',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) =>
                          setState(() => _projectName = value),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama proyek tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi Proyek',
                        hintText: 'Deskripsi Proyek',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) =>
                          setState(() => _description = value),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Deskripsi proyek tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField<String>(
                      // A fixed initial value also restores the default on reset.
                      initialValue: _categories.first,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Kategori Proyek',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _category = value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Teknologi yang Digunakan',
                        hintText: 'Contoh: Flutter, Django, Figma',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) =>
                          setState(() => _technologies = value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        labelText: 'Tautan Proyek',
                        hintText: 'URL Proyek (opsional)',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) =>
                          setState(() => _projectLink = value),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _showProject,
                        child: const Text('Save'),
                      ),
                    ),
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
