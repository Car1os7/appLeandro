import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class TransitionDMCScreen extends StatefulWidget {
  const TransitionDMCScreen({super.key});

  @override
  State<TransitionDMCScreen> createState() => _TransitionDMCScreenState();
}

class _TransitionDMCScreenState extends State<TransitionDMCScreen>
    with TickerProviderStateMixin {
  late Timer _timer;
  int _progress = 0;
  final List<int> _progressSteps = [0, 25, 85, 99, 100];
  int _stepIndex = 0;
  
  final Random _random = Random();
  final List<GlitchLine> _glitchLines = [];
  final List<StaticParticle> _staticParticles = [];
  
  bool _showStatic = true;
  bool _isGlitching = false;
  double _glitchOffset = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Gerar linhas de glitch
    for (int i = 0; i < 30; i++) {
      _glitchLines.add(GlitchLine(
        y: _random.nextDouble(),
        height: 0.02 + _random.nextDouble() * 0.05,
        intensity: 0.3 + _random.nextDouble() * 0.7,
      ));
    }

    // Gerar partículas de estática
    for (int i = 0; i < 150; i++) {
      _staticParticles.add(StaticParticle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 1 + _random.nextDouble() * 3,
      ));
    }

    // Simular progresso
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (_stepIndex < _progressSteps.length - 1) {
        _stepIndex++;
        setState(() {
          _progress = _progressSteps[_stepIndex];
          _isGlitching = true;
          _glitchOffset = 5 + _random.nextDouble() * 15;
        });
        
        // Efeito de glitch rápido
        Future.delayed(Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _isGlitching = false;
              _glitchOffset = 0;
            });
          }
        });
      } else {
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

  @override
  void dispose() {
    _timer.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fundo preto com estática
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),

          // Estática (partículas brancas)
          ..._staticParticles.map((particle) {
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

          // Linhas de glitch horizontais
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

          // Texto com glitch
          Center(
            child: Transform.translate(
              offset: Offset(_glitchOffset, 0),
              child: Stack(
                children: [
                  // Camada vermelha (glitch)
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
                  // Camada azul (glitch)
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
                  // Texto principal
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

          // Percentual de carregamento
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  // Número do percentual
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
                              ? Colors.green[400] 
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
                  
                  // Barra de progresso
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
                  
                  // Texto de status
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

          // Efeito de scanline (opcional)
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

  String _getStatusText() {
    if (_progress >= 99) return 'FINALIZANDO...';
    if (_progress >= 85) return 'QUASE LÁ...';
    if (_progress >= 25) return 'CARREGANDO MÓDULOS...';
    if (_progress >= 0) return 'INICIANDO SISTEMA...';
    return 'CARREGANDO...';
  }
}

// Classe para linhas de glitch
class GlitchLine {
  final double y;
  final double height;
  final double intensity;
  
  GlitchLine({
    required this.y,
    required this.height,
    required this.intensity,
  });
}

// Classe para partículas de estática
class StaticParticle {
  final double x;
  final double y;
  final double size;
  
  StaticParticle({
    required this.x,
    required this.y,
    required this.size,
  });
}