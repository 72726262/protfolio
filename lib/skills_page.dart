import 'package:flutter/material.dart';

class SkillsPage extends StatefulWidget {
  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // أضف هذا
  late Animation<double> _animation;

  final List<SkillCategory> categories = [
    SkillCategory(
      title: '🧠 الأساسيات المتقدمة',
      icon: Icons.code,
      color: Color(0xFF6A5ACD),
      skills: [
        SkillItem(
          'C# Programming',
          0.98,
          'برمجة C# متقدمة - OOP - LINQ - .NET',
        ),
        SkillItem(
          'Desktop Development',
          0.96,
          'تطوير تطبيقات Desktop - WinForms - WPF',
        ),
        SkillItem(
          'SQL Server Integration',
          0.95,
          'ربط قواعد البيانات - ADO.NET - Entity Framework',
        ),
        SkillItem('Problem Solving', 0.97, 'حل المشكلات المعقدة - الخوارزميات'),
        SkillItem('Data Structures', 0.94, 'هياكل البيانات المتقدمة في .NET'),
        SkillItem(
          'OOP & SOLID Principles',
          0.98,
          'مبادئ البرمجة الكائنية - SOLID - Design Patterns',
        ),
        SkillItem(
          'Memory Management',
          0.92,
          'إدارة الذاكرة في .NET - Garbage Collection',
        ),
        SkillItem(
          'Database Design',
          0.93,
          'تصميم قواعد البيانات - Normalization - Relationships',
        ),
      ],
    ),
    SkillCategory(
      title: '💻 تطوير Desktop بـ C#',
      icon: Icons.desktop_windows,
      color: Color(0xFF2E86AB),
      skills: [
        SkillItem(
          'WinForms Development',
          0.96,
          'تطوير واجهات Desktop مع WinForms',
        ),

        SkillItem(
          'SQL Server Integration',
          0.95,
          'ربط تطبيقات C# مع SQL Server',
        ),
        SkillItem('ADO.NET', 0.94, 'الوصول إلى البيانات باستخدام ADO.NET'),
        SkillItem(
          'Entity Framework',
          0.90,
          'ORM مع Entity Framework - Code First',
        ),
        SkillItem('Windows Services', 0.85, 'تطوير خدمات Windows'),
        SkillItem(
          'API Integration',
          0.92,
          'دمج واجهات برمجية مع تطبيقات Desktop',
        ),
        SkillItem(
          'Reporting Services',
          0.87,
          'تقارير متقدمة مع SQL Server Reporting',
        ),
      ],
    ),
    SkillCategory(
      title: '📱 تطوير متعدد المنصات',
      icon: Icons.phone_iphone,
      color: Color(0xFF9370DB),
      skills: [
        SkillItem('Flutter & Dart', 0.99, 'تطبيقات Native - أداء فائق'),
        SkillItem('Full-Stack Apps', 0.94, 'تطبيقات كاملة Frontend + Backend'),
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
        SkillItem('SQL Server', 0.96, 'إدارة وتطوير قواعد بيانات SQL Server'),
        SkillItem('Firebase', 0.94, 'Authentication - Firestore - Storage'),
        SkillItem('Supabase', 0.93, 'Backend كامل - PostgreSQL - Auth'),
        SkillItem('RESTful API', 0.95, 'بناء واستهلاك واجهات REST API'),
        SkillItem(
          'Database Design',
          0.94,
          'تصميم قواعد البيانات - العلاقات - المفاتيح',
        ),
        SkillItem(
          'Database Architecture',
          0.90,
          'Design - Normalization - Indexing',
        ),
        SkillItem('Cloud Databases', 0.88, 'Firebase - Supabase - Real-time'),
        SkillItem('Performance Tuning', 0.85, 'Query Optimization - Caching'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    // تهيئة الـ Animation Controller
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
    _controller.dispose(); // التخلص من الـ controller
    super.dispose();
  }

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
              expandedHeight: isTablet ? 180 : 150,
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
                  'مهاراتي التقنية', // تغيير من "قدراتي" إلى "مهاراتي التقنية"
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 24 : 20,
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

            // المحتوى الرئيسي
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 20 : 16),
                child: Column(
                  children: [
                    // الإحصائيات
                    _buildStatsSection(isTablet),
                    SizedBox(height: 20),

                    // فئات المهارات
                    ...categories
                        .map(
                          (category) =>
                              _buildCategorySection(category, isTablet),
                        )
                        .toList(),

                    SizedBox(height: 20),

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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A5ACD).withOpacity(0.3),
            Color(0xFF9370DB).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6A5ACD).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
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
            'كفاءة عالية',
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }

  Widget _buildCategorySection(SkillCategory category, bool isTablet) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // هيدر الفئة
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  category.color.withOpacity(0.25),
                  category.color.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: category.color.withOpacity(0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: category.color.withOpacity(0.2),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(category.icon, color: Colors.white, size: 22),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    category.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: category.color.withOpacity(0.6)),
                  ),
                  child: Text(
                    '${category.skills.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),

          // المهارات
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: category.skills.map((skill) {
              return _buildSkillCard(skill, category.color, isTablet);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(SkillItem skill, Color color, bool isTablet) {
    return Container(
      width: isTablet ? 260 : 240,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14),
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
                      fontSize: isTablet ? 15 : 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.5)),
                  ),
                  child: Text(
                    '${(skill.level * 100).toInt()}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              skill.description,
              style: TextStyle(
                color: Colors.white70,
                fontSize: isTablet ? 11 : 10,
              ),
            ),
            SizedBox(height: 10),
            // شريط التقدم
            Stack(
              children: [
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  height: 4,
                  width: 180 * skill.level,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A5ACD).withOpacity(0.2),
            Color(0xFF9370DB).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Text(
            'أمتلك أساساً قوياً في البرمجة وحل المشكلات من خلال المسار المتكامل\nأعمل على تحويل المعرفة النظرية إلى تطبيقات عملية مبتكرة',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isTablet ? 13 : 12,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFF6A5ACD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.3)),
            ),
            child: Text(
              '32+ كورس متقدم مكتمل',
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet ? 14 : 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
