// ============================================
// 📦 IMPORTAÇÕES NECESSÁRIAS
// ============================================
import 'package:flutter/material.dart';

// ============================================
// 🎨 CORES DO APP - MUDE AQUI AS CORES
// ============================================

class AppColors {
  // ========== 🔴 CORES PRINCIPAIS ==========
  static const Color primary = Color(0xFFC1121F);     // Vermelho sangue (botões, destaques)
  static const Color primaryDark = Color(0xFF780000); // Vermelho escuro (AppBar)
  static const Color primaryLight = Color(0xFFFF4D6D); // Vermelho neon (glow)
  static const Color glowRed = Color(0xFFFF4D6D);     // Brilho vermelho (sombras)

  static const Color accent = Color(0xFFC89B3C);      // Dourado (premium, destaques especiais)
  static const Color secondary = Color(0xFF050505);   // Preto secundário

  // ========== ⚫ FUNDO ==========
  static const Color background = Color(0xFF050505);      // Fundo principal (preto)
  static const Color backgroundDark = Color(0xFF000000);  // Fundo mais escuro
  static const Color cardBackground = Color(0xFF111111);  // Fundo dos cards
  static const Color surface = Color(0xFF1B1B1B);         // Superfície (inputs, etc)

  // ========== 📝 TEXTO ==========
  static const Color textPrimary = Color(0xFFF8F9FA);    // Branco (texto principal)
  static const Color textSecondary = Color(0xFFB0B0B0);  // Cinza claro (texto secundário)
  static const Color textHint = Color(0xFF6B6B6B);       // Cinza escuro (placeholders)
  static const Color textLight = Colors.white;           // Branco puro
  static const Color textDark = Color(0xFF050505);       // Preto (texto em fundo claro)

  // ========== ✅ STATUS ==========
  static const Color success = Color(0xFF4CAF50);  // Verde (sucesso)
  static const Color warning = Color(0xFFFF9800);  // Laranja (aviso)
  static const Color error = primary;              // Vermelho (erro)
  static const Color info = Color(0xFF2196F3);     // Azul (informação)

  // ========== 🃏 CARDS ==========
  static const Color cardVantagens = primary;      // Card de vantagens (vermelho)
  static const Color cardDesvantagens = Color(0xFF111111); // Card de desvantagens (preto)
  static const Color cardBeneficios = accent;      // Card de benefícios (dourado)
  static const Color cardPremium = accent;         // Card premium (dourado)

  // ============================================
  // 🌑 GRADIENTES
  // ============================================

  // Gradiente principal (vermelho escuro)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC1121F), Color(0xFF780000)],
  );

  // Gradiente premium (dourado)
  static const LinearGradient premiumGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC89B3C), Color(0xFF8B6B1F)],
  );

  // Gradiente de fundo geral
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF050505), Color(0xFF0A0A0A), Color(0xFF1A0000), Color(0xFF050505)],
  );

  // Gradiente da Landing Page (escuro com toque de vermelho)
  static const LinearGradient landingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF050505), Color(0xFF111111), Color(0xFFC1121F), Color(0xFF050505)],
    stops: [0.0, 0.25, 0.5, 1.0],
  );
}

// ============================================
// 📝 TEXTOS DO APP - MUDE AQUI OS TEXTOS
// ============================================

class AppTexts {
  static const String appName = 'Modo de Treino';           // Nome do app
  static const String appTagline = 'Power. Style. Domination.'; // Frase de efeito
  static const String splashTitle = 'Modo de Treino';       // Título do splash
  static const String landingTitle = 'Modo de Treino';      // Título da landing page
  static const String enterButton = 'Tenha disciplina';     // Texto do botão entrar
  static const String homeTitle = 'TRAINING';               // Título da home
  static const String premiumBanner = '🔥 TREINE 🔥';       // Banner premium
  static const String premiumButton = 'Bem-vindo ao PREMIUM'; // Botão premium
  static const String premiumActive = 'Modo de Treino';     // Status premium ativo
  static const String premiumDialogTitle = 'PREMIUM AREA';  // Título do diálogo premium
  static const String premiumDialogText = 'Preço para melhorar sua experiencia:'; // Texto do diálogo
  static const String premiumPrice = 'R\$ 29,90';           // Preço premium
  static const String loadingMessage = 'LOADING...';        // Mensagem de loading
  static const String errorMessage = 'SYSTEM FAILURE';      // Mensagem de erro
  static const String emptyMessage = 'Treino nao encontrado'; // Mensagem de vazio
}

// ============================================
// 🎨 ESTILOS - TAMANHOS, BORDAS, ETC
// ============================================

class AppStyles {
  // ========== 📏 ESTILOS DE TEXTO ==========
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

  // ========== 🃏 DECORAÇÃO DE CARD ==========
  static BoxDecoration cardDecoration({
    required Color backgroundColor,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: AppColors.primary.withOpacity(0.4),  // Borda vermelha transparente
        width: 1.2,
      ),
      boxShadow: [
        // Brilho vermelho (glow)
        BoxShadow(
          color: AppColors.glowRed.withOpacity(0.25),
          blurRadius: 25,
          spreadRadius: 2,
          offset: const Offset(0, 0),
        ),
        // Sombra preta
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  // ========== 🔘 BORDAS ==========
  static final BorderRadius defaultBorderRadius = BorderRadius.circular(18);
  static final BorderRadius largeBorderRadius = BorderRadius.circular(28);
  static final BorderRadius buttonBorderRadius = BorderRadius.circular(40);

  // ========== 📏 ESPAÇAMENTOS ==========
  static const EdgeInsets defaultPadding = EdgeInsets.all(16);
  static const EdgeInsets cardPadding = EdgeInsets.all(22);
  static const EdgeInsets screenPadding = EdgeInsets.all(20);
}

// ============================================
// 🎮 TEMA PRINCIPAL DO APP
// ============================================

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark,           // Modo escuro
    primaryColor: AppColors.primary,       // Cor primária (vermelho)
    scaffoldBackgroundColor: AppColors.background, // Fundo das telas
    fontFamily: 'Roboto',                  // Fonte padrão
    
    // Remove efeitos de splash/highlight (clareamento)
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    
    // ========== BARRA SUPERIOR (APP BAR) ==========
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
    
    // ========== BOTÕES ==========
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
    
    // ========== CARDS ==========
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.defaultBorderRadius,
      ),
      color: AppColors.cardBackground,
    ),
    
    // ========== CAMPOS DE TEXTO ==========
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