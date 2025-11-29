import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<ContactMethod> contactMethods = [
    ContactMethod(
      icon: Icons.phone,
      title: 'الواتساب',
      info: '+20 1154045964',
      color: Color(0xFF25D366),
      action: () => _launchWhatsApp(),
    ),
    ContactMethod(
      icon: Icons.email,
      title: 'البريد الإلكتروني',
      info: 'akramatiia@gmail.com',
      color: Color(0xFFEA4335),
      action: () => _launchEmail(),
    ),
    ContactMethod(
      icon: Icons.phone,
      title: 'مكالمة هاتفية',
      info: '01154045964',
      color: Color(0xFF34A853),
      action: () => _launchPhone(),
    ),
    ContactMethod(
      icon: Icons.link,
      title: 'LinkedIn',
      info: 'www.linkedin.com/in/akram-atiia-2ba2a335b',
      color: Color(0xFF0077B5),
      action: () => _launchLinkedIn(),
    ),
    ContactMethod(
      icon: Icons.code,
      title: 'GitHub',
      info: 'github.com/mohamed-dev',
      color: Color(0xFF333333),
      action: () => _launchGitHub(),
    ),
    ContactMethod(
      icon: Icons.description,
      title: 'السيرة الذاتية',
      info: 'تحميل CV PDF',
      color: Color(0xFF6A5ACD),
      action: () => _downloadCV(),
    ),
  ];

  static Future<void> _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/201154045964?text=مرحباً%20أرغب%20في%20التواصل%20معك%20بخصوص%20فرصة%20عمل',
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    }
  }

  static Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'akramatiia@gmail.com',
      queryParameters: {
        'subject': 'طلب تواصل - مبرمج Flutter متخصص',
        'body': 'مرحباً،\n\nأرغب في التواصل معكم بخصوص فرصة عمل...',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  static Future<void> _launchPhone() async {
    final Uri phoneUri = Uri.parse('tel:01154045964');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  static Future<void> _launchLinkedIn() async {
    final Uri linkedInUri = Uri.parse(
      'https://linkedin.com/in/akram-atiia-2ba2a335b',
    );
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

  static Future<void> _downloadCV() async {
    final Uri cvUri = Uri.parse('https://drive.google.com/your-cv-link');
    if (await canLaunchUrl(cvUri)) {
      await launchUrl(cvUri);
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
    _showDialog('تم الإرسال', 'شكراً لتواصلك! سأرد عليك في أقرب وقت ممكن');

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            // الهيدر
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
                  'لنعمل معاً! 👨‍💻',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF6A5ACD).withOpacity(0.3),
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
                    // النص الترحيبي
                    _buildWelcomeText(isTablet),
                    SizedBox(height: 20),

                    // طرق التواصل
                    _buildContactMethods(isTablet),
                    SizedBox(height: 20),

                    // نموذج التواصل
                    _buildContactForm(isTablet),
                  ],
                ),
              ),
            ),
          ],
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
            Color(0xFF6A5ACD).withOpacity(0.15),
            Color(0xFF9370DB).withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Text(
            'مستعد للانضمام إلى فريقكم المتميز! 💼',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 20 : 18,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'مطور Flutter متخصص مع خبرة في:\n'
            '• تطوير تطبيقات Mobile و Desktop\n'
            '• قواعد البيانات (SQL Server, Firebase, Supabase)\n'
            '• واجهات برمجية APIs وتكامل الأنظمة\n'
            '• 26+ كورس متقدم في البرمجة والهندسة\n\n'
            'جاهز للمقابلات الفورية والتحديات التقنية! 🚀',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isTablet ? 14 : 12,
              height: 1.5,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethods(bool isTablet) {
    return Column(
      children: [
        Text(
          'طرق التواصل المباشر - جاهز للإجابة فوراً 📞',
          style: TextStyle(
            color: Colors.white,
            fontSize: isTablet ? 18 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),

        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 2 : 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: isTablet ? 3.2 : 3.0,
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            contact.color.withOpacity(0.15),
            contact.color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: contact.color.withOpacity(0.25), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: contact.action,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [contact.color, contact.color.withOpacity(0.7)],
                    ),
                  ),
                  child: Icon(contact.icon, color: Colors.white, size: 16),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        contact.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 14 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        contact.info,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isTablet ? 11 : 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_back_ios, color: contact.color, size: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A5ACD).withOpacity(0.1),
            Color(0xFF9370DB).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أرسل لي عرض العمل مباشرة 📩',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 18 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          _buildFormField(
            controller: _nameController,
            label: 'الاسم الكامل',
            icon: Icons.person,
            isTablet: isTablet,
          ),
          SizedBox(height: 12),

          _buildFormField(
            controller: _emailController,
            label: 'البريد الإلكتروني',
            icon: Icons.email,
            isTablet: isTablet,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 12),

          _buildFormField(
            controller: _messageController,
            label: 'تفاصيل العرض / الوظيفة',
            icon: Icons.work,
            isTablet: isTablet,
            maxLines: 4,
          ),
          SizedBox(height: 20),

          // زر الإرسال
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A5ACD), Color(0xFF9370DB)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _submitForm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'إرسال العرض',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
        style: TextStyle(color: Colors.white, fontSize: isTablet ? 14 : 13),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(14),
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
