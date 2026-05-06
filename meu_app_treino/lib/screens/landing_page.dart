import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'splash_screen.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AppTexts.landingTitle),
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.landingGradient,
                ),
                child: Center(
                  child: Icon(Icons.fitness_center, size: 80, color: AppColors.textLight),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppStyles.screenPadding,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SplashScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        AppTexts.enterButton,
                        style: AppStyles.buttonText,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildCard(
                    title: AppTexts.vantagensTitle,
                    icon: Icons.thumb_up,
                    color: AppColors.success,
                    bgColor: AppColors.cardVantagens,
                    items: AppTexts.vantagensItems,
                  ),
                  SizedBox(height: 16),
                  _buildCard(
                    title: AppTexts.desvantagensTitle,
                    icon: Icons.warning,
                    color: AppColors.warning,
                    bgColor: AppColors.cardDesvantagens,
                    items: AppTexts.desvantagensItems,
                  ),
                  SizedBox(height: 16),
                  _buildCard(
                    title: AppTexts.beneficiosTitle,
                    icon: Icons.emoji_events,
                    color: AppColors.accent,
                    bgColor: AppColors.cardBeneficios,
                    items: AppTexts.beneficiosItems,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required List<String> items,
  }) {
    return Container(
      decoration: AppStyles.cardDecoration(backgroundColor: bgColor),
      child: Padding(
        padding: AppStyles.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.titleSmall,
                  ),
                ),
              ],
            ),
            Divider(height: 20),
            ...items.map((item) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: 16, color: color),
                      SizedBox(width: 8),
                      Expanded(child: Text(item, style: AppStyles.bodyMedium)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}