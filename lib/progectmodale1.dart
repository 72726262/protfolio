class Project {
  final String name;
  final String category;
  final String imageUrl;
  final String fullDescription;
  final List<String> technologies;
  final String projectUrl;
  final String? videoUrl;

  // المتغيرات الجديدة
  final List<String> challenges;
  final List<String> solutions;
  final List<String> databaseSchema;
  final List<String> supabaseFeatures;
  final List<String> features;

  Project({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.fullDescription,
    required this.technologies,
    required this.projectUrl,
    this.videoUrl,

    // إضافة المتغيرات الجديدة
    required this.challenges,
    required this.solutions,
    required this.databaseSchema,
    required this.supabaseFeatures,
    required this.features,
  });
}
