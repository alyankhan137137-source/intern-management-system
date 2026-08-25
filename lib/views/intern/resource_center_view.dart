import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/models/resource.dart';
import 'package:intern_management_system/services/app_repository.dart';

class ResourceCenterView extends StatefulWidget {
  const ResourceCenterView({super.key});

  @override
  State<ResourceCenterView> createState() => _ResourceCenterViewState();
}

class _ResourceCenterViewState extends State<ResourceCenterView> {
  final _repository = AppRepository();
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ..._repository.resources.map((r) => r.category).toSet()];
    final filteredResources = _selectedCategory == 'All'
        ? _repository.resources
        : _repository.resources.where((r) => r.category == _selectedCategory).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource Center'),
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedCategory = cat),
                    backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
                    selectedColor: AppColors.accent.withOpacity(0.2),
                    checkmarkColor: AppColors.accent,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.accent : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColors.accent : (isDark ? AppColors.darkBorder : Colors.grey[300]!),
                    ),
                  ),
                );
              },
            ),
          ),

        // Resource Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.lg),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.85,
            ),
            itemCount: filteredResources.length,
            itemBuilder: (context, index) {
              final res = filteredResources[index];
              return _ResourceCard(resource: res);
            },
          ),
        ),
      ],
    ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final ResourceModel resource;
  const _ResourceCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardRadius,
        side: BorderSide(color: isDark ? AppColors.darkBorder : const Color(0xFFE2E8F0)),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening ${resource.title}...')),
          );
        },
        borderRadius: AppRadius.cardRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getTypeColor(resource.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(_getTypeIcon(resource.type), color: _getTypeColor(resource.type), size: 24),
              ),
              const Spacer(),
              Text(
                resource.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                resource.category,
                style: TextStyle(color: Colors.grey[600], fontSize: 11),
              ),
              const SizedBox(height: 8),
              Text(
                resource.description,
                style: const TextStyle(fontSize: 11),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon(ResourceType type) {
    switch (type) {
      case ResourceType.video: return Icons.play_circle_outline;
      case ResourceType.pdf: return Icons.picture_as_pdf_outlined;
      case ResourceType.link: return Icons.link_rounded;
    }
  }

  Color _getTypeColor(ResourceType type) {
    switch (type) {
      case ResourceType.video: return Colors.red;
      case ResourceType.pdf: return Colors.blue;
      case ResourceType.link: return Colors.green;
    }
  }
}
