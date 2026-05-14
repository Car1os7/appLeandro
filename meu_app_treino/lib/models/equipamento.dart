import 'package:flutter/material.dart';
import '../models/equipamento.dart';
import '../theme/app_theme.dart';
import 'musculo_screen.dart';

class EquipamentoScreen extends StatefulWidget {
  @override
  _EquipamentoScreenState createState() => _EquipamentoScreenState();
}

class _EquipamentoScreenState extends State<EquipamentoScreen> {
  String? _equipamentoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione o equipamento'),
        backgroundColor: AppColors.primary,  // ← MUDEI
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),  // ← MUDEI
            ),
            child: Column(
              children: [
                Icon(Icons.fitness_center, size: 50, color: AppColors.primary),  // ← MUDEI
                SizedBox(height: 10),
                Text(
                  'ETAPA 1 DE 3',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                Text(
                  'Qual equipamento você tem disponível?',
                  style: AppStyles.titleMedium,  // ← MUDEI
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: Equipamento.getEquipamentos().length,
              itemBuilder: (context, index) {
                final equip = Equipamento.getEquipamentos()[index];
                final isSelected = _equipamentoSelecionado == equip.nome;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _equipamentoSelecionado = equip.nome;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.cardBackground,  // ← MUDEI
                      borderRadius: AppStyles.defaultBorderRadius,  // ← MUDEI
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(equip.icone, style: TextStyle(fontSize: 40)),
                        SizedBox(height: 10),
                        Text(
                          equip.nome,
                          style: AppStyles.titleSmall.copyWith(
                            color: isSelected ? AppColors.textLight : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: AppStyles.buttonBorderRadius),
                    ),
                    child: Text('← VOLTAR'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _equipamentoSelecionado != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MusculoScreen(
                                  equipamentoSelecionado: _equipamentoSelecionado!,
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textLight,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: AppStyles.buttonBorderRadius),
                    ),
                    child: Text('CONTINUAR →'),
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