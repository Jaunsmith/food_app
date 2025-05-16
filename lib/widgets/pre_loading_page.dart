import 'package:flutter/material.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/main_text.dart';

class PreLoadingPage extends StatelessWidget {
  const PreLoadingPage({
    super.key,
    required this.imagePath,
    this.borderRadius = 0,
  });
  final String imagePath;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius == 0 ? DynamicDimensions.size20 : borderRadius,
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              final total = loadingProgress.expectedTotalBytes;
              final loaded = loadingProgress.cumulativeBytesLoaded;

              final progress =
                  total != null
                      ? (loaded / total * 100).clamp(0, 100).toStringAsFixed(0)
                      : null;

              return Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator.adaptive(
                      value: total != null ? loaded / total : null,
                      backgroundColor: AppColors.mainColor,
                    ),
                    SizedBox(height: DynamicDimensions.size5),
                    MainText(
                      text:
                          progress != null
                              ? 'Loading... $progress%'
                              : 'Loading...',
                      fontSize: DynamicDimensions.size15,
                      color: Colors.white,
                    ),
                  ],
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(Icons.error, color: Colors.red, size: 40),
            );
          },
        ),
      ),
    );
  }
}
