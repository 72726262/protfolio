import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:protfolio/progectmodale1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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

                    SizedBox(height: 40),

                    // قسم الفيديو
                    if (widget.project.videoUrl != null &&
                        widget.project.videoUrl!.isNotEmpty)
                      _buildVideoSection(isTablet),

                    SizedBox(height: 50),
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

  Widget _buildVideoSection(bool isTablet) {
    return _buildSection(
      title: 'فيديو توضيحي للمشروع',
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
}
