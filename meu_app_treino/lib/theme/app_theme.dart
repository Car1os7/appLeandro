import 'package:flutter/material.dart';


// 🎨 TODAS AS CORES DO APP (mude aqui!)


class AppColors {
  // Cores principais
  static const Color primary = Color(0xFF6C63FF);      // Roxo principal
  static const Color primaryDark = Color(0xFF4A44CC);   // Roxo escuro
  static const Color primaryLight = Color(0xFF9B96FF);  // Roxo claro
  static const Color secondary = Color(0xFFFF6B6B);     // Vermelho
  static const Color accent = Color(0xFFFFD166);        // Amarelo
  
  // Cores de fundo
  static const Color background = Color(0xFFF5F7FA);    // Fundo claro
  static const Color backgroundDark = Color(0xFF1A1A2E); // Fundo escuro
  static const Color cardBackground = Colors.white;
  
  // Cores de texto
  static const Color textPrimary = Color(0xFF2D3436);    // Texto principal
  static const Color textSecondary = Color(0xFF636E72);  // Texto secundário
  static const Color textLight = Colors.white;
  
  // Cores de status
  static const Color success = Color(0xFF4CAF50);       // Verde
  static const Color warning = Color(0xFFFF9800);       // Laranja
  static const Color error = Color(0xFFE53935);         // Vermelho erro
  static const Color info = Color(0xFF2196F3);          // Azul info
  
  // Cores dos cards (vantagens/desvantagens)
  static const Color cardVantagens = Color(0xFFE8F5E9);   // Fundo verde claro
  static const Color cardDesvantagens = Color(0xFFFFF3E0); // Fundo laranja claro
  static const Color cardBeneficios = Color(0xFFE3F2FD);   // Fundo azul claro
  static const Color cardPremium = Color(0xFFF3E5F5);      // Fundo roxo claro
  
  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C63FF), Color(0xFF4A44CC)],
  );
  
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
  );
  
  static const LinearGradient landingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
  );
}


// 📝 TEXTOS DO APP (mude aqui!)


class AppTexts {
  // Títulos do app
  static const String appName = 'Minha Academia Premium';
  static const String appTagline = 'Seu treino personalizado';
  static const String splashTitle = 'Minha Academia PREMIUM';
  
  // Landing Page (Página inicial)
  static const String landingTitle = 'Academia Transforma';
  static const String enterButton = 'ENTRAR NO APP DE TREINOS';
  
  // Vantagens
  static const String vantagensTitle = '✅ VANTAGENS DE FAZER ACADEMIA';
  static const List<String> vantagensItems = [
    '🧠 Mais disposição e energia o dia todo',
    '❤️ Saúde cardiovascular - previne infarto',
    '😊 Autoestima elevada com ganho de força',
    '🌙 Melhora o sono e reduz ansiedade',
    '🎯 Longevidade - previne diabetes e osteoporose',
  ];
  
  // Desvantagens
  static const String desvantagensTitle = '⚠️ CONSEQUÊNCIAS DE NÃO SE EXERCITAR';
  static const List<String> desvantagensItems = [
    '❌ Perda acelerada de massa muscular',
    '❌ Aumento de gordura visceral',
    '❌ Dores lombares e má postura',
    '❌ Declínio cognitivo e depressão',
    '❌ Sono irregular e baixa imunidade',
  ];
  
  // Benefícios
  static const String beneficiosTitle = '🏆 BENEFÍCIOS EXTRAS';
  static const List<String> beneficiosItems = [
    '⚡ Energia para curtir a família',
    '🧘 Redução do estresse em 40%',
    '💪 Confiança para qualquer desafio',
    '🛡️ Sistema imunológico mais forte',
  ];
  
  // Home Screen
  static const String homeTitle = 'Meus Treinos';
  static const String premiumBanner = 'Assine Premium e ganhe um Personal Trainer exclusivo!';
  static const String premiumButton = 'ASSINAR';
  static const String premiumActive = 'Premium Ativo';
  
  // Diálogos
  static const String premiumDialogTitle = 'Área Premium';
  static const String premiumDialogText = 'ASSINE PREMIUM e escolha seu PERSONAL TRAINER:';
  static const String premiumPrice = 'R\$ 29,90/mês';
  
  // Personais
  static const String personalLuva = 'Luva de Pedreiro';
  static const String personalBistecone = 'Bistecone';
  static const String personalBatista = 'Batista';
  
  // Mensagens
  static const String loadingMessage = 'Carregando exercícios...';
  static const String errorMessage = 'Erro ao carregar dados';
  static const String emptyMessage = 'Nenhum exercício encontrado';
}


// 🎨 ESTILOS (mude aqui!)


class AppStyles {
  // Estilos de texto
  static const TextStyle titleLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );
  
  // Decorações
  static BoxDecoration cardDecoration({required Color backgroundColor}) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    );
  }
  
  // Bordas
  static final BorderRadius defaultBorderRadius = BorderRadius.circular(16);
  static final BorderRadius largeBorderRadius = BorderRadius.circular(20);
  static final BorderRadius buttonBorderRadius = BorderRadius.circular(30);
  
  // Padding
  static const EdgeInsets defaultPadding = EdgeInsets.all(16);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const EdgeInsets screenPadding = EdgeInsets.all(16);
}


// 🎯 TEMAS (claro/escuro)


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: AppStyles.buttonBorderRadius),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: AppStyles.defaultBorderRadius),
      color: AppColors.cardBackground,
    ),
  );
  
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: AppStyles.buttonBorderRadius),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: AppStyles.defaultBorderRadius),
      color: AppColors.backgroundDark.withOpacity(0.5),
    ),
  );
}