// ============================================
// 📦 IMPORTAÇÕES NECESSÁRIAS
// ============================================
import 'package:shared_preferences/shared_preferences.dart';  // Salvar dados no celular
import 'dart:convert';  // Converter textos para JSON

// ============================================
// 🗄️ CLASSE DO BANCO DE DADOS (Guarda exercícios e status premium)
// ============================================

class DatabaseHelper {
  // ⭐ SINGLETON (garante que só existe uma instância do banco de dados)
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;  // Pega a instância única
  DatabaseHelper._internal();  // Construtor privado

  // ============================================
  // 🔑 CHAVES PARA GUARDAR DADOS (nomes das "gavetas")
  // ============================================
  static const String _exerciciosKey = 'exercicios';      // Onde guarda os exercícios
  static const String _isPremiumKey = 'is_premium';       // Onde guarda se é premium
  static const String _personalKey = 'personal_escolhido'; // Onde guarda o personal escolhido

  // ============================================
  // 📋 LISTA PADRÃO DE EXERCÍCIOS (quando o app abre pela primeira vez)
  // ============================================
  final List<Map<String, dynamic>> _exerciciosPadrao = [
    // PEITO (4 exercícios)
    {'id': 1, 'nome': 'Supino Reto', 'musculo': 'Peito', 'equipamento': 'Halter/Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 2, 'nome': 'Supino Inclinado', 'musculo': 'Peito', 'equipamento': 'Halter', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 3, 'nome': 'Crucifixo', 'musculo': 'Peito', 'equipamento': 'Halter', 'descricao': '3 séries de 12 repetições', 'series': 3, 'repeticoes': 12},
    {'id': 4, 'nome': 'Flexão', 'musculo': 'Peito', 'equipamento': 'Peso corporal', 'descricao': '3 séries de 15 repetições', 'series': 3, 'repeticoes': 15},
    
    // COSTAS (3 exercícios)
    {'id': 5, 'nome': 'Barra Fixa', 'musculo': 'Costas', 'equipamento': 'Peso corporal', 'descricao': '3 séries de máximas', 'series': 3, 'repeticoes': 'MAX'},
    {'id': 6, 'nome': 'Puxada Frontal', 'musculo': 'Costas', 'equipamento': 'Polia', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 7, 'nome': 'Remada Curvada', 'musculo': 'Costas', 'equipamento': 'Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    
    // PERNAS (2 exercícios)
    {'id': 8, 'nome': 'Agachamento Livre', 'musculo': 'Pernas', 'equipamento': 'Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 9, 'nome': 'Leg Press', 'musculo': 'Pernas', 'equipamento': 'Máquina', 'descricao': '4 séries de 12 repetições', 'series': 4, 'repeticoes': 12},
    
    // OMBROS (2 exercícios)
    {'id': 10, 'nome': 'Desenvolvimento', 'musculo': 'Ombros', 'equipamento': 'Halter/Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 11, 'nome': 'Elevação Lateral', 'musculo': 'Ombros', 'equipamento': 'Halter', 'descricao': '4 séries de 12 repetições', 'series': 4, 'repeticoes': 12},
    
    // BRAÇOS (2 exercícios)
    {'id': 12, 'nome': 'Rosca Direta', 'musculo': 'Braços', 'equipamento': 'Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 13, 'nome': 'Tríceps Corda', 'musculo': 'Braços', 'equipamento': 'Polia', 'descricao': '4 séries de 12 repetições', 'series': 4, 'repeticoes': 12},
    
    // ABDÔMEN (2 exercícios)
    {'id': 14, 'nome': 'Abdominal Tradicional', 'musculo': 'Abdômen', 'equipamento': 'Peso corporal', 'descricao': '3 séries de 20 repetições', 'series': 3, 'repeticoes': 20},
    {'id': 15, 'nome': 'Prancha', 'musculo': 'Abdômen', 'equipamento': 'Peso corporal', 'descricao': '3 séries de 30 segundos', 'series': 3, 'repeticoes': '30s'},
  ];

  // ============================================
  // 💾 INICIALIZA OS DADOS (roda automaticamente na primeira vez)
  // ============================================
  Future<void> _initData() async {
    final prefs = await SharedPreferences.getInstance();  // Abre o "baú" de dados
    
    // Se não tem exercícios salvos, salva a lista padrão
    if (!prefs.containsKey(_exerciciosKey)) {
      final exerciciosJson = jsonEncode(_exerciciosPadrao);  // Converte para texto
      await prefs.setString(_exerciciosKey, exerciciosJson); // Salva
    }
    
    // Se não tem status premium, começa como "não premium" (false)
    if (!prefs.containsKey(_isPremiumKey)) {
      await prefs.setBool(_isPremiumKey, false);
    }
    
    // Se não tem personal escolhido, começa como "nenhum"
    if (!prefs.containsKey(_personalKey)) {
      await prefs.setString(_personalKey, 'nenhum');
    }
  }

  // ============================================
  // 📋 PEGA TODOS OS EXERCÍCIOS
  // ============================================
  Future<List<Map<String, dynamic>>> getExercicios() async {
    await _initData();  // Garante que os dados existem
    final prefs = await SharedPreferences.getInstance();
    final exerciciosJson = prefs.getString(_exerciciosKey);  // Pega o texto salvo
    
    if (exerciciosJson != null) {
      List<dynamic> decoded = jsonDecode(exerciciosJson);  // Converte texto de volta para lista
      return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return _exerciciosPadrao;  // Se der erro, retorna a lista padrão
  }

  // ============================================
  // 🎯 FILTRA EXERCÍCIOS POR MÚSCULO (ex: só "Peito")
  // ============================================
  Future<List<Map<String, dynamic>>> getExerciciosPorMusculo(String musculo) async {
    final todos = await getExercicios();  // Pega todos os exercícios
    return todos.where((ex) => ex['musculo'] == musculo).toList();  // Filtra
  }

  // ============================================
  // 📋 PEGA A LISTA DE MÚSCULOS (sem repetir, ex: "Peito", "Costas"...)
  // ============================================
  Future<List<String>> getMusculos() async {
    final todos = await getExercicios();
    Set<String> musculos = {};  // Set não permite repetidos
    for (var ex in todos) {
      musculos.add(ex['musculo']);
    }
    return musculos.toList();
  }

  // ============================================
  // ⭐ VERIFICA SE O USUÁRIO É PREMIUM
  // Retorna: true (é premium) ou false (não é)
  // ============================================
  Future<bool> isPremium() async {
    await _initData();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isPremiumKey) ?? false;  // Se não achar, retorna false
  }

  // ============================================
  // ⭐ ATUALIZA O STATUS PREMIUM
  // Use: updatePremium(true) para ativar, updatePremium(false) para desativar
  // ============================================
  Future<void> updatePremium(bool isPremium) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPremiumKey, isPremium);
  }

  // ============================================
  // 🧑‍🏫 PEGA O PERSONAL TRAINER ESCOLHIDO PELO USUÁRIO
  // Retorna: "Luva de Pedreiro", "Bistecone", "Batista" ou "nenhum"
  // ============================================
  Future<String> getPersonalEscolhido() async {
    await _initData();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_personalKey) ?? 'nenhum';
  }

  // ============================================
  // 🧑‍🏫 SALVA O PERSONAL TRAINER ESCOLHIDO PELO USUÁRIO
  // Use: setPersonalEscolhido("Luva de Pedreiro")
  // ============================================
  Future<void> setPersonalEscolhido(String personal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_personalKey, personal);
  }
}