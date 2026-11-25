import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/portfolio_project.dart';
import 'package:myportofolio_mobile/services/portfolio_api.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  late Future<List<PortfolioProject>> _projects;

  @override
  void initState() {
    super.initState();
    _projects = context.read<PortfolioApi>().listProjects();
  }

  Future<void> _reload() async {
    final future = context.read<PortfolioApi>().listProjects();
    setState(() => _projects = future);
    try {
      await future;
    } catch (_) {
      // FutureBuilder shows the error and retry action.
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Proyek'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        actions: [
          IconButton(
            onPressed: _reload,
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: const LeftDrawer(currentPage: PortfolioPage.projects),
      body: FutureBuilder<List<PortfolioProject>>(
        future: _projects,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    snapshot.error is ApiException
                        ? snapshot.error.toString()
                        : 'Data proyek tidak dapat dibaca.',
                  ),
                  TextButton(
                    onPressed: _reload,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            );
          }
          final projects = snapshot.data!;
          if (projects.isEmpty) {
            return const Center(child: Text('Belum ada proyek.'));
          }
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: projects.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final project = projects[index];
                return Card(
                  child: ListTile(
                    title: Text(project.title),
                    subtitle: Text('${project.role} · ${project.year}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => ProjectDetailPage(id: project.id),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key, required this.id});

  final int id;

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late Future<PortfolioProject> _project;

  @override
  void initState() {
    super.initState();
    _project = context.read<PortfolioApi>().project(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Proyek'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: FutureBuilder<PortfolioProject>(
        future: _project,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    snapshot.error is ApiException
                        ? snapshot.error.toString()
                        : 'Detail proyek tidak dapat dibaca.',
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      _project = context.read<PortfolioApi>().project(
                        widget.id,
                      );
                    }),
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            );
          }
          final project = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(project.title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('${project.role} · ${project.year}'),
              const SizedBox(height: 16),
              Text(project.description),
              if (project.spotifyUrl.isNotEmpty) ...[
                const SizedBox(height: 16),
                SelectableText(project.spotifyUrl),
              ],
            ],
          );
        },
      ),
    );
  }
}
