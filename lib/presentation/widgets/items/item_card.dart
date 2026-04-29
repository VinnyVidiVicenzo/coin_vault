import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/models/item.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/grade_utils.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final obverse = item.images.where((i) => i.imageType == 'obverse').firstOrNull;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            _thumbnail(obverse?.publicUrl),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _TypeBadge(item.itemType),
                        const SizedBox(width: 8),
                        if (item.isSlabbed && item.gradingCompany != null)
                          _GradingBadge(item.gradingCompany!),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.grade != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: GradeUtils.colorForNumericGrade(item.gradeNumeric),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(item.grade!,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      _subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            if (item.isPublic)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.public,
                    size: 16, color: AppColors.primary.withValues(alpha: 0.6)),
              ),
          ],
        ),
      ),
    );
  }

  String get _title {
    final parts = [
      if (item.country != null) item.country!,
      if (item.denomination != null) item.denomination!,
      if (item.yearStart != null) item.yearStart.toString(),
    ];
    return parts.isNotEmpty ? parts.join(' • ') : 'Untitled item';
  }

  String get _subtitle {
    final parts = [
      if (item.mintMark != null) item.mintMark!,
      if (item.series != null) item.series!,
      if (item.variety != null) item.variety!,
    ];
    return parts.isNotEmpty ? parts.join(' • ') : '';
  }

  Widget _thumbnail(String? url) {
    return SizedBox(
      width: 80,
      height: 80,
      child: url != null
          ? CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (_, __) => const _PlaceholderThumbnail(),
              errorWidget: (_, __, ___) => const _PlaceholderThumbnail(),
            )
          : const _PlaceholderThumbnail(),
    );
  }
}

class _PlaceholderThumbnail extends StatelessWidget {
  const _PlaceholderThumbnail();

  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.primary.withValues(alpha: 0.05),
        child: const Icon(Icons.monetization_on_outlined,
            color: AppColors.primary, size: 32),
      );
}

class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge(this.type);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          type.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
      );
}

class _GradingBadge extends StatelessWidget {
  final String company;
  const _GradingBadge(this.company);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          company,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(
                color: AppColors.accentDark,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
}
