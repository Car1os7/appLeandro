import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../theme/app_theme.dart';
import 'equipamento_screen.dart';
import 'body_selector_screen.dart';  

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _exercicios = [];
  List<String> _musculos = [];
  String _musculoSelecionado = 'Peito';
  bool _isPremium = false;
  bool _isLoading = true;
  String _personalEscolhido = 'nenhum';

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

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final db = DatabaseHelper();
    final musculos = await db.getMusculos();
    final premium = await db.isPremium();
    final personal = await db.getPersonalEscolhido();
    final exercicios = await db.getExerciciosPorMusculo(_musculoSelecionado);

    setState(() {
      _musculos = musculos;
      _isPremium = premium;
      _personalEscolhido = personal;
      _exercicios = exercicios;
      _isLoading = false;
    });
  }

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

  Future<void> _escolherPersonal() async {
    final escolhido = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🎯 Escolha seu Personal Trainer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Text('🧤', style: TextStyle(fontSize: 30)),
              title: Text('Luva de Pedreiro'),
              subtitle: Text('"É RECEBA!" - Treino pesado e motivador'),
              onTap: () => Navigator.pop(context, 'Luva de Pedreiro'),
            ),
            Divider(),
            ListTile(
              leading: Text('🥩', style: TextStyle(fontSize: 30)),
              title: Text('Bistecone'),
              subtitle: Text('"Tá leve!" - Foco em carga e intensidade'),
              onTap: () => Navigator.pop(context, 'Bistecone'),
            ),
            Divider(),
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

    if (escolhido != null) {
      final db = DatabaseHelper();
      await db.setPersonalEscolhido(escolhido);
      setState(() {
        _personalEscolhido = escolhido;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Agora você treina com ${_personais[escolhido]!['icone']} ${escolhido}!'),
          backgroundColor: _personais[escolhido]!['cor'],
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final personalAtual = _personalEscolhido != 'nenhum' ? _personais[_personalEscolhido] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Treinos', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          // Botão Body Selector
          IconButton(
            icon: Icon(Icons.accessibility_new, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BodySelectorScreen()),
              );
            },
            tooltip: 'Treinar por parte do corpo',
          ),
          // Botão Treino Personalizado (Equipamento)
          IconButton(
            icon: Icon(Icons.new_releases, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EquipamentoScreen()),
              );
            },
            tooltip: 'Montar Treino Personalizado',
          ),
          // Botão Premium
          IconButton(
            icon: Icon(_isPremium ? Icons.star : Icons.star_border),
            onPressed: _mostrarDialogPremium,
            tooltip: _isPremium ? 'Premium Ativo' : 'Assinar Premium',
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner do Personal (SÓ PARA PREMIUM)
          if (_isPremium && personalAtual != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: personalAtual['cor'].withOpacity(0.1),
                border: Border(bottom: BorderSide(color: personalAtual['cor'].withOpacity(0.3))),
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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: personalAtual['cor']),
                        ),
                        Text(
                          personalAtual['frase'],
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, size: 20),
                    onPressed: _escolherPersonal,
                    tooltip: 'Trocar Personal',
                  ),
                ],
              ),
            ),

          // Banner para não-premium (incentivo)
          if (!_isPremium)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border(bottom: BorderSide(color: Colors.orange[100]!)),
              ),
              child: Row(
                children: [
                  Icon(Icons.workspace_premium, color: Colors.orange, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Assine Premium e ganhe um Personal Trainer exclusivo (Luva de Pedreiro, Bistecone ou Batista)!',
                      style: TextStyle(fontSize: 12, color: Colors.orange[800]),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _mostrarDialogPremium,
                    child: Text('ASSINAR'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: Size(0, 30),
                    ),
                  ),
                ],
              ),
            ),
          
          // Filtro por músculo
          if (!_isLoading && _musculos.isNotEmpty)
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 8),
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
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.deepPurple,
                      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    ),
                  );
                },
              ),
            ),
          
          // LISTA DE EXERCÍCIOS
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _exercicios.isEmpty
                    ? Center(child: Text('Nenhum exercício para ${_musculoSelecionado}'))
                    : ListView.builder(
                        padding: EdgeInsets.all(12),
                        itemCount: _exercicios.length,
                        itemBuilder: (context, index) {
                          final ex = _exercicios[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: ExpansionTile(
                              leading: Icon(Icons.fitness_center, color: Colors.deepPurple),
                              title: Text(
                                ex['nome'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Text('${ex['series']}x ${ex['repeticoes']} • ${ex['equipamento']}'),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '📋 ${ex['descricao']}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 12),
                                      
                                      if (_isPremium && personalAtual != null)
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: personalAtual['cor'].withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(personalAtual['icone'], style: TextStyle(fontSize: 20)),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  '💬 Dica do ${_personalEscolhido}: ${personalAtual['dica']}',
                                                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      
                                      if (!_isPremium)
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.star_border, size: 16, color: Colors.amber),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    '💪 Assine Premium para receber dicas motivacionais do seu Personal Trainer exclusivo!',
                                                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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

  void _mostrarDialogPremium() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.workspace_premium, color: Colors.amber),
            SizedBox(width: 8),
            Text('Área Premium'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ASSINE PREMIUM e escolha seu PERSONAL TRAINER:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildPersonalOption('Luva de Pedreiro', '🧤', 'É RECEBA! Treino pesado e motivador'),
            _buildPersonalOption('Bistecone', '🥩', 'Tá leve! Foco em carga e intensidade'),
            _buildPersonalOption('Batista', '🏋️', 'Singela força! Disciplina e consistência'),
            SizedBox(height: 16),
            Text('R\$ 29,90/mês', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Depois'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final db = DatabaseHelper();
              await db.updatePremium(true);
              setState(() {
                _isPremium = true;
              });
              _escolherPersonal();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('🎉 Premium ativado! Agora escolha seu Personal!'), backgroundColor: Colors.green),
              );
            },
            child: Text('ASSINAR AGORA'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
          ),
        ],
      ),
    );
  }

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
                Text(nome, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(descricao, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}