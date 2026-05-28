import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../theme/app_theme.dart';

class TreinoPersonalizadoScreen extends StatefulWidget {
  final String equipamento;
  final List<String> musculos;
  
  const TreinoPersonalizadoScreen({
    Key? key,
    required this.equipamento,
    required this.musculos,
  }) : super(key: key);

  @override
  State<TreinoPersonalizadoScreen> createState() => _TreinoPersonalizadoScreenState();
}

class _TreinoPersonalizadoScreenState extends State<TreinoPersonalizadoScreen> {
  List<Map<String, dynamic>> _exercicios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarTreinos();
  }

  Future<void> _carregarTreinos() async {
    final db = DatabaseHelper();
    List<Map<String, dynamic>> todosExercicios = await db.getExercicios();
    
    // Filtrar por equipamento e músculos selecionados
    List<Map<String, dynamic>> filtrados = todosExercicios.where((ex) {
      final equipMatch = ex['equipamento'] == widget.equipamento ||
                         ex['equipamento'].contains(widget.equipamento);
      final musculoMatch = widget.musculos.contains(ex['musculo']);
      return equipMatch && musculoMatch;
    }).toList();
    
    setState(() {
      _exercicios = filtrados;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final musculosTexto = widget.musculos.join(', ');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SEU TREINO',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.accent),
                  SizedBox(height: 16),
                  Text(
                    'CARREGANDO TREINO...',
                    style: AppStyles.bodySmall,
                  ),
                ],
              ),
            )
          : _exercicios.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_dissatisfied, size: 80, color: AppColors.textHint),
                      SizedBox(height: 16),
                      Text(
                        'NENHUM EXERCÍCIO ENCONTRADO',
                        style: AppStyles.titleSmall,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Para: $musculosTexto\nCom: ${widget.equipamento}',
                        textAlign: TextAlign.center,
                        style: AppStyles.bodySmall,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('VOLTAR'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Resumo do treino
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        border: Border(
                          bottom: BorderSide(color: AppColors.accent.withOpacity(0.3)),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: AppColors.success, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'TREINO GERADO!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildBadge('🏋️ ${widget.equipamento}'),
                              ...widget.musculos.map((m) => _buildBadge('🎯 $m')),
                              _buildBadge('📋 ${_exercicios.length} exercícios'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Lista de exercícios
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: _exercicios.length,
                        itemBuilder: (context, index) {
                          final ex = _exercicios[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            color: AppColors.cardBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ExpansionTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                ex['nome'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              subtitle: Text(
                                '${ex['series']}x ${ex['repeticoes']} • ${ex['equipamento']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '📋 ${ex['descricao']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.timer, size: 20, color: AppColors.accent),
                                            SizedBox(width: 8),
                                            Text(
                                              'Descanso: 60 segundos entre séries',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Botão finalizar
                    Container(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _mostrarDialogParabens();
                        },
                        icon: Icon(Icons.check_circle),
                        label: Text(
                          'FINALIZAR TREINO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
      ),
    );
  }

  void _mostrarDialogParabens() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: AppColors.accent),
            SizedBox(width: 8),
            Text(
              'PARABÉNS!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'Você completou seu treino personalizado!\n\nContinue assim e seus resultados virão! 💪',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text(
              'VOLTAR AO INÍCIO',
              style: TextStyle(color: AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }
}