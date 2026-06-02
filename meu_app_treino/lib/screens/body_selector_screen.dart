// ============================================
// 📦 IMPORTAÇÕES NECESSÁRIAS
// ============================================
import 'package:flutter/material.dart';
import 'package:flutter_body_part_selector/flutter_body_part_selector.dart';  // Pacote do seletor de corpo
import '../database/database_helper.dart';  // Banco de dados
import '../theme/app_theme.dart';           // Cores e estilos do app

// ============================================
// 🧍 TELA DE SELETOR DE PARTES DO CORPO
// Usuário toca no desenho do corpo para escolher os músculos
// ============================================

class BodySelectorScreen extends StatefulWidget {
  const BodySelectorScreen({Key? key}) : super(key: key);

  @override
  State<BodySelectorScreen> createState() => _BodySelectorScreenState();
}

class _BodySelectorScreenState extends State<BodySelectorScreen> {
  // 🎮 CONTROLADOR DO SELETOR DE CORPO (gerencia quais músculos estão selecionados)
  late final BodyMapController _controller;
  bool _isLoading = false;  // Mostra loading enquanto busca os exercícios

  // ============================================
  // 🔄 MAPEAMENTO: Músculo do pacote → Nome do músculo no seu banco
  // Ex: Muscle.chestLeft vira 'Peito'
  // ============================================
  final Map<Muscle, String> _muscleToNome = {
    // PEITO
    Muscle.chestLeft: 'Peito',
    Muscle.chestRight: 'Peito',
    
    // ABDÔMEN
    Muscle.abs: 'Abdômen',
    
    // BRAÇOS (bíceps e tríceps)
    Muscle.bicepsLeft: 'Braços',
    Muscle.bicepsRight: 'Braços',
    Muscle.tricepsLeft: 'Braços',
    Muscle.tricepsRight: 'Braços',
    
    // PERNAS (quadríceps e glúteos)
    Muscle.quadsLeft: 'Pernas',
    Muscle.quadsRight: 'Pernas',
    Muscle.glutesLeft: 'Glúteos',
    Muscle.glutesRight: 'Glúteos',
    
    // OMBROS (deltóides)
    Muscle.deltsLeft: 'Ombros',
    Muscle.deltsRight: 'Ombros',
    
    // COSTAS (trapézio)
    Muscle.trapsLeft: 'Costas',
    Muscle.trapsRight: 'Costas',
  };

  // ============================================
  // 🚀 INICIALIZA O CONTROLADOR QUANDO A TELA ABRE
  // ============================================
  @override
  void initState() {
    super.initState();
    _controller = BodyMapController();  // Cria o controlador
  }

  // ============================================
  // 🧹 LIMPA O CONTROLADOR QUANDO A TELA FECHA
  // ============================================
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ============================================
  // 🎯 GERA O TREINO BASEADO NOS MÚSCULOS SELECIONADOS
  // ============================================
  Future<void> _gerarTreino() async {
    // Se nenhum músculo foi selecionado, não faz nada
    if (_controller.selectedMuscles.isEmpty) return;

    setState(() => _isLoading = true);  // Mostra loading

    // Converte os músculos do pacote para nomes do seu banco (ex: 'Peito', 'Costas')
    final Set<String> musculosUnicos = {};
    for (var muscle in _controller.selectedMuscles) {
      final nome = _muscleToNome[muscle];
      if (nome != null) musculosUnicos.add(nome);
    }

    // Busca os exercícios no banco de dados
    final db = DatabaseHelper();
    final todosExercicios = await db.getExercicios();
    
    // Filtra apenas os exercícios que correspondem aos músculos selecionados
    final exerciciosFiltrados = todosExercicios.where((ex) {
      return musculosUnicos.contains(ex['musculo']);
    }).toList();

    setState(() => _isLoading = false);  // Esconde loading

    if (!mounted) return;  // Se a tela fechou, não faz nada

    // Vai para a tela de resultado com os exercícios filtrados
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

  // ============================================
  // 🎨 CONSTRÓI A TELA
  // ============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ========== BARRA SUPERIOR ==========
      appBar: AppBar(
        title: Text('Selecione os Músculos'),
        backgroundColor: AppColors.primary,  // Cor do tema
        centerTitle: true,
        actions: [
          // Botão para limpar todos os músculos selecionados
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              _controller.clearSelection();  // Limpa seleção
              setState(() {});
            },
            tooltip: 'Limpar seleção',
          ),
          // Botão para virar o corpo (ver frente/costas)
          IconButton(
            icon: Icon(Icons.flip),
            onPressed: () {
              _controller.toggleView();  // Alterna entre frente e costas
              setState(() {});
            },
            tooltip: 'Ver costas',
          ),
        ],
      ),
      
      // ========== CORPO DA TELA ==========
      body: Column(
        children: [
          // 📊 CONTADOR DE MÚSCULOS SELECIONADOS (aparece só se tiver algum)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final count = _controller.selectedMuscles.length;
              if (count == 0) return const SizedBox.shrink();  // Se não tem, não mostra
              
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
          
          // 🧍 DESENHO DO CORPO (SVG INTERATIVO)
          Expanded(
            child: InteractiveBodySvg(
              isFront: _controller.isFront,  // Está mostrando frente ou costas?
              selectedMuscles: _controller.selectedMuscles,  // Músculos já selecionados
              onMuscleTap: (muscle) {
                _controller.selectMuscle(muscle);  // Seleciona/deseleciona o músculo
                setState(() {});
              },
            ),
          ),
          
          // ========== BOTÕES INFERIORES ==========
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
                // Botão VOLTAR
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
                
                // Botão GERAR TREINO (só fica ativo se tiver músculos selecionados)
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

// ============================================
// 📋 TELA DE RESULTADO DO TREINO
// Mostra a lista de exercícios baseada nos músculos selecionados
// ============================================

class TreinoResultadoScreen extends StatelessWidget {
  final List<String> musculosSelecionados;  // Ex: ['Peito', 'Costas']
  final List<Map<String, dynamic>> exercicios;  // Lista de exercícios filtrados

  const TreinoResultadoScreen({
    Key? key,
    required this.musculosSelecionados,
    required this.exercicios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musculosTexto = musculosSelecionados.join(', ');  // Ex: "Peito, Costas"

    return Scaffold(
      appBar: AppBar(
        title: Text('Treino Personalizado'),
        backgroundColor: AppColors.primary,
      ),
      
      body: exercicios.isEmpty
          // ========== TELA DE NENHUM EXERCÍCIO ENCONTRADO ==========
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
          // ========== LISTA DE EXERCÍCIOS ==========
          : Column(
              children: [
                // 📊 RESUMO (mostra quais músculos e quantos exercícios)
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
                
                // 📋 LISTA DE EXERCÍCIOS (cada um com detalhes)
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
                          // Número do exercício
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                          ),
                          // Nome do exercício
                          title: Text(
                            ex['nome'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Séries e repetições + equipamento
                          subtitle: Text('${ex['series']}x ${ex['repeticoes']} • ${ex['equipamento']}'),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Descrição do exercício
                                  Text('📋 ${ex['descricao']}'),
                                  const SizedBox(height: 12),
                                  
                                  // Dica de descanso
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