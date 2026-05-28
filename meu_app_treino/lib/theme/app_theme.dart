import 'package:flutter/material.dart';

class AppColors {
  // ============================================
  // 🎮 THEME
  // ============================================

  // ========== CORES PRINCIPAIS ==========
  static const Color primary = Color(0xFFC1121F);     // Crimson DMC
  static const Color primaryDark = Color(0xFF780000); // Blood red
  static const Color primaryLight = Color(0xFFFF4D6D); // Neon glow red
  static const Color glowRed = Color(0xFFFF4D6D);

  static const Color accent = Color(0xFFC89B3C);      // Gold metal
  static const Color secondary = Color(0xFF050505);

  // ========== FUNDO ==========
  static const Color background = Color(0xFF050505);
  static const Color backgroundDark = Color(0xFF000000);
  static const Color cardBackground = Color(0xFF111111);
  static const Color surface = Color(0xFF1B1B1B);

  // ========== TEXTO ==========
  static const Color textPrimary = Color(0xFFF8F9FA);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textHint = Color(0xFF6B6B6B);
  static const Color textLight = Colors.white;
  static const Color textDark = Color(0xFF050505);

  // ========== STATUS ==========
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = primary;
  static const Color info = Color(0xFF2196F3);

  // ========== CARDS ==========
  static const Color cardVantagens = primary;
  static const Color cardDesvantagens = Color(0xFF111111);
  static const Color cardBeneficios = accent;
  static const Color cardPremium = accent;

  // ============================================
  // 🌑 GRADIENTES CINEMATOGRÁFICOS
  // ============================================

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFC1121F),
      Color(0xFF780000),
    ],
  );

  static const LinearGradient premiumGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFC89B3C),
      Color(0xFF8B6B1F),
    ],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF050505),
      Color(0xFF0A0A0A),
      Color(0xFF1A0000),
      Color(0xFF050505),
    ],
  );

  static const LinearGradient landingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF050505),
      Color(0xFF111111),
      Color(0xFFC1121F),
      Color(0xFF050505),
    ],
    stops: [0.0, 0.25, 0.5, 1.0],
  );
}

// ============================================
// 📝 TEXTOS
// ============================================

class AppTexts {
  static const String appName = 'Modo de Treino';
  static const String appTagline = 'Power. Style. Domination.';
  static const String splashTitle = 'Modo de Treino';
  static const String landingTitle = 'Modo de Treino';
  static const String enterButton = 'Tenha disciplina';
  static const String homeTitle = 'TRAINING';
  static const String premiumBanner = '🔥 TREINE 🔥';
  static const String premiumButton = 'Bem-vindo ao PREMIUM';
  static const String premiumActive = 'Modo de Treino';
  static const String premiumDialogTitle = 'PREMIUM AREA';
  static const String premiumDialogText = 'Preço para melhorar sua experiencia:';
  static const String premiumPrice = 'R\$ 29,90';
  static const String loadingMessage = 'LOADING...';
  static const String errorMessage = 'SYSTEM FAILURE';
  static const String emptyMessage = 'Treino nao encontrado';
}

// ============================================
// 🎨 ESTILOS
// ============================================

class AppStyles {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 2,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textHint,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    color: AppColors.textLight,
  );

  // ============================================
  // 🩸 CARD CINEMATOGRÁFICO
  // ============================================

  static BoxDecoration cardDecoration({
    required Color backgroundColor,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: AppColors.primary.withOpacity(0.4),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.glowRed.withOpacity(0.25),
          blurRadius: 25,
          spreadRadius: 2,
          offset: const Offset(0, 0),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static final BorderRadius defaultBorderRadius = BorderRadius.circular(18);
  static final BorderRadius largeBorderRadius = BorderRadius.circular(28);
  static final BorderRadius buttonBorderRadius = BorderRadius.circular(40);

  static const EdgeInsets defaultPadding = EdgeInsets.all(16);
  static const EdgeInsets cardPadding = EdgeInsets.all(22);
  static const EdgeInsets screenPadding = EdgeInsets.all(20);
}

// ============================================
// 🎮 TEMA PRINCIPAL
// ============================================

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Roboto', // ← CORRIGIDO: 'Bebas' não existe por padrão
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 3,
        color: AppColors.textLight,
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.buttonBorderRadius,
        ),
        elevation: 12,
        shadowColor: AppColors.glowRed,
      ),
    ),
    
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.defaultBorderRadius,
      ),
      color: AppColors.cardBackground,
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: AppStyles.defaultBorderRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppStyles.defaultBorderRadius,
        borderSide: BorderSide(
          color: AppColors.glowRed,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppStyles.defaultBorderRadius,
        borderSide: BorderSide(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
    ),
  );
}