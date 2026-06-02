// ============================================
// 📦 IMPORTAÇÕES NECESSÁRIAS
// ============================================
import 'package:flutter/material.dart';
import '../database/database_helper.dart';    // Banco de dados (exercícios, premium)
import '../theme/app_theme.dart';             // Cores e estilos do app
import 'body_selector_screen.dart';           // Tela do seletor de corpo (SVG)

// ============================================
// 🏋️ TELA PRINCIPAL - LISTA DE EXERCÍCIOS
// Mostra os exercícios, permite filtrar por músculo e tem sistema premium
// ============================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ============================================
  // 📊 VARIÁVEIS DE ESTADO
  // ============================================
  List<Map<String, dynamic>> _exercicios = [];  // Lista de exercícios atuais
  List<String> _musculos = [];                   // Lista de músculos para os filtros
  String _musculoSelecionado = 'Peito';         // Músculo atualmente selecionado
  bool _isPremium = false;                       // Usuário é premium?
  bool _isLoading = true;                        // Está carregando?
  String _personalEscolhido = 'nenhum';          // Personal trainer escolhido

  // ============================================
  // 🧑‍🏫 LISTA DE PERSONAIS TREINADORES (3 opções)
  // Cada um tem: ícone, frase, cor e dica motivacional
  // ============================================
  final Map<String, Map<String, dynamic>> _personais = {
    'Luva de Pedreiro': {
      'icone': '🧤',
      'frase': 'E aí, bora treinar pesado! É RECEBA! 🏆',
      'cor': Colors.brown,
      'dica': 'BORA TREINAR PESADO! HOJE É DIA DE SUPINO!'
    },
    'Bistecone': {
      'icone': '🥩',
      'frase': 'Foco, força e muita proteína! Bora crescer! 💪',
      'cor': Colors.red,
      'dica': 'TÁ LEVE! AUMENTA O PESO AÍ! BORA TREINAR!'
    },
    'Batista': {
      'icone': '🏋️',
      'frase': 'Shape vem com disciplina. Vamos detonar! 🔥',
      'cor': Colors.indigo,
      'dica': 'MAIS UM! SINGELA FORÇA! MAIS UM MOVIMENTO!'
    },
  };

  // ============================================
  // 🚀 INICIALIZA - CARREGA OS DADOS QUANDO A TELA ABRE
  // ============================================
  @override
  void initState() {
    super.initState();
    _carregarDados();  // Busca exercícios no banco
  }

  // ============================================
  // 📥 CARREGA OS DADOS DO BANCO (exercícios, músculos, premium, personal)
  // ============================================
  Future<void> _carregarDados() async {
    final db = DatabaseHelper();
    final musculos = await db.getMusculos();                     // Lista de músculos
    final premium = await db.isPremium();                        // Status premium
    final personal = await db.getPersonalEscolhido();            // Personal escolhido
    final exercicios = await db.getExerciciosPorMusculo(_musculoSelecionado);  // Exercícios do músculo

    setState(() {
      _musculos = musculos;
      _isPremium = premium;
      _personalEscolhido = personal;
      _exercicios = exercicios;
      _isLoading = false;
    });
  }

  // ============================================
  // 🔍 FILTRA EXERCÍCIOS POR MÚSCULO (quando clica nos botões)
  // ============================================
  Future<void> _filtrarPorMusculo(String musculo) async {
    setState(() {
      _musculoSelecionado = musculo;
      _isLoading = true;
    });
    
    final db = DatabaseHelper();
    final exercicios = await db.getExerciciosPorMusculo(musculo);
    
    setState(() {
      _exercicios = exercicios;
      _isLoading = false;
    });
  }

  // ============================================
  // 🧑‍🏫 ABRE DIÁLOGO PARA ESCOLHER O PERSONAL TRAINER
  // ============================================
  Future<void> _escolherPersonal() async {
    final escolhido = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🎯 Escolha seu Personal Trainer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Opção 1: Luva de Pedreiro
            ListTile(
              leading: Text('🧤', style: TextStyle(fontSize: 30)),
              title: Text('Luva de Pedreiro'),
              subtitle: Text('"É RECEBA!" - Treino pesado e motivador'),
              onTap: () => Navigator.pop(context, 'Luva de Pedreiro'),
            ),
            Divider(),
            // Opção 2: Bistecone
            ListTile(
              leading: Text('🥩', style: TextStyle(fontSize: 30)),
              title: Text('Bistecone'),
              subtitle: Text('"Tá leve!" - Foco em carga e intensidade'),
              onTap: () => Navigator.pop(context, 'Bistecone'),
            ),
            Divider(),
            // Opção 3: Batista
            ListTile(
              leading: Text('🏋️', style: TextStyle(fontSize: 30)),
              title: Text('Batista'),
              subtitle: Text('"Singela força!" - Disciplina e consistência'),
              onTap: () => Navigator.pop(context, 'Batista'),
            ),
          ],
        ),
      ),
    );

    // Se o usuário escolheu algum, salva no banco
    if (escolhido != null) {
      final db = DatabaseHelper();
      await db.setPersonalEscolhido(escolhido);
      setState(() {
        _personalEscolhido = escolhido;
      });
      
      // Mostra mensagem de confirmação
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Agora você treina com ${_personais[escolhido]!['icone']} ${escolhido}!'),
          backgroundColor: _personais[escolhido]!['cor'],
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // ============================================
  // 🎨 CONSTRÓI A TELA
  // ============================================
  @override
  Widget build(BuildContext context) {
    final personalAtual = _personalEscolhido != 'nenhum' ? _personais[_personalEscolhido] : null;

    return Scaffold(
      // ========== BARRA SUPERIOR (APP BAR) ==========
      appBar: AppBar(
        title: Text('MEUS TREINOS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: AppColors.primary,      // Cor do tema
        foregroundColor: AppColors.textLight,
        actions: [
          // 🧍 BOTÃO DO SELETOR DE CORPO (Body Selector)
          IconButton(
            icon: Icon(Icons.accessibility_new, color: AppColors.textLight),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BodySelectorScreen()),
              );
            },
            tooltip: 'Treinar por parte do corpo',
          ),
          // ⭐ BOTÃO PREMIUM (estrela)
          IconButton(
            icon: Icon(_isPremium ? Icons.star : Icons.star_border, color: AppColors.accent),
            onPressed: _mostrarDialogPremium,
            tooltip: _isPremium ? 'Premium Ativo' : 'Assinar Premium',
          ),
        ],
      ),
      
      // ========== CORPO DA TELA ==========
      body: Column(
        children: [
          // ========== BANNER DO PERSONAL (só aparece se for premium e tiver personal escolhido) ==========
          if (_isPremium && personalAtual != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.3),
                border: Border(bottom: BorderSide(color: AppColors.accent.withOpacity(0.3))),
              ),
              child: Row(
                children: [
                  Text(personalAtual['icone'], style: TextStyle(fontSize: 30)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal: $_personalEscolhido',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.accent),
                        ),
                        Text(
                          personalAtual['frase'],
                          style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  // Botão para trocar de personal
                  IconButton(
                    icon: Icon(Icons.edit, size: 18, color: AppColors.accent),
                    onPressed: _escolherPersonal,
                    tooltip: 'Trocar Personal',
                  ),
                ],
              ),
            ),

          // ========== BANNER PARA NÃO-PREMIUM (incentiva a assinar) ==========
          if (!_isPremium)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.3),
                border: Border(bottom: BorderSide(color: AppColors.accent.withOpacity(0.2))),
              ),
              child: Row(
                children: [
                  Icon(Icons.workspace_premium, color: AppColors.accent, size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Assine Premium e ganhe um Personal Trainer exclusivo',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _mostrarDialogPremium,
                    child: Text('ASSINAR'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      foregroundColor: AppColors.textLight,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: Size(0, 30),
                    ),
                  ),
                ],
              ),
            ),
          
          // ========== FILTRO POR MÚSCULO (botões horizontais) ==========
          if (!_isLoading && _musculos.isNotEmpty)
            Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _musculos.length,
                itemBuilder: (context, index) {
                  final musculo = _musculos[index];
                  final isSelected = _musculoSelecionado == musculo;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(musculo),
                      selected: isSelected,
                      onSelected: (_) => _filtrarPorMusculo(musculo),
                      backgroundColor: AppColors.background,
                      selectedColor: AppColors.accent,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          
          // ========== LISTA DE EXERCÍCIOS ==========
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: AppColors.accent))
                : _exercicios.isEmpty
                    ? Center(child: Text('Nenhum exercício para ${_musculoSelecionado}', style: AppStyles.bodyMedium))
                    : ListView.builder(
                        padding: EdgeInsets.all(12),
                        itemCount: _exercicios.length,
                        itemBuilder: (context, index) {
                          final ex = _exercicios[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            color: AppColors.cardBackground,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ExpansionTile(  // Expande ao clicar
                              leading: Icon(Icons.fitness_center, color: AppColors.accent),
                              title: Text(
                                ex['nome'],
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.textPrimary),
                              ),
                              subtitle: Text(
                                '${ex['series']}x ${ex['repeticoes']} • ${ex['equipamento']}',
                                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Descrição do exercício
                                      Text(
                                        '📋 ${ex['descricao']}',
                                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                                      ),
                                      SizedBox(height: 12),
                                      
                                      // Dica do Personal (só para premium)
                                      if (_isPremium && personalAtual != null)
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(personalAtual['icone'], style: TextStyle(fontSize: 20)),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  '💬 Dica: ${personalAtual['dica']}',
                                                  style: TextStyle(fontSize: 12, color: AppColors.accent),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      
                                      // Mensagem para não-premium (mostra o que está perdendo)
                                      if (!_isPremium)
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary.withOpacity(0.3),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.star_border, size: 14, color: AppColors.accent),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    'Assine Premium para receber dicas do seu Personal Trainer!',
                                                    style: TextStyle(fontSize: 10, color: AppColors.textHint),
                                                  ),
                                                ),
                                              ],
                                            ),
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

  
  // ⭐ DIÁLOGO DE ASSINATURA PREMIUM

  void _mostrarDialogPremium() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Row(
          children: [
            Icon(Icons.workspace_premium, color: AppColors.accent),
            SizedBox(width: 8),
            Text('Área Premium', style: TextStyle(color: AppColors.textPrimary)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ASSINE PREMIUM e escolha seu PERSONAL TRAINER:', style: TextStyle(color: AppColors.textSecondary)),
            SizedBox(height: 16),
            _buildPersonalOption('Luva de Pedreiro', '🧤', 'Treino pesado e motivador'),
            _buildPersonalOption('Bistecone', '🥩', 'Foco em carga e intensidade'),
            _buildPersonalOption('Batista', '🏋️', 'Disciplina e consistência'),
            SizedBox(height: 16),
            Text('R\$ 29,90/mês', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.accent)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Depois', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final db = DatabaseHelper();
              await db.updatePremium(true);       // Ativa premium no banco
              setState(() {
                _isPremium = true;
              });
              _escolherPersonal();                // Abre escolha do personal
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('🎉 Premium ativado!'), backgroundColor: AppColors.success),
              );
            },
            child: Text('ASSINAR AGORA'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // 🧑‍🏫 CONSTRÓI AS OPÇÕES DE PERSONAL (icone, nome, descrição)
  // ============================================
  Widget _buildPersonalOption(String nome, String icone, String descricao) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(icone, style: TextStyle(fontSize: 24)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nome, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(descricao, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}