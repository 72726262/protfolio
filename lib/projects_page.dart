import 'package:flutter/material.dart';
import 'package:protfolio/progectmodale1.dart';
import 'package:protfolio/project_details_page.dart';

class ProjectsPage extends StatelessWidget {
  final List<Project> projects = [
    Project(
      name: 'SocialmediaAPP',

      technologies: [
        'Flutter - مع أحدث إصدار وبتصميم Material Design 3',
        'Dart ',
        'Supabase - Backend-as-a-Service شامل',
        "PostgreSQL - قاعدة بيانات علاقية قوية",
        "Realtime Subscription - تحديث فوري للبيانات",
        "Row Level Security (RLS) - أمان على مستوى الصفوف",
        "supabase_flutter - للاتصال بقاعدة البيانات",
        "flutter_bloc - لإدارة الحالة بشكل احترافي",
        "image_picker - لالتقاط الصور من الكاميرا والمعرض",
        "video_player - لتشغيل الفيديوهات في الستوريز",
        "skeletonizer - لعرض هياكل التحميل",
        "intl - لدعم الترجمة والتنسيق",
        "shared_preferences - لحفظ الإعدادات المحلية",
        "Clean Architecture مع فصل كامل للطبقات",
        "Models → Services → Controllers → Views",
        "Streams للبيانات الحية",
        "إدارة حالة باستخدام BLoC Pattern",
      ],
      imageUrl: 'assets/images/project1.jpg',
      fullDescription:
          ' هو تطبيق اجتماعي متكامل يجمع أفضل مميزات المنصات الاجتماعية في مكان واحد، مصمم لتجربة مستخدم فريدة ومتميزة.',

      videoUrl:
          'https://drive.google.com/file/d/1P8Zo2umad6i-3_LdZ7jioWsQPRuHD-Ew/view?usp=drive_link',
      projectUrl: 'https://github.com/username/taskapp',
      category: 'تطبيقات موبايل',
    ),
    Project(
      name: 'ChatApp',

      technologies: [
        'Flutter لبناء الواجهة وإدارة حالة التطبيق',
        ' Supabase للمصادقة + قواعد البيانات + التخزين + Realtime',
        'Cubit / Bloc لإدارة الحالة',
        "Image Picker لرفع الصور",
        "SharedPreferences لحفظ إعدادات المستخدم الثي",
        " User authentication (Sign Up / Login)",
        " Real-time messaging (instant updates)",
        "Send images, text, or both",
        "Edit & delete messages",
        " Profile screen with editable name and profile photo",
        "Light & dark mode with saved preferences",
        "Clean, modern, responsive UI",
        "Local storage via SharedPreferences",
        "UI → Cubit/Bloc → Service Layer → Supabase AP",
      ],
      imageUrl: 'assets/images/project1.jpg',
      fullDescription:
          'تجربة شات كاملة مع واجهة عصرية وأداء سريع واستخدام تقنيات حديثة',

      videoUrl:
          'https://drive.google.com/file/d/1PjN4pQ6i4S118Fft5iO_Y2UdDBif0xSv/view?usp=drive_link',
      projectUrl: 'https://github.com/username/taskapp',
      category: 'تطبيقات موبايل',
    ),
    Project(
      name:
          '  متجر اكتروني Online store : تطبيق المستخدم (Client App) : تطبيق الأدمن / الليدر (Admin App)  ',
      category: 'تطبيقات موبايل',
      imageUrl: 'assets/images/project1.jpg',
      fullDescription:
          "تطبيق المستخدم (Client App)يمكن للمستخدم تصفح المنتجات بسهولة.عرض تفاصيل كل منتج مع السعر والصورة.عرض المنتجات الاكثر مبيعا إضافة المنتجات إلى السلة وإرسال الطلب مباشرة.رؤيه معلوماته الشخصية والتعديل 🧑‍💼 تطبيق الأدمن / الليدر (AdminApp) يمكن من خلاله إضافة المنتجات مع الصور والأسعار.عرض كل الطلبات الواردة الاوردرات من المستخدمين بشكل لحظي (Realtime).إمكانية متابعة حالة الطلب وتأكيد التسليم",
      technologies: [
        'Flutter',
        'Dart',
        'Firebase Auth',
        'Cloud Firestore',
        'Provider State Management',
        'Google Maps API',
        'Push Notifications',
      ],

      videoUrl: 'رابط فيديو حقيقي',
      projectUrl: 'رابط GitHub حقيقي',
    ),
    // ... باقي المشاريع بنفس الطريقة
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // تحديد نوع الجهاز بناءً على العرض
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: ListView(
          children: [
            Stack(
              children: [
                // خلفية متدرجة مع تأثيرات
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF8F9FA),
                        Color(0xFFE8EAED),
                        Color(0xFFF0F2F5),
                      ],
                    ),
                  ),
                ),

                // تأثيرات خلفية إضافية
                _buildBackgroundEffects(),

                SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile
                            ? 16
                            : isTablet
                            ? 24
                            : 32,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // شريط التنقل
                          _buildAppBar(context),
                          SizedBox(height: isMobile ? 20 : 30),

                          // العنوان والوصف
                          _buildHeaderSection(isMobile, isTablet, isDesktop),
                          SizedBox(height: isMobile ? 30 : 40),

                          // شبكة المشاريع
                          _buildProjectsGrid(
                            isMobile,
                            isTablet,
                            isDesktop,
                            screenWidth,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundEffects() {
    return Positioned.fill(
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0xFF6A5ACD).withOpacity(0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6A5ACD).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF6A5ACD)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(width: 12),
          Text(
            'مشاريعي',
            style: TextStyle(
              color: Color(0xFF6A5ACD),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF6A5ACD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${projects.length} مشروع',
              style: TextStyle(
                color: Color(0xFF6A5ACD),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(bool isMobile, bool isTablet, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أعمالي المبدعة 🚀',
          style: TextStyle(
            fontSize: isMobile
                ? 28
                : isTablet
                ? 36
                : 42,
            color: Color(0xFF6A5ACD),
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'مجموعة من أبرز المشاريع التي قمت بتطويرها باستخدام أحدث التقنيات',
          style: TextStyle(
            color: Color(0xFF666666),
            fontSize: isMobile ? 16 : 18,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16),
        // إحصائيات سريعة
        _buildStatsRow(isMobile),
      ],
    );
  }

  Widget _buildStatsRow(bool isMobile) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildStatItem('${projects.length}+', 'مشروع مكتمل', Icons.work),
        _buildStatItem('15+', 'تكنولوجيا مستخدمة', Icons.code),
        _buildStatItem('100%', 'رضا العملاء', Icons.thumb_up),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Color(0xFF6A5ACD)),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Color(0xFF6A5ACD),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: TextStyle(color: Color(0xFF666666), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
    double screenWidth,
  ) {
    // حساب عدد الأعمدة بناءً على حجم الشاشة
    int crossAxisCount = isMobile
        ? 1
        : isTablet
        ? 2
        : 3;

    // حساب نسبة الطول/العرض بشكل ديناميكي
    double childAspectRatio = isMobile
        ? 1.3
        : isTablet
        ? 1.2
        : 1.1;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: isMobile ? 16 : 24,
        mainAxisSpacing: isMobile ? 16 : 24,
        childAspectRatio: childAspectRatio,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(
          projects[index],
          isMobile,
          isTablet,
          isDesktop,
          context,
        );
      },
    );
  }

  Widget _buildProjectCard(
    Project project,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
    BuildContext context,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 500),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform(
            transform: Matrix4.identity()..scale(0.95 + (value * 0.05)),
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color(0xFFF8F9FA)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF6A5ACD).withOpacity(0.15),
                blurRadius: 30,
                spreadRadius: 2,
                offset: Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.white,
                blurRadius: 20,
                spreadRadius: 5,
                offset: Offset(-5, -5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // تأثير خلفي متحرك
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF6A5ACD).withOpacity(0.03),
                        Color(0xFF9370DB).withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // نقاط تأثير في الخلفية
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFF6A5ACD).withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showProjectDetails(context, project),
                  borderRadius: BorderRadius.circular(25),
                  highlightColor: Color(0xFF6A5ACD).withOpacity(0.1),
                  splashColor: Color(0xFF6A5ACD).withOpacity(0.2),
                  child: Container(
                    padding: EdgeInsets.all(isMobile ? 20 : 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الهيدر مع الأيقونة والبادج
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF6A5ACD),
                                    Color(0xFF9370DB),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF6A5ACD).withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.rocket_launch,
                                color: Colors.white,
                                size: isMobile ? 20 : 24,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                project.name,
                                style: TextStyle(
                                  fontSize: isMobile ? 18 : 22,
                                  color: Color(0xFF6A5ACD),
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF6A5ACD).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color(0xFF6A5ACD).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                project.category,
                                style: TextStyle(
                                  color: Color(0xFF6A5ACD),
                                  fontSize: isMobile ? 10 : 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: isMobile ? 15 : 20),

                        // الوصف المختصر
                        Text(
                          _getShortDescription(project.fullDescription),
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: isMobile ? 13 : 15,
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: isMobile ? 20 : 25),

                        // التقنيات (شكل جديد)
                        Container(
                          height: isMobile ? 40 : 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            itemCount: project.technologies.take(4).length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(left: 8),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFF6A5ACD).withOpacity(0.2),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF6A5ACD),
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      project.technologies[index],
                                      style: TextStyle(
                                        color: Color(0xFF6A5ACD),
                                        fontSize: isMobile ? 10 : 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        Spacer(),

                        // الزر مع تأثير خاص
                        Container(
                          width: double.infinity,
                          height: isMobile ? 50 : 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [Color(0xFF6A5ACD), Color(0xFF9370DB)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF6A5ACD).withOpacity(0.4),
                                blurRadius: 20,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () =>
                                  _showProjectDetails(context, project),
                              borderRadius: BorderRadius.circular(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'استكشاف المشروع',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isMobile ? 14 : 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: isMobile ? 16 : 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // تأثير زاوية مميز
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(50),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6A5ACD).withOpacity(0.1),
                        Colors.transparent,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لوصف مختصر
  String _getShortDescription(String fullDescription) {
    if (fullDescription.length > 80) {
      return fullDescription.substring(0, 80) + '...';
    }
    return fullDescription;
  }

  void _showProjectDetails(BuildContext context, Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailsPage(project: project),
      ),
    );
  }
}
