import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/bucket_service.dart';
import '../styles/app_assets.dart';
import '../styles/app_colors.dart';

class BookCardWidget extends StatelessWidget {
  const BookCardWidget({
    super.key,
    required this.title,
    required this.author,
    required this.coverUrl,
    this.borderRadius = 8,
    this.coverBorderRadius,
    this.showShadow = false,
    this.titlePadding = const EdgeInsets.only(left: 8, right: 8, top: 8),
    this.authorPadding = const EdgeInsets.only(
      left: 8,
      right: 8,
      top: 4,
      bottom: 8,
    ),
  });

  final String title;
  final String author;
  final String coverUrl;
  final double borderRadius;
  final BorderRadius? coverBorderRadius;
  final bool showShadow;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry authorPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow
            ? const [
                BoxShadow(
                  color: AppStyles.shadowColor,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  coverBorderRadius ?? BorderRadius.circular(borderRadius - 2),
              child: FutureBuilder<Uint8List?>(
                future: BucketService.loadCoverImage(coverUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Image.memory(
                      snapshot.data!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }

                  return Image.asset(
                    AppAssets.blankCover,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: titlePadding,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppStyles.textColor,
              ),
            ),
          ),
          Padding(
            padding: authorPadding,
            child: Text(
              author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppStyles.subtitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
