import 'package:flutter/material.dart';

class SkillsPage extends StatefulWidget {
  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<SkillCategory> categories = [
    SkillCategory(
      title: '🦾 الأساسيات المتقدمة',
      icon: Icons.architecture,
      color: Color(0xFF6A5ACD),
      skills: [
        SkillItem('C++ Programming', 0.95, 'أداء عالي - تحسين الذاكرة'),
        SkillItem('Problem Solving', 0.96, 'تحليل المشكلات - حلول إبداعية'),
        SkillItem('C# & .NET Framework', 0.97, 'تطبيقات Enterprise'),
        SkillItem(
          'Object Oriented Programming',
          0.96,
          'برمجة كائنية متقدمة - SOLID Principles',
        ),
        SkillItem(
          'Data Structures & Algorithms',
          0.93,
          'حلول معقدة - كفاءة عالية',
        ),
        SkillItem('System Architecture', 0.94, 'تصميم أنظمة ضخمة'),
      ],
    ),
    SkillCategory(
      title: '📱 تطوير متعدد المنصات',
      icon: Icons.phone_iphone,
      color: Color(0xFF9370DB),
      skills: [
        SkillItem('Flutter & Dart', 0.99, 'تطبيقات Native - أداء فائق'),

        SkillItem('Responsive Design', 0.98, 'تجارب سلسة عبر الأجهزة'),
        SkillItem('Cross-Platform', 0.98, 'كود واحد - منصات متعددة'),
        SkillItem('UI/UX Excellence', 0.95, 'تجارب مستخدم استثنائية'),
        SkillItem('State Management Pro', 0.97, 'حلول معقدة - أداء مثالي'),
      ],
    ),
    SkillCategory(
      title: '🗄️ قواعد البيانات المتقدمة',
      icon: Icons.storage,
      color: Color(0xFF6A5ACD),
      skills: [
        SkillItem('SQL Mastery', 0.94, 'Query Optimization - Complex Joins'),
        SkillItem('NoSQL Expertise', 0.98, 'MongoDB - Firestore - Supabase'),
        SkillItem(
          'Database Architecture',
          0.90,
          'Design - Normalization - Indexing',
        ),
        SkillItem('Cloud Databases', 0.88, 'Firebase - Supabase - Real-time'),
        SkillItem('Performance Tuning', 0.85, 'Query Optimization - Caching'),
      ],
    ),
    SkillCategory(
      title: '⚡ التقنيات الحديثة',
      icon: Icons.rocket_launch,
      color: Color(0xFF9370DB),
      skills: [
        SkillItem('AI/ML Integration', 0.82, 'TensorFlow - Custom Models'),
        SkillItem('Blockchain Basics', 0.75, 'Smart Contracts - Web3'),
        SkillItem('Cloud Computing', 0.85, 'AWS - Google Cloud'),
        SkillItem('DevOps & CI/CD', 0.80, 'Automation - Deployment'),
        SkillItem('Microservices', 0.78, 'Scalable Architecture'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // بدء الأنيميشن بعد تحميل الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            // الهيدر الثابت
            SliverAppBar(
              expandedHeight: isTablet ? 220 : 180,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A5ACD), Color(0xFF9370DB)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF6A5ACD).withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'قدراتي ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 28 : 22,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Color(0xFF6A5ACD), blurRadius: 20)],
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF6A5ACD).withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // المحتوى الرئيسي - بدون أنيميشن
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 25 : 20),
                child: Column(
                  children: [
                    // الإحصائيات
                    _buildStatsSection(isTablet),
                    SizedBox(height: 30),

                    // فئات المهارات
                    ...categories
                        .map(
                          (category) =>
                              _buildCategorySection(category, isTablet),
                        )
                        .toList(),

                    SizedBox(height: 30),

                    // الخاتمة
                    _buildFooter(isTablet),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(bool isTablet) {
    final totalSkills = categories.fold(
      0,
      (sum, cat) => sum + cat.skills.length,
    );
    final avgLevel =
        categories
            .expand((cat) => cat.skills)
            .map((skill) => skill.level)
            .reduce((a, b) => a + b) /
        totalSkills;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A5ACD).withOpacity(0.3),
            Color(0xFF9370DB).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6A5ACD).withOpacity(0.3),
            blurRadius: 25,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            '$totalSkills',
            'مهارة متقنة',
            Icons.auto_awesome,
            Color(0xFF6A5ACD),
          ),
          _buildStatItem(
            '${categories.length}',
            'تخصص دقيق',
            Icons.category,
            Color(0xFF9370DB),
          ),
          _buildStatItem(
            '${(avgLevel * 100).toInt()}%',
            'كفاءة خارقة',
            Icons.rocket,
            Color(0xFF6A5ACD),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (_animation.value * 0.2),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: color, blurRadius: 8)],
                ),
              ),
              Text(
                label,
                style: TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategorySection(SkillCategory category, bool isTablet) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // هيدر الفئة
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  category.color.withOpacity(0.25),
                  category.color.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: category.color.withOpacity(0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: category.color.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(category.icon, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: category.color, blurRadius: 10)],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: category.color.withOpacity(0.6)),
                  ),
                  child: Text(
                    '${category.skills.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // المهارات
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: category.skills.map((skill) {
              return _buildSkillCard(skill, category.color, isTablet);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(SkillItem skill, Color color, bool isTablet) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * 20),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              width: isTablet ? 280 : 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.25), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.15),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // تأثير الخلفية
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.topRight,
                            radius: 1.2,
                            colors: [
                              color.withOpacity(0.08),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // المحتوى
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                skill.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 16 : 14,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(color: color, blurRadius: 8),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: color.withOpacity(0.5),
                                ),
                              ),
                              child: Text(
                                '${(skill.level * 100).toInt()}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          skill.description,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isTablet ? 12 : 11,
                          ),
                        ),
                        SizedBox(height: 12),
                        // شريط التقدم
                        Stack(
                          children: [
                            Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                            Container(
                              height: 5,
                              width: 200 * skill.level,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [color, color.withOpacity(0.7)],
                                ),
                                borderRadius: BorderRadius.circular(2.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withOpacity(0.4),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter(bool isTablet) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * 20),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6A5ACD).withOpacity(0.2),
                    Color(0xFF9370DB).withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFF6A5ACD).withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6A5ACD).withOpacity(0.25),
                    blurRadius: 30,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'أمتلك أساساً قوياً في البرمجة وحل المشكلات من خلال المسار المتكامل\nأعمل على تحويل المعرفة النظرية إلى تطبيقات عملية مبتكرة',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isTablet ? 14 : 13,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF6A5ACD).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF6A5ACD).withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      '34+ كورس متقدم مكتمل',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SkillCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<SkillItem> skills;

  SkillCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
  });
}

class SkillItem {
  final String name;
  final double level;
  final String description;

  SkillItem(this.name, this.level, this.description);
}
