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
  _TreinoPersonalizadoScreenState createState() => _TreinoPersonalizadoScreenState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Seu Treino Personalizado'),
        backgroundColor: AppColors.primary,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _exercicios.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_dissatisfied, size: 80, color: AppColors.textSecondary),
                      SizedBox(height: 16),
                      Text(AppTexts.emptyMessage, style: AppStyles.bodyLarge),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: Text('VOLTAR'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: _exercicios.length,
                  itemBuilder: (context, index) {
                    final ex = _exercicios[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                          backgroundColor: AppColors.primary,
                        ),
                        title: Text(ex['nome'], style: AppStyles.titleSmall),
                        subtitle: Text(
                          '${ex['series']}x ${ex['repeticoes']} • ${ex['equipamento']}',
                          style: AppStyles.bodySmall,
                        ),
                        trailing: Icon(Icons.fitness_center, color: AppColors.primary),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(ex['nome'], style: AppStyles.titleSmall),
                              content: Text(ex['descricao'], style: AppStyles.bodyMedium),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Fechar', style: TextStyle(color: AppColors.primary)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}