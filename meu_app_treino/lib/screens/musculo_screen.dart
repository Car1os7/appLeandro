import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'treino_personalizado_screen.dart';

class MusculoScreen extends StatefulWidget {
  final String equipamentoSelecionado;
  
  const MusculoScreen({
    Key? key,
    required this.equipamentoSelecionado,
  }) : super(key: key);

  @override
  State<MusculoScreen> createState() => _MusculoScreenState();
}

class _MusculoScreenState extends State<MusculoScreen> {
  final List<String> _musculosSelecionados = [];
  
  final List<Map<String, dynamic>> _musculos = [
    {'nome': 'Peito', 'icone': '💪', 'exercicios': 8},
    {'nome': 'Costas', 'icone': '🦾', 'exercicios': 7},
    {'nome': 'Pernas', 'icone': '🦵', 'exercicios': 9},
    {'nome': 'Ombros', 'icone': '🏋️', 'exercicios': 6},
    {'nome': 'Braços', 'icone': '💪', 'exercicios': 7},
    {'nome': 'Abdômen', 'icone': '🔥', 'exercicios': 5},
  ];

  void _alternarMusculo(String musculo) {
    setState(() {
      if (_musculosSelecionados.contains(musculo)) {
        _musculosSelecionados.remove(musculo);
      } else {
        _musculosSelecionados.add(musculo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MÚSCULOS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Cabeçalho
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.3),
              border: Border(
                bottom: BorderSide(color: AppColors.accent.withOpacity(0.2)),
              ),
            ),
            child: Column(
              children: [
                Icon(Icons.fitness_center, size: 45, color: AppColors.accent),
                SizedBox(height: 10),
                Text(
                  'ETAPA 2 DE 3',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: AppColors.accent,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'ESCOLHA OS MÚSCULOS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, size: 14, color: AppColors.accent),
                    SizedBox(width: 6),
                    Text(
                      'Equipamento: ${widget.equipamentoSelecionado}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Selecione os músculos que quer treinar (pode escolher vários)',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Contador de selecionados
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _musculosSelecionados.isNotEmpty
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    color: AppColors.accent.withOpacity(0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: AppColors.accent, size: 18),
                        SizedBox(width: 8),
                        Text(
                          '${_musculosSelecionados.length} músculo(s) selecionado(s)',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ),
          
          // Lista de músculos
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: _musculos.length,
              itemBuilder: (context, index) {
                final musculo = _musculos[index];
                final isSelected = _musculosSelecionados.contains(musculo['nome']);
                
                return GestureDetector(
                  onTap: () => _alternarMusculo(musculo['nome']),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [AppColors.accent, AppColors.primaryLight],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isSelected ? null : AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.accent : Colors.blueGrey[800]!,
                        width: 1.5,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.3),
                            blurRadius: 12,
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(musculo['icone'], style: TextStyle(fontSize: 50)),
                        SizedBox(height: 12),
                        Text(
                          musculo['nome'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${musculo['exercicios']} exercícios',
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected ? Colors.white70 : AppColors.textHint,
                          ),
                        ),
                        if (isSelected)
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Icon(Icons.check_circle, color: Colors.white, size: 22),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Botões
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              border: Border(
                top: BorderSide(color: AppColors.accent.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: BorderSide(color: AppColors.accent.withOpacity(0.5)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('VOLTAR', style: TextStyle(letterSpacing: 1)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _musculosSelecionados.isNotEmpty
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TreinoPersonalizadoScreen(
                                  equipamento: widget.equipamentoSelecionado,
                                  musculos: _musculosSelecionados,
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'GERAR TREINO →',
                      style: TextStyle(letterSpacing: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}