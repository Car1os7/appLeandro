import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static const String _exerciciosKey = 'exercicios';
  static const String _isPremiumKey = 'is_premium';
  static const String _personalKey = 'personal_escolhido';

  final List<Map<String, dynamic>> _exerciciosPadrao = [
    {'id': 1, 'nome': 'Supino Reto', 'musculo': 'Peito', 'equipamento': 'Halter/Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 2, 'nome': 'Supino Inclinado', 'musculo': 'Peito', 'equipamento': 'Halter', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 3, 'nome': 'Crucifixo', 'musculo': 'Peito', 'equipamento': 'Halter', 'descricao': '3 séries de 12 repetições', 'series': 3, 'repeticoes': 12},
    {'id': 4, 'nome': 'Flexão', 'musculo': 'Peito', 'equipamento': 'Peso corporal', 'descricao': '3 séries de 15 repetições', 'series': 3, 'repeticoes': 15},
    {'id': 5, 'nome': 'Barra Fixa', 'musculo': 'Costas', 'equipamento': 'Peso corporal', 'descricao': '3 séries de máximas', 'series': 3, 'repeticoes': 'MAX'},
    {'id': 6, 'nome': 'Puxada Frontal', 'musculo': 'Costas', 'equipamento': 'Polia', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 7, 'nome': 'Remada Curvada', 'musculo': 'Costas', 'equipamento': 'Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 8, 'nome': 'Agachamento Livre', 'musculo': 'Pernas', 'equipamento': 'Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 9, 'nome': 'Leg Press', 'musculo': 'Pernas', 'equipamento': 'Máquina', 'descricao': '4 séries de 12 repetições', 'series': 4, 'repeticoes': 12},
    {'id': 10, 'nome': 'Desenvolvimento', 'musculo': 'Ombros', 'equipamento': 'Halter/Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 11, 'nome': 'Elevação Lateral', 'musculo': 'Ombros', 'equipamento': 'Halter', 'descricao': '4 séries de 12 repetições', 'series': 4, 'repeticoes': 12},
    {'id': 12, 'nome': 'Rosca Direta', 'musculo': 'Braços', 'equipamento': 'Barra', 'descricao': '4 séries de 10 repetições', 'series': 4, 'repeticoes': 10},
    {'id': 13, 'nome': 'Tríceps Corda', 'musculo': 'Braços', 'equipamento': 'Polia', 'descricao': '4 séries de 12 repetições', 'series': 4, 'repeticoes': 12},
    {'id': 14, 'nome': 'Abdominal Tradicional', 'musculo': 'Abdômen', 'equipamento': 'Peso corporal', 'descricao': '3 séries de 20 repetições', 'series': 3, 'repeticoes': 20},
    {'id': 15, 'nome': 'Prancha', 'musculo': 'Abdômen', 'equipamento': 'Peso corporal', 'descricao': '3 séries de 30 segundos', 'series': 3, 'repeticoes': '30s'},
  ];

  Future<void> _initData() async {
    final prefs = await SharedPreferences.getInstance();
    
    if (!prefs.containsKey(_exerciciosKey)) {
      final exerciciosJson = jsonEncode(_exerciciosPadrao);
      await prefs.setString(_exerciciosKey, exerciciosJson);
    }
    
    if (!prefs.containsKey(_isPremiumKey)) {
      await prefs.setBool(_isPremiumKey, false);
    }
    
    if (!prefs.containsKey(_personalKey)) {
      await prefs.setString(_personalKey, 'nenhum');
    }
  }

  Future<List<Map<String, dynamic>>> getExercicios() async {
    await _initData();
    final prefs = await SharedPreferences.getInstance();
    final exerciciosJson = prefs.getString(_exerciciosKey);
    
    if (exerciciosJson != null) {
      List<dynamic> decoded = jsonDecode(exerciciosJson);
      return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return _exerciciosPadrao;
  }

  Future<List<Map<String, dynamic>>> getExerciciosPorMusculo(String musculo) async {
    final todos = await getExercicios();
    return todos.where((ex) => ex['musculo'] == musculo).toList();
  }

  Future<List<String>> getMusculos() async {
    final todos = await getExercicios();
    Set<String> musculos = {};
    for (var ex in todos) {
      musculos.add(ex['musculo']);
    }
    return musculos.toList();
  }

  Future<bool> isPremium() async {
    await _initData();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isPremiumKey) ?? false;
  }

  Future<void> updatePremium(bool isPremium) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPremiumKey, isPremium);
  }

  Future<String> getPersonalEscolhido() async {
    await _initData();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_personalKey) ?? 'nenhum';
  }

  Future<void> setPersonalEscolhido(String personal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_personalKey, personal);
  }
}