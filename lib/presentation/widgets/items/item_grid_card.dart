import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/models/item.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/grade_utils.dart';

class ItemGridCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const ItemGridCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final obverse = item.images.where((i) => i.imageType == 'obverse').firstOrNull;
    final reverse = item.images.where((i) => i.imageType == 'reverse').firstOrNull;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image pair (obverse + reverse side by side like Great Collections)
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Expanded(child: _CoinImage(url: obverse?.publicUrl, label: 'OBV')),
                    Container(width: 0.5, color: Colors.grey.shade200),
                    Expanded(child: _CoinImage(url: reverse?.publicUrl, label: 'REV')),
                  ],
                ),
              ),
            ),
            // Details
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (item.grade != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: GradeUtils.colorForNumericGrade(
                                  item.gradeNumeric),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item.grade!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                        if (item.gradingCompany != null &&
                            item.gradingCompany != 'Raw')
                          _BadgeChip(item.gradingCompany!),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (item.certNumber != null)
                      Text(
                        '#${item.certNumber}',
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey.shade500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    const Spacer(),
                    if (item.isPublic)
                      Icon(Icons.public,
                          size: 12,
                          color: AppColors.primary.withValues(alpha: 0.5)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _title {
    final parts = [
      if (item.yearStart != null) item.yearStart.toString(),
      if (item.mintMark != null && item.mintMark!.length <= 3) item.mintMark!,
      item.series ?? item.denomination ?? item.country ?? 'Unknown',
    ];
    return parts.join('-').isNotEmpty ? parts.join(' ') : 'Untitled';
  }
}

class _CoinImage extends StatelessWidget {
  final String? url;
  final String label;
  const _CoinImage({this.url, required this.label});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        url != null
            ? CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.contain,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                errorWidget: (_, __, ___) => const _Placeholder(),
              )
            : const _Placeholder(),
        Positioned(
          bottom: 2,
          left: 2,
          child: Text(label,
              style: TextStyle(
                  fontSize: 8,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) => Center(
        child: Icon(Icons.monetization_on_outlined,
            color: Colors.grey.shade300, size: 36),
      );
}

class _BadgeChip extends StatelessWidget {
  final String label;
  const _BadgeChip(this.label);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
              color: AppColors.accentDark.withValues(alpha: 0.3), width: 0.5),
        ),
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 9,
              color: AppColors.accentDark,
              fontWeight: FontWeight.bold),
        ),
      );
}
