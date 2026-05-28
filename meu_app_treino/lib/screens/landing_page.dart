import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'transition_dmc_screen.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com gradiente otimizado
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.landingGradient,
            ),
          ),
          
          // Conteúdo
          CustomScrollView(
            slivers: [
              // AppBar
              SliverAppBar(
                expandedHeight: 320,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    AppTexts.appName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppColors.accent,
                    ),
                  ),
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          AppColors.primary.withOpacity(0.3),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Ícone principal
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.accent,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.5),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.fitness_center,
                              size: 65,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "SUA JORNADA",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                              color: AppColors.textLight,
                              shadows: [
                                Shadow(
                                  color: AppColors.primary,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "COMEÇA AQUI",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Disciplina. Evolução. Resultados.",
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 2,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppStyles.screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Frase motivacional
                      _buildQuoteCard(
                        '"A dor que você sente hoje será a força que você terá amanhã."',
                      ),
                      
                      SizedBox(height: 30),
                      
                      // ========== SEÇÃO 1: VANTAGENS ==========
                      _buildSectionTitle('🔥 VANTAGENS', Icons.emoji_events),
                      SizedBox(height: 12),
                      
                      _buildBenefitCard(
                        titulo: 'MAIS ENERGIA',
                        descricao: 'Seu dia rende muito mais. Acaba o cansaço constante.',
                        icone: Icons.flash_on,
                      ),
                      _buildBenefitCard(
                        titulo: 'SAÚDE EM DIA',
                        descricao: 'Coração forte, imunidade alta e mais disposição.',
                        icone: Icons.favorite,
                      ),
                      _buildBenefitCard(
                        titulo: 'AUTOESTIMA',
                        descricao: 'Você se sente melhor no espelho e mais confiante.',
                        icone: Icons.self_improvement,
                      ),
                      _buildBenefitCard(
                        titulo: 'MENTE SÃ',
                        descricao: 'Menos ansiedade, menos estresse, mais foco.',
                        icone: Icons.psychology,
                      ),
                      
                      SizedBox(height: 30),
                      
                      // ========== SEÇÃO 2: SOBRE A ACADEMIA ==========
                      _buildSectionTitle('🏆 SOBRE A ACADEMIA', Icons.business),
                      SizedBox(height: 12),
                      
                      Container(
                        width: double.infinity,
                        padding: AppStyles.cardPadding,
                        decoration: AppStyles.cardDecoration(
                          backgroundColor: AppColors.cardBackground,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'QUEM SOMOS?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                color: AppColors.accent,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '''
                              Somos mais do que uma academia, somos uma comunidade comprometida com o seu bem-estar 
                              e evolução constante. A MINHA ACADEMIA PREMIUM nasceu com o propósito de transformar 
                              vidas por meio do movimento, do exercício físico e da convivência. 
                              Oferecemos um espaço moderno, dinâmico e com profissionais de ponta para auxiliar você a atingir 
                              o seu potencial máximo. 
                              Se você busca performance e evolução constante, este é o lugar!
                              ''',
                              style: AppStyles.bodyMedium,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'NOSSA MISSÃO',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                color: AppColors.accent,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '''
                              Desejamos inspirar e facilitar a adoção de um estilo de vida mais ativo e saudável para todos que nos procuram.
                              Buscamos ser mais que uma academia, queremos ser um centro de motivação e 
                              acolhimento, onde você se sinta apoiado em cada etapa da sua jornada.
                              Queremos que cada treino seja uma experiência positiva e 
                              gratificante, que te inspire a se superar a cada dia. O seu sucesso é nossa maior recompensa.
                              ''',
                              style: AppStyles.bodyMedium,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'O QUE OFERECEMOS',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                color: AppColors.accent,
                              ),
                            ),
                            SizedBox(height: 10),
                            _buildOfferItem('✓ Mais de 30 exercícios organizados por músculo'),
                            _buildOfferItem('✓ Treinos personalizados por equipamento'),
                            _buildOfferItem('✓ Sistema Premium com personal trainers exclusivos'),
                            _buildOfferItem('✓ Seletor de partes do corpo interativo'),
                            _buildOfferItem('✓ Acompanhamento de evolução'),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      // ========== SEÇÃO 3: REFERÊNCIAS ==========
                      _buildSectionTitle('⭐ REFERÊNCIAS', Icons.people),
                      SizedBox(height: 12),
                      
                      Text(
                        'Pessoas que você pode seguir para aprender mais:',
                        style: AppStyles.bodySmall,
                      ),
                      SizedBox(height: 16),
                      
                      _buildInfluencerCard(
                        nome: 'CAROLINE GIRVAN',
                        icone: '💪',
                        descricao: 'Treinos intensos e completos',
                        redes: 'YouTube | Instagram',
                      ),
                      _buildInfluencerCard(
                        nome: 'JEFF NIPPARD',
                        icone: '📚',
                        descricao: 'Treino baseado em ciência',
                        redes: 'YouTube | Instagram',
                      ),
                      _buildInfluencerCard(
                        nome: 'LEANDRO TWIN',
                        icone: '🇧🇷',
                        descricao: 'Conteúdo nacional sobre hipertrofia',
                        redes: 'YouTube | Instagram',
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Dica extra
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: AppStyles.cardDecoration(
                          backgroundColor: AppColors.cardBackground,
                        ).copyWith(
                          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.lightbulb, color: AppColors.accent, size: 24),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Siga essas referências e aprenda todos os dias!',
                                style: AppStyles.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      // ========== SEÇÃO 4: O PREÇO DA OMISSÃO ==========
                      _buildSectionTitle('⚠️ O PREÇO DA OMISSÃO', Icons.warning_amber),
                      SizedBox(height: 12),
                      
                      _buildWarningCard(
                        titulo: 'PERDA DE FORÇA',
                        descricao: 'Músculos enfraquecem, corpo frágil',
                      ),
                      _buildWarningCard(
                        titulo: 'SAÚDE MENTAL',
                        descricao: 'Maior risco de depressão e ansiedade',
                      ),
                      _buildWarningCard(
                        titulo: 'DOENÇAS',
                        descricao: 'Diabetes, pressão alta e problemas cardíacos',
                      ),
                      
                      SizedBox(height: 30),
                      
                      // ========== BOTÃO FINAL ==========
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          gradient: AppColors.premiumGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              '⚔️ VOCÊ ESTÁ PRONTO?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Milhares de pessoas já começaram sua transformação.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textDark.withOpacity(0.8),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TransitionDMCScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.arrow_forward, size: 22),
                                label: Text(
                                  AppTexts.enterButton,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.textLight,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  elevation: 8,
                                  shadowColor: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 40),
                      
                      Center(
                        child: Text(
                          '🏆 "O único treino ruim é o que não foi feito." 🏆',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textHint,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== WIDGETS AUXILIARES ==========

  Widget _buildSectionTitle(String titulo, IconData icone) {
    return Row(
      children: [
        Icon(icone, color: AppColors.accent, size: 24),
        SizedBox(width: 8),
        Text(
          titulo,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteCard(String quote) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: AppStyles.cardDecoration(
        backgroundColor: AppColors.cardBackground,
      ),
      child: Text(
        quote,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.italic,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildBenefitCard({
    required String titulo,
    required String descricao,
    required IconData icone,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: AppStyles.cardDecoration(
        backgroundColor: AppColors.cardBackground,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: AppColors.premiumGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icone, color: AppColors.textDark, size: 22),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  descricao,
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard({
    required String titulo,
    required String descricao,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: AppStyles.cardDecoration(
        backgroundColor: AppColors.cardBackground,
      ).copyWith(
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber, color: AppColors.primary, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  descricao,
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferItem(String texto) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Text(
        texto,
        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildInfluencerCard({
    required String nome,
    required String icone,
    required String descricao,
    required String redes,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: AppStyles.cardDecoration(
        backgroundColor: AppColors.cardBackground,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppColors.premiumGradient,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(icone, style: TextStyle(fontSize: 24)),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  descricao,
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
                SizedBox(height: 2),
                Text(
                  redes,
                  style: TextStyle(fontSize: 9, color: AppColors.accent),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }
}