import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:protfolio/progectmodale1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Project project;

  const ProjectDetailsPage({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage>
    with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isVideoLoading = false;
  bool _hasVideoError = false;

  late AnimationController _imageAnimationController;
  late Animation<double> _imageAnimation;

  @override
  void initState() {
    super.initState();

    // إعداد الفيديو
    if (widget.project.videoUrl != null &&
        widget.project.videoUrl!.isNotEmpty) {
      _initializeVideoPlayer();
    }

    // إعداد حركة الصورة
    _imageAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _imageAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _imageAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    if (widget.project.videoUrl != null &&
        widget.project.videoUrl!.isNotEmpty) {
      _videoController.dispose();
      _chewieController?.dispose();
    }
    _imageAnimationController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() {
    setState(() {
      _isVideoLoading = true;
      _hasVideoError = false;
    });

    final directUrl = _convertDriveLinkToDirect(widget.project.videoUrl!);

    _videoController = VideoPlayerController.network(directUrl)
      ..initialize()
          .then((_) {
            if (mounted) {
              setState(() {
                _chewieController = ChewieController(
                  videoPlayerController: _videoController,
                  autoPlay: false,
                  looping: false,
                  allowFullScreen: true,
                );
                _isVideoLoading = false;
              });
            }
          })
          .catchError((error) {
            if (mounted) {
              setState(() {
                _isVideoLoading = false;
                _hasVideoError = true;
              });
            }
          });
  }

  String _convertDriveLinkToDirect(String url) {
    final regExp = RegExp(r'd/([^/]+)/|id=([^&]+)');
    final match = regExp.firstMatch(url);
    if (match != null) {
      String? fileId = match.group(1) ?? match.group(2);
      if (fileId != null && fileId.isNotEmpty) {
        return "https://drive.google.com/uc?export=download&id=$fileId";
      }
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: CustomScrollView(
          slivers: [
            // الهيدر
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF6A5ACD).withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF6A5ACD)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              expandedHeight: isTablet ? 350 : 280,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
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
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _imageAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _imageAnimation.value),
                          child: Container(
                            width: isTablet ? 220 : 170,
                            height: isTablet ? 220 : 170,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF6A5ACD),
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF6A5ACD).withOpacity(0.3),
                                  blurRadius: 25,
                                  spreadRadius: 3,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                  offset: Offset(-4, -4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/photo_2025-06-24_03-06-59.jpg",
                                fit: BoxFit.fitHeight,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF6A5ACD),
                                          Color(0xFF9370DB),
                                        ],
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.work,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // المحتوى
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 30 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان والتصنيف
                    Container(
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.project.name,
                                  style: TextStyle(
                                    fontSize: isTablet ? 32 : 26,
                                    color: Color(0xFF6A5ACD),
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF6A5ACD).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Color(0xFF6A5ACD).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  widget.project.category,
                                  style: TextStyle(
                                    color: Color(0xFF6A5ACD),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // نبذة عن المشروع
                    _buildSection(
                      title: 'نبذة عن المشروع',
                      content: _buildDescriptionBox(
                        widget.project.fullDescription,
                        isTablet,
                      ),
                    ),

                    SizedBox(height: 30),

                    // التقنيات المستخدمة
                    _buildSection(
                      title: 'التقنيات المستخدمة',
                      content: _buildTechGrid(
                        widget.project.technologies,
                        isTablet,
                      ),
                    ),

                    SizedBox(height: 30),

                    // المميزات الرئيسية
                    if (widget.project.features.isNotEmpty)
                      _buildSection(
                        title: 'المميزات الرئيسية 🚀',
                        content: _buildFeaturesList(
                          widget.project.features,
                          isTablet,
                          icon: Icons.rocket_launch,
                          color: Color(0xFF6A5ACD),
                        ),
                      ),

                    SizedBox(height: 30),

                    // مميزات Supabase
                    if (widget.project.supabaseFeatures.isNotEmpty)
                      _buildSection(
                        title: 'مميزات Supabase ⚡',
                        content: _buildFeaturesList(
                          widget.project.supabaseFeatures,
                          isTablet,
                          icon: Icons.cloud,
                          color: Color(0xFF3ECF8E),
                        ),
                      ),

                    SizedBox(height: 30),

                    // مخطط قاعدة البيانات
                    if (widget.project.databaseSchema.isNotEmpty)
                      _buildSection(
                        title: 'مخطط قاعدة البيانات 🗄️',
                        content: _buildDatabaseSchema(
                          widget.project.databaseSchema,
                          isTablet,
                        ),
                      ),

                    SizedBox(height: 30),

                    // التحديات والحلول
                    if (widget.project.challenges.isNotEmpty &&
                        widget.project.solutions.isNotEmpty)
                      _buildChallengesSolutionsSection(
                        widget.project.challenges,
                        widget.project.solutions,
                        isTablet,
                      ),

                    SizedBox(height: 30),

                    // قسم الفيديو
                    if (widget.project.videoUrl != null &&
                        widget.project.videoUrl!.isNotEmpty)
                      _buildVideoSection(isTablet),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF6A5ACD),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        content,
      ],
    );
  }

  Widget _buildDescriptionBox(String text, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF666666),
          fontSize: isTablet ? 17 : 15,
          height: 1.6,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTechGrid(List<String> techs, bool isTablet) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: techs.map((tech) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFF6A5ACD).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.3)),
          ),
          child: Text(
            tech,
            style: TextStyle(
              color: Color(0xFF6A5ACD),
              fontWeight: FontWeight.w600,
              fontSize: isTablet ? 15 : 13,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeaturesList(
    List<String> features,
    bool isTablet, {
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: features.map((feature) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    feature,
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: isTablet ? 16 : 14,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDatabaseSchema(List<String> tables, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: tables.map((table) {
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF6A5ACD).withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.storage, color: Color(0xFF6A5ACD), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    table,
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: isTablet ? 15 : 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChallengesSolutionsSection(
    List<String> challenges,
    List<String> solutions,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التحديات والحلول 💡',
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF6A5ACD),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),

        // التحديات
        Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3CD),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xFFFFC107)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning, color: Color(0xFFFF9800)),
                  SizedBox(width: 8),
                  Text(
                    'التحديات',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFE65100),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                children: challenges.map((challenge) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_left,
                          color: Color(0xFFFF9800),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            challenge,
                            style: TextStyle(
                              color: Color(0xFFE65100),
                              fontSize: isTablet ? 15 : 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // الحلول
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E8),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xFF4CAF50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb, color: Color(0xFF4CAF50)),
                  SizedBox(width: 8),
                  Text(
                    'الحلول',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                children: solutions.map((solution) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF4CAF50),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            solution,
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontSize: isTablet ? 15 : 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoSection(bool isTablet) {
    return _buildSection(
      title: 'فيديو توضيحي للمشروع 🎥',
      content: Column(
        children: [
          if (_isVideoLoading)
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xFF6A5ACD)),
                    SizedBox(height: 15),
                    Text(
                      'جاري تحميل الفيديو...',
                      style: TextStyle(color: Color(0xFF666666)),
                    ),
                  ],
                ),
              ),
            )
          else if (_hasVideoError)
            GestureDetector(
              onTap: () async {
                final url = widget.project.videoUrl!;
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_filled,
                        size: 60,
                        color: Color(0xFF6A5ACD),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'اضغط لمشاهدة الفيديو',
                        style: TextStyle(
                          color: Color(0xFF6A5ACD),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (_chewieController != null)
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Chewie(controller: _chewieController!),
              ),
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProjectLinks() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'روابط المشروع 🔗',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF6A5ACD),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.code),
                  label: Text('عرض الكود على GitHub'),
                  onPressed: () => _launchURL(widget.project.projectUrl),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A5ACD),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
