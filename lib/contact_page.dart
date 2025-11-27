import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<ContactMethod> contactMethods = [
    ContactMethod(
      icon: Icons.email,
      title: 'البريد الإلكتروني',
      info: 'mohamed.dev@example.com',
      color: Color(0xFF6A5ACD),
      action: () => _launchEmail(),
    ),
    ContactMethod(
      icon: Icons.phone,
      title: 'الهاتف',
      info: '+20 123 456 7890',
      color: Color(0xFF9370DB),
      action: () => _launchPhone(),
    ),
    ContactMethod(
      icon: Icons.link,
      title: 'LinkedIn',
      info: 'linkedin.com/in/mohamed-dev',
      color: Color(0xFF6A5ACD),
      action: () => _launchLinkedIn(),
    ),
    ContactMethod(
      icon: Icons.code,
      title: 'GitHub',
      info: 'github.com/mohamed-dev',
      color: Color(0xFF9370DB),
      action: () => _launchGitHub(),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  static Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mohamed.dev@example.com',
      queryParameters: {'subject': 'تواصل من Portfolio App'},
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  static Future<void> _launchPhone() async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: '+201234567890');
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    }
  }

  static Future<void> _launchLinkedIn() async {
    final Uri linkedInUri = Uri.parse('https://linkedin.com/in/mohamed-dev');
    if (await canLaunchUrl(linkedInUri)) {
      await launchUrl(linkedInUri);
    }
  }

  static Future<void> _launchGitHub() async {
    final Uri githubUri = Uri.parse('https://github.com/mohamed-dev');
    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri);
    }
  }

  void _submitForm() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      _showDialog('تنبيه', 'يرجى ملء جميع الحقول المطلوبة');
      return;
    }

    // محاكاة إرسال الرسالة
    _showDialog('تم الإرسال', 'شكراً لتواصلك! سأرد عليك قريباً');

    // مسح الحقول
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF6A5ACD),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(content, style: TextStyle(color: Color(0xFF666666))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('حسناً', style: TextStyle(color: Color(0xFF6A5ACD))),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text) {
    // في التطبيق الحقيقي استخدم package:clipboard
    _showDialog('تم النسخ', 'تم نسخ $text إلى الحافظة');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                // الهيدر المميز
                SliverAppBar(
                  expandedHeight: isTablet ? 280 : 220,
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
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Transform.translate(
                      offset: Offset(0, (1 - _animation.value) * 20),
                      child: Opacity(
                        opacity: _animation.value,
                        child: Text(
                          'لنتواصل معاً',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 28 : 22,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(color: Color(0xFF6A5ACD), blurRadius: 20),
                            ],
                          ),
                        ),
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
                      child: Center(
                        child: Transform.scale(
                          scale: 0.9 + (_animation.value * 0.2),
                          child: Container(
                            width: isTablet ? 140 : 100,
                            height: isTablet ? 140 : 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF6A5ACD),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF6A5ACD).withOpacity(0.4),
                                  blurRadius: 25,
                                  spreadRadius: 3,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/photo_2025-06-24_03-06-59.jpg",
                                ),
                                fit: BoxFit.cover,
                                onError: (error, stackTrace) {
                                  // صورة بديلة إذا لم توجد الصورة
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // المحتوى الرئيسي
                SliverToBoxAdapter(
                  child: Opacity(
                    opacity: _animation.value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - _animation.value) * 30),
                      child: Padding(
                        padding: EdgeInsets.all(isTablet ? 25 : 20),
                        child: Column(
                          children: [
                            // النص الترحيبي
                            _buildWelcomeText(isTablet),
                            SizedBox(height: 30),

                            // طرق التواصل
                            _buildContactMethods(isTablet),
                            SizedBox(height: 40),

                            // نموذج التواصل
                            _buildContactForm(isTablet),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWelcomeText(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A5ACD).withOpacity(0.1),
            Color(0xFF9370DB).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Text(
            'لنبدأ مشروعك القادم! 🚀',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 26 : 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'أنا متاح دائمًا للحديث عن أفكارك الإبداعية ومشاريعك المستقبلية\nلنبني معاً شيئاً رائعاً!',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isTablet ? 16 : 14,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethods(bool isTablet) {
    return Column(
      children: [
        Text(
          'طرق التواصل المباشر',
          style: TextStyle(
            color: Colors.white,
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),

        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 2 : 1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: isTablet ? 3.5 : 3.2,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: contactMethods.length,
          itemBuilder: (context, index) {
            return _buildContactCard(contactMethods[index], isTablet);
          },
        ),
      ],
    );
  }

  Widget _buildContactCard(ContactMethod contact, bool isTablet) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * 20),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    contact.color.withOpacity(0.15),
                    contact.color.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: contact.color.withOpacity(0.25),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: contact.color.withOpacity(0.15),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: contact.action,
                  splashColor: contact.color.withOpacity(0.2),
                  highlightColor: contact.color.withOpacity(0.1),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                contact.color,
                                contact.color.withOpacity(0.7),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: contact.color.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            contact.icon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                contact.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 16 : 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                contact.info,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: isTablet ? 13 : 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_back_ios,
                          color: contact.color,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactForm(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A5ACD).withOpacity(0.1),
            Color(0xFF9370DB).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أرسل لي رسالة مباشرة',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 22 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),

          _buildFormField(
            controller: _nameController,
            label: 'الاسم الكامل',
            icon: Icons.person,
            isTablet: isTablet,
          ),
          SizedBox(height: 15),

          _buildFormField(
            controller: _emailController,
            label: 'البريد الإلكتروني',
            icon: Icons.email,
            isTablet: isTablet,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15),

          _buildFormField(
            controller: _messageController,
            label: 'رسالتك',
            icon: Icons.message,
            isTablet: isTablet,
            maxLines: 4,
          ),
          SizedBox(height: 25),

          // زر الإرسال
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A5ACD), Color(0xFF9370DB)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF6A5ACD).withOpacity(0.4),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _submitForm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'إرسال الرسالة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isTablet,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.2)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white, fontSize: isTablet ? 15 : 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Color(0xFF6A5ACD)),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        cursorColor: Color(0xFF6A5ACD),
      ),
    );
  }
}

class ContactMethod {
  final IconData icon;
  final String title;
  final String info;
  final Color color;
  final VoidCallback action;

  ContactMethod({
    required this.icon,
    required this.title,
    required this.info,
    required this.color,
    required this.action,
  });
}
