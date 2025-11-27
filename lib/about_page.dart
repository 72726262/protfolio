import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: Stack(
          children: [
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

            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF6A5ACD),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            'نبذة عني',
                            style: TextStyle(
                              color: Color(0xFF6A5ACD),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      Center(
                        child: Container(
                          width: isTablet ? 250 : 150,
                          height: isTablet ? 250 : 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF6A5ACD),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF6A5ACD).withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 3,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/photo_2025-06-24_03-06-59.jpg",
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40),

                      Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مرحباً! 👋',
                              style: TextStyle(
                                fontSize: isTablet ? 28 : 24,
                                color: Color(0xFF6A5ACD),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'أنا مبرمج تطبيقات متخصص في تطوير حلول رقمية مبتكرة. '
                              'أعمل بشغف على تحويل الأفكار إلى واقع ملموس من خلال '
                              'التقنيات الحديثة والتصميم الإبداعي.',
                              style: TextStyle(
                                fontSize: isTablet ? 18 : 16,
                                color: Color(0xFF666666),
                                height: 1.6,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 25),
                            Text(
                              'المهارات الرئيسية:',
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 18,
                                color: Color(0xFF6A5ACD),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _buildSkillChip('Flutter'),
                                _buildSkillChip('Dart'),
                                _buildSkillChip('Firebase'),
                                _buildSkillChip('UI/UX Design'),
                                _buildSkillChip('Animation'),
                                _buildSkillChip('Backend'),
                                _buildSkillChip('API Integration'),
                                _buildSkillChip('State Management'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),

                      Text(
                        'التجربة والخبرة',
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 20,
                          color: Color(0xFF6A5ACD),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildExperienceItem(
                        'مطور Flutter رئيسي',
                        '2022 - الحاضر',
                        'تطوير تطبيقات mobile و web',
                      ),
                      _buildExperienceItem(
                        'مصمم واجهات مستخدم',
                        '2020 - 2022',
                        'تصميم تجارب مستخدم متميزة',
                      ),
                      _buildExperienceItem(
                        'مطور تطبيقات',
                        '2019 - 2020',
                        'بداية الرحلة في عالم البرمجة',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF6A5ACD).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.3)),
      ),
      child: Text(
        skill,
        style: TextStyle(color: Color(0xFF6A5ACD), fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildExperienceItem(String title, String period, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(top: 8, right: 15),
            decoration: BoxDecoration(
              color: Color(0xFF6A5ACD),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF6A5ACD),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  period,
                  style: TextStyle(color: Color(0xFF9370DB), fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
