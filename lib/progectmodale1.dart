class Project {
  final String name;
  final String category;
  final String imageUrl;
  final String fullDescription;
  final List<String> technologies;

  final String projectUrl;
  final String? videoUrl; // غير من youtubeUrl إلى videoUrl

  Project({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.fullDescription,
    required this.technologies,

    required this.projectUrl,
    this.videoUrl, // غير من youtubeUrl إلى videoUrl
  });
}
