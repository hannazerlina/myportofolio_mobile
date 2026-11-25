class PortfolioProject {
  const PortfolioProject({
    required this.id,
    required this.title,
    required this.role,
    required this.year,
    required this.description,
    required this.spotifyUrl,
  });

  factory PortfolioProject.fromJson(Map<String, dynamic> json) {
    return PortfolioProject(
      id: json['id'] as int,
      title: json['title'] as String,
      role: json['role'] as String,
      year: json['year'] as int,
      description: json['description'] as String,
      spotifyUrl: json['spotify_url'] as String? ?? '',
    );
  }

  final int id;
  final String title;
  final String role;
  final int year;
  final String description;
  final String spotifyUrl;
}
