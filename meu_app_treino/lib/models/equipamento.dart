class Equipamento {
  final String nome;
  final String icone;
  final String descricao;
  final bool isPopular;

  Equipamento({
    required this.nome,
    required this.icone,
    required this.descricao,
    this.isPopular = false,
  });

  static List<Equipamento> getEquipamentos() {
    return [
      Equipamento(nome: 'Peso corporal', icone: '🧘', descricao: 'Nenhum equipamento necessário', isPopular: true),
      Equipamento(nome: 'Halter', icone: '🏋️', descricao: 'Pesos livres', isPopular: true),
      Equipamento(nome: 'Barra', icone: '🏋️‍♂️', descricao: 'Barra olímpica', isPopular: true),
      Equipamento(nome: 'Kettlebell', icone: '⚙️', descricao: 'Peso russo'),
      Equipamento(nome: 'Elástico', icone: '🪢', descricao: 'Resistência variável'),
      Equipamento(nome: 'Máquina', icone: '🏭', descricao: 'Equipamentos de academia'),
      Equipamento(nome: 'Barra fixa', icone: '📏', descricao: 'Para costas'),
      Equipamento(nome: 'Banco', icone: '🪑', descricao: 'Para supino e exercícios'),
    ];
  }
}