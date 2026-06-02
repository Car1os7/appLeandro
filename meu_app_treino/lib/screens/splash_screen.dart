// ============================================
// 📦 IMPORTAÇÕES NECESSÁRIAS
// ============================================
import 'package:flutter/material.dart';
import 'home_screen.dart';  // Tela principal para onde vai depois do splash

// ============================================
// 💫 TELA DE SPLASH (ABERTURA)
// Mostra logo e animação enquanto o app "carrega"
// ============================================

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with SingleTickerProviderStateMixin {  // Necessário para animações
  
  // 🎬 CONTROLADORES DE ANIMAÇÃO
  late AnimationController _controller;  // Controla o tempo da animação
  late Animation<double> _fadeAnimation;  // Controla a opacidade (fade in/out)

  // ============================================
  // 🚀 INICIALIZA A ANIMAÇÃO QUANDO A TELA ABRE
  // ============================================
  @override
  void initState() {
    super.initState();
    
    // Cria o controlador de animação (duração de 5 segundos)
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,  // Sincroniza com a tela
    );
    
    // Cria a animação de fade (opacidade de 0% → 100%)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    
    // Inicia a animação
    _controller.forward();

    // ⏱️ AGUARDA 5 SEGUNDOS E VAI PARA A HOME SCREEN
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {  // Verifica se a tela ainda está aberta
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  // ============================================
  // 🧹 LIMPA O CONTROLADOR QUANDO A TELA FECHA
  // ============================================
  @override
  void dispose() {
    _controller.dispose();  // Libera recursos da animação
    super.dispose();
  }

  // ============================================
  // 🎨 CONSTRÓI A TELA
  // ============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[900]!, Colors.cyan[700]!],  // Fundo azul/ciano
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,  // Aplica a animação de fade
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ========== 🏋️ ÍCONE PRINCIPAL ==========
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),  // Fundo branco transparente
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.fitness_center,  // Ícone de halter
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                
                // ========== 📝 TÍTULO DO APP ==========
                Text(
                  'Minha Academia PREMIUM',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 10),
                
                // ========== 📝 SUBTÍTULO ==========
                Text(
                  'Seu treino personalizado',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40),
                
                // ========== 🔄 INDICADOR DE CARREGAMENTO ==========
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: 20),
                
                // ========== 📝 TEXTO DE CARREGAMENTO ==========
                Text(
                  'Carregando exercícios...',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}