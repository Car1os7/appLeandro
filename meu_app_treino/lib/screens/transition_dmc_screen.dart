// ============================================
// 📦 IMPORTAÇÕES NECESSÁRIAS
// ============================================
import 'dart:async';      // Para usar Timer (contagem de tempo)
import 'dart:math';       // Para números aleatórios (Random)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // Para configurar tela cheia
import 'home_screen.dart';  // Tela para onde vai depois do carregamento

// ============================================
// 📺 TELA DE CARREGAMENTO ESTILO GLITCH
// Mostra: estática na tela, glitch, porcentagem (0% → 25% → 85% → 99% → 100%)
// ============================================

class TransitionDMCScreen extends StatefulWidget {
  const TransitionDMCScreen({super.key});

  @override
  State<TransitionDMCScreen> createState() => _TransitionDMCScreenState();
}

class _TransitionDMCScreenState extends State<TransitionDMCScreen>
    with TickerProviderStateMixin {
  
  // ========== ⏱️ VARIÁVEIS DE PROGRESSO ==========
  late Timer _timer;                    // Timer que controla os passos
  int _progress = 0;                    // Percentual atual (0 a 100)
  final List<int> _progressSteps = [0, 25, 85, 99, 100];  // Passos do progresso
  int _stepIndex = 0;                   // Índice do passo atual
  
  // ========== 🎨 EFEITOS VISUAIS ==========
  final Random _random = Random();       // Gerador de números aleatórios
  final List<GlitchLine> _glitchLines = [];     // Lista de linhas de glitch
  final List<StaticParticle> _staticParticles = [];  // Lista de partículas de estática
  
  bool _showStatic = true;               // Mostrar estática?
  bool _isGlitching = false;             // Está em modo glitch?
  double _glitchOffset = 0;              // Deslocamento do texto no glitch

  // ============================================
  // 🚀 INICIALIZA QUANDO A TELA ABRE
  // ============================================
  @override
  void initState() {
    super.initState();
    
    // Configura tela cheia (remove barras)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // 🔲 CRIA LINHAS DE GLITCH (30 linhas horizontais aleatórias)
    for (int i = 0; i < 30; i++) {
      _glitchLines.add(GlitchLine(
        y: _random.nextDouble(),                    // Posição vertical aleatória
        height: 0.02 + _random.nextDouble() * 0.05,  // Altura da linha
        intensity: 0.3 + _random.nextDouble() * 0.7, // Intensidade do glitch
      ));
    }

    // ✨ CRIA PARTÍCULAS DE ESTÁTICA (150 pontos brancos aleatórios)
    for (int i = 0; i < 150; i++) {
      _staticParticles.add(StaticParticle(
        x: _random.nextDouble(),    // Posição X aleatória
        y: _random.nextDouble(),    // Posição Y aleatória
        size: 1 + _random.nextDouble() * 3,  // Tamanho da partícula
      ));
    }

    // ⏱️ TIMER: A CADA 800ms, AVANÇA PARA O PRÓXIMO PASSO
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (_stepIndex < _progressSteps.length - 1) {
        // Ainda não chegou no 100%
        _stepIndex++;
        setState(() {
          _progress = _progressSteps[_stepIndex];   // Atualiza porcentagem
          _isGlitching = true;                      // Ativa efeito de glitch
          _glitchOffset = 5 + _random.nextDouble() * 15;  // Desloca texto
        });
        
        // ⚡ EFEITO DE GLITCH RÁPIDO (desativa após 100ms)
        Future.delayed(Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _isGlitching = false;
              _glitchOffset = 0;
            });
          }
        });
      } else {
        // ✅ COMPLETOU 100% - Cancela timer e vai para HomeScreen
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        });
      }
    });
  }

  // ============================================
  // 🧹 LIMPA RECURSOS QUANDO A TELA FECHA
  // ============================================
  @override
  void dispose() {
    _timer.cancel();  // Cancela o timer para não continuar rodando
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  // ============================================
  // 🎨 CONSTRÓI A TELA
  // ============================================
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ========== 🖤 FUNDO PRETO ==========
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),

          // ========== ✨ ESTÁTICA (PARTÍCULAS BRANCAS PISCANDO) ==========
          ..._staticParticles.map((particle) {
            // Opacidade aleatória para simular estática
            final opacity = _showStatic ? 0.3 + _random.nextDouble() * 0.2 : 0.0;
            return Positioned(
              left: particle.x * screenSize.width,
              top: particle.y * screenSize.height,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 50 + _random.nextInt(100)),
                child: Container(
                  width: particle.size,
                  height: particle.size,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            );
          }),

          // ========== 📺 LINHAS DE GLITCH (HORIZONTAIS) ==========
          ..._glitchLines.map((line) {
            final intensity = _isGlitching ? line.intensity : line.intensity * 0.3;
            return Positioned(
              left: 0,
              top: line.y * screenSize.height,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * line.height,
                color: Colors.white.withOpacity(0.1 * intensity),
              ),
            );
          }),

          // ========== 📝 TEXTO "CARREGANDO..." COM EFEITO GLITCH ==========
          Center(
            child: Transform.translate(
              offset: Offset(_glitchOffset, 0),  // Desloca durante o glitch
              child: Stack(
                children: [
                  // Camada VERMELHA (deslocada para esquerda)
                  Transform.translate(
                    offset: Offset(-3, 0),
                    child: Text(
                      'CARREGANDO...',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: Colors.red.withOpacity(_isGlitching ? 0.8 : 0),
                      ),
                    ),
                  ),
                  // Camada AZUL (deslocada para direita)
                  Transform.translate(
                    offset: Offset(3, 0),
                    child: Text(
                      'CARREGANDO...',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: Colors.blue.withOpacity(_isGlitching ? 0.8 : 0),
                      ),
                    ),
                  ),
                  // Texto BRANCO (principal)
                  Text(
                    'CARREGANDO...',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ========== 📊 PERCENTUAL E BARRA DE PROGRESSO ==========
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  // 🔢 NÚMERO DA PORCENTAGEM (com animação)
                  TweenAnimationBuilder(
                    tween: IntTween(begin: 0, end: _progress),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, child) {
                      return Text(
                        '${value}%',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _progress >= 85 
                              ? Colors.green[400]   // Verde quando perto de 100%
                              : Colors.white,
                          shadows: [
                            Shadow(
                              color: _progress >= 85 ? Colors.green : Colors.red,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // 📊 BARRA DE PROGRESSO
                  Container(
                    width: 250,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _progress / 100,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _progress >= 85 ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // 📝 TEXTO DE STATUS (muda conforme o progresso)
                  Text(
                    _getStatusText(),
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ========== 📺 EFEITO DE SCANLINE (opcional) ==========
          // Precisa de uma imagem assets/scanlines.png para funcionar
          if (_isGlitching)
            IgnorePointer(
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/scanlines.png'),
                      repeat: ImageRepeat.repeat,
                      opacity: 0.3,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================
  // 📝 RETORNA O TEXTO DE STATUS BASEADO NO PROGRESSO
  // ============================================
  String _getStatusText() {
    if (_progress >= 99) return 'FINALIZANDO...';
    if (_progress >= 85) return 'QUASE LÁ...';
    if (_progress >= 25) return 'CARREGANDO MÓDULOS...';
    if (_progress >= 0) return 'INICIANDO SISTEMA...';
    return 'CARREGANDO...';
  }
}

// ============================================
// 🔲 CLASSE DAS LINHAS DE GLITCH
// ============================================
class GlitchLine {
  final double y;          // Posição vertical (0 a 1)
  final double height;     // Altura da linha
  final double intensity;  // Intensidade (0 a 1)
  
  GlitchLine({
    required this.y,
    required this.height,
    required this.intensity,
  });
}

// ============================================
// ✨ CLASSE DAS PARTÍCULAS DE ESTÁTICA
// ============================================
class StaticParticle {
  final double x;          // Posição horizontal (0 a 1)
  final double y;          // Posição vertical (0 a 1)
  final double size;       // Tamanho da partícula
  
  StaticParticle({
    required this.x,
    required this.y,
    required this.size,
  });
}