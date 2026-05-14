class FiltroTreino {
  String? equipamento;
  List<String> musculosSelecionados = [];
  
  void limpar() {
    equipamento = null;
    musculosSelecionados.clear();
  }
  
  bool get equipamentoSelecionado => equipamento != null;
  bool get musculosSelecionadosValidos => musculosSelecionados.isNotEmpty;
  
  void alternarMusculo(String musculo) {
    if (musculosSelecionados.contains(musculo)) {
      musculosSelecionados.remove(musculo);
    } else {
      musculosSelecionados.add(musculo);
    }
  }
  
  // Retorna quantos filtros estão ativos
  int get totalFiltrosAtivos {
    int count = 0;
    if (equipamento != null) count++;
    count += musculosSelecionados.length;
    return count;
  }
  
  // Verifica se um exercício atende aos filtros
  bool exercicioAtende(Map<String, dynamic> exercicio) {
    // Verifica equipamento
    if (equipamento != null && 
        exercicio['equipamento'] != equipamento &&
        !exercicio['equipamento'].contains(equipamento!)) {
      return false;
    }
    
    // Verifica músculo (se tiver músculos selecionados)
    if (musculosSelecionados.isNotEmpty && 
        !musculosSelecionados.contains(exercicio['musculo'])) {
      return false;
    }
    
    return true;
  }
}