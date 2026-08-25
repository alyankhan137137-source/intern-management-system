enum ResourceType { video, pdf, link }

class ResourceModel {
  final String id;
  final String title;
  final String category;
  final ResourceType type;
  final String url;
  final String description;

  ResourceModel({
    required this.id,
    required this.title,
    required this.category,
    required this.type,
    required this.url,
    required this.description,
  });
}
