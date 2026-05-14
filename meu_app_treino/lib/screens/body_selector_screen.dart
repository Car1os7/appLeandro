import 'package:flutter/material.dart';
import 'package:flutter_body_part_selector/flutter_body_part_selector.dart';
import '../database/database_helper.dart';
import '../theme/app_theme.dart';

class BodySelectorScreen extends StatefulWidget {
  const BodySelectorScreen({Key? key}) : super(key: key);

  @override
  State<BodySelectorScreen> createState() => _BodySelectorScreenState();
}

class _BodySelectorScreenState extends State<BodySelectorScreen> {
  late final BodyMapController _controller;
  bool _isLoading = false;

  // Mapeamento dos músculos (APENAS os que existem no pacote)
  final Map<Muscle, String> _muscleToNome = {
    Muscle.chestLeft: 'Peito',
    Muscle.chestRight: 'Peito',
    Muscle.abs: 'Abdômen',
    Muscle.bicepsLeft: 'Braços',
    Muscle.bicepsRight: 'Braços',
    Muscle.tricepsLeft: 'Braços',
    Muscle.tricepsRight: 'Braços',
    Muscle.quadsLeft: 'Pernas',
    Muscle.quadsRight: 'Pernas',
    Muscle.glutesLeft: 'Glúteos',
    Muscle.glutesRight: 'Glúteos',
    Muscle.deltsLeft: 'Ombros',
    Muscle.deltsRight: 'Ombros',
    Muscle.trapsLeft: 'Costas',
    Muscle.trapsRight: 'Costas',
  };

  @override
  void initState() {
    super.initState();
    _controller = BodyMapController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _gerarTreino() async {
    if (_controller.selectedMuscles.isEmpty) return;

    setState(() => _isLoading = true);

    final Set<String> musculosUnicos = {};
    for (var muscle in _controller.selectedMuscles) {
      final nome = _muscleToNome[muscle];
      if (nome != null) musculosUnicos.add(nome);
    }

    final db = DatabaseHelper();
    final todosExercicios = await db.getExercicios();
    
    final exerciciosFiltrados = todosExercicios.where((ex) {
      return musculosUnicos.contains(ex['musculo']);
    }).toList();

    setState(() => _isLoading = false);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TreinoResultadoScreen(
          musculosSelecionados: musculosUnicos.toList(),
          exercicios: exerciciosFiltrados,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione os Músculos'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              _controller.clearSelection();
              setState(() {});
            },
            tooltip: 'Limpar seleção',
          ),
          IconButton(
            icon: Icon(Icons.flip),
            onPressed: () {
              _controller.toggleView();
              setState(() {});
            },
            tooltip: 'Ver costas',
          ),
        ],
      ),
      body: Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final count = _controller.selectedMuscles.length;
              if (count == 0) return const SizedBox.shrink();
              
              return Container(
                padding: EdgeInsets.all(12),
                color: AppColors.primary.withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '$count músculo(s) selecionado(s)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          Expanded(
            child: InteractiveBodySvg(
              isFront: _controller.isFront,
              selectedMuscles: _controller.selectedMuscles,
              onMuscleTap: (muscle) {
                _controller.selectMuscle(muscle);
                setState(() {});
              },
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('← VOLTAR'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _controller.selectedMuscles.isNotEmpty ? _gerarTreino : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textLight,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('GERAR TREINO →'),
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

// Tela de resultado do treino
class TreinoResultadoScreen extends StatelessWidget {
  final List<String> musculosSelecionados;
  final List<Map<String, dynamic>> exercicios;

  const TreinoResultadoScreen({
    Key? key,
    required this.musculosSelecionados,
    required this.exercicios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musculosTexto = musculosSelecionados.join(', ');

    return Scaffold(
      appBar: AppBar(
        title: Text('Treino Personalizado'),
        backgroundColor: AppColors.primary,
      ),
      body: exercicios.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sentiment_dissatisfied, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum exercício para:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    musculosTexto,
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('VOLTAR'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: AppColors.primary.withOpacity(0.1),
                  child: Column(
                    children: [
                      const Text(
                        '🎯 Treino para:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        musculosTexto,
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${exercicios.length} exercícios encontrados',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: exercicios.length,
                    itemBuilder: (context, index) {
                      final ex = exercicios[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                          ),
                          title: Text(
                            ex['nome'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${ex['series']}x ${ex['repeticoes']} • ${ex['equipamento']}'),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('📋 ${ex['descricao']}'),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.timer, size: 20, color: AppColors.primary),
                                        const SizedBox(width: 8),
                                        const Text('Descanso: 60 segundos entre séries'),
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
              ],
            ),
    );
  }
}