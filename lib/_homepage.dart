import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protfolio/CreativeCard.dart';
import 'skills_page.dart';
import 'projects_page.dart';
import 'contact_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _staggerController;
  late AnimationController _shimmerController;
  late AnimationController _galaxyController;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _showScrollTop = false;

  // بيانات المجرة
  final List<Star> _stars = [];
  final List<Planet> _planets = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // تهيئة المجرة
    _initializeGalaxy();

    FocusManager.instance.primaryFocus?.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.05),
      end: Offset(0, 0.05),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _staggerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    _galaxyController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();

    _scrollController.addListener(_onScroll);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _staggerController.forward();
    });
  }

  void _initializeGalaxy() {
    // إنشاء النجوم
    for (int i = 0; i < 150; i++) {
      _stars.add(
        Star(
          x: _random.nextDouble() * 400 - 200,
          y: _random.nextDouble() * 400 - 200,
          z: _random.nextDouble() * 1000,
          size: _random.nextDouble() * 2 + 0.5,
          speed: _random.nextDouble() * 0.5 + 0.1,
        ),
      );
    }

    // إنشاء الكواكب
    _planets.addAll([
      Planet(
        x: 0,
        y: 0,
        size: 40,
        color: Color(0xFF6A5ACD),
        speed: 0.01,
        orbitRadius: 0,
      ),
      Planet(
        x: 100,
        y: 0,
        size: 12,
        color: Color(0xFFFF6B6B),
        speed: 0.02,
        orbitRadius: 100,
      ),
      Planet(
        x: 180,
        y: 0,
        size: 16,
        color: Color(0xFF4ECDC4),
        speed: 0.015,
        orbitRadius: 180,
      ),
      Planet(
        x: 250,
        y: 0,
        size: 14,
        color: Color(0xFF45B7D1),
        speed: 0.012,
        orbitRadius: 250,
      ),
    ]);
  }

  void _onScroll() {
    final offset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;
    setState(() {
      _scrollOffset = offset;
      _showScrollTop = offset > 250;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _staggerController.dispose();
    _shimmerController.dispose();
    _galaxyController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Interval _staggerInterval(int index, {int items = 4}) {
    final start = (index * 0.08);
    final end = start + 0.45;
    return Interval(
      start.clamp(0.0, 1.0),
      end.clamp(0.0, 1.0),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final double parallax = (_scrollOffset * 0.18).clamp(-40.0, 40.0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: Listener(
          onPointerSignal: (pointerSignal) {
            if (pointerSignal is PointerScrollEvent) {
              final offset = pointerSignal.scrollDelta.dy * 2;
              _scrollController.animateTo(
                _scrollController.offset + offset,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeOut,
              );
            }
          },
          child: Stack(
            children: [
              // خلفية المجرة التفاعلية
              _buildInteractiveGalaxy(),

              // Main scrollable content
              SafeArea(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        // HERO ROW
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // left: avatar with parallax + slide/fade entry
                            Expanded(
                              flex: isTablet ? 4 : 5,
                              child: AnimatedBuilder(
                                animation: _staggerController,
                                builder: (context, child) {
                                  final anim = CurvedAnimation(
                                    parent: _staggerController,
                                    curve: _staggerInterval(0),
                                  );
                                  final opacity = anim.value;
                                  final slideY = (1 - anim.value) * 12;
                                  return Opacity(
                                    opacity: opacity,
                                    child: Transform.translate(
                                      offset: Offset(
                                        0,
                                        slideY + parallax * 0.3,
                                      ),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Center(
                                  child: SlideTransition(
                                    position: _slideAnimation,
                                    child: FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: Container(
                                        width: isTablet ? 350 : 200,
                                        height: isTablet ? 350 : 200,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xFF6A5ACD),
                                            width: 4,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(
                                                0xFF6A5ACD,
                                              ).withOpacity(0.3),
                                              blurRadius: 25,
                                              spreadRadius: 3,
                                              offset: Offset(4, 4),
                                            ),
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                              offset: Offset(-4, -4),
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/image/photo_2025-06-24_03-06-59.jpg",
                                            ),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // right: intro + CTA
                            Expanded(
                              flex: isTablet ? 6 : 7,
                              child: AnimatedBuilder(
                                animation: _staggerController,
                                builder: (context, child) {
                                  final anim = CurvedAnimation(
                                    parent: _staggerController,
                                    curve: _staggerInterval(1),
                                  );
                                  final opacity = anim.value;
                                  final slideX = (1 - anim.value) * 18;
                                  return Opacity(
                                    opacity: opacity,
                                    child: Transform.translate(
                                      offset: Offset(slideX, 0),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AnimatedBuilder(
                                      animation: _staggerController,
                                      builder: (context, child) {
                                        final anim = CurvedAnimation(
                                          parent: _staggerController,
                                          curve: Interval(
                                            0.0,
                                            0.4,
                                            curve: Curves.easeOut,
                                          ),
                                        );
                                        final opacity = anim.value;
                                        final slideY = (1 - anim.value) * 25;

                                        return Opacity(
                                          opacity: opacity,
                                          child: Transform.translate(
                                            offset: Offset(0, slideY),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            'Akram Atiia ',
                                            style: TextStyle(
                                              fontSize: isTablet ? 38 : 32,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.transparent,
                                              shadows: [
                                                Shadow(
                                                  color: Color(
                                                    0xFF6A5ACD,
                                                  ).withOpacity(0.7),
                                                  blurRadius: 22,
                                                ),
                                                Shadow(
                                                  color: Color(
                                                    0xFF9370DB,
                                                  ).withOpacity(0.4),
                                                  blurRadius: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Akram Atiia',
                                            style: TextStyle(
                                              fontSize: isTablet ? 38 : 32,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 16),

                                    AnimatedBuilder(
                                      animation: _shimmerController,
                                      builder: (context, child) {
                                        final shimmer =
                                            (_shimmerController.value * 2) -
                                            0.5;
                                        return ShaderMask(
                                          shaderCallback: (rect) {
                                            return LinearGradient(
                                              begin: Alignment(-1 + shimmer, 0),
                                              end: Alignment(1 + shimmer, 0),
                                              colors: [
                                                Colors.white.withOpacity(0.0),
                                                Color(
                                                  0xFF6A5ACD,
                                                ).withOpacity(0.7),
                                                Colors.white.withOpacity(0.0),
                                              ],
                                              stops: [0.0, 0.5, 1.0],
                                            ).createShader(rect);
                                          },
                                          blendMode: BlendMode.srcATop,
                                          child: child,
                                        );
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            'مطور تطبيقات',
                                            style: TextStyle(
                                              fontSize: isTablet ? 36 : 32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'مطور تطبيقات',
                                            style: TextStyle(
                                              fontSize: isTablet ? 36 : 32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.transparent,
                                              shadows: [
                                                Shadow(
                                                  color: Color(
                                                    0xFF6A5ACD,
                                                  ).withOpacity(0.6),
                                                  blurRadius: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 8),
                                    SizedBox(height: 20),

                                    AnimatedBuilder(
                                      animation: _staggerController,
                                      builder: (context, child) {
                                        final anim = CurvedAnimation(
                                          parent: _staggerController,
                                          curve: Interval(
                                            0.4,
                                            0.8,
                                            curve: Curves.easeOut,
                                          ),
                                        );
                                        final opacity = anim.value;
                                        final slideY = (1 - anim.value) * 15;

                                        return Opacity(
                                          opacity: opacity,
                                          child: Transform.translate(
                                            offset: Offset(0, slideY),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'أبتكر حلولاً رقمية فريدة لا تُنسى',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: isTablet ? 22 : 18,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: isTablet ? 30 : 20),

                        // animated lightning / colored strip
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            final colorIndex =
                                (_controller.value * 3).floor() % 3;
                            final colors = [
                              [
                                Color(0xFF6A5ACD),
                                Color(0xFF9370DB),
                                Color(0xFF6A5ACD),
                              ],
                              [
                                Color(0xFF6A5ACD),
                                Color(0xFF9370DB),
                                Color(0xFF6A5ACD),
                              ],
                              [
                                Color(0xFF6A5ACD),
                                Color(0xFF9370DB),
                                Color(0xFF6A5ACD),
                              ],
                            ];
                            return Stack(
                              children: [
                                ClipPath(
                                  clipper: _LightningClipper(_controller.value),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: colors[colorIndex],
                                        stops: [0.0, 0.5, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        SizedBox(height: isTablet ? 30 : 20),

                        // Responsive grid with hover/tilt effect
                        AnimatedBuilder(
                          animation: _staggerController,
                          builder: (context, child) {
                            final anim = CurvedAnimation(
                              parent: _staggerController,
                              curve: _staggerInterval(2),
                            );
                            return Opacity(
                              opacity: anim.value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - anim.value) * 12),
                                child: child,
                              ),
                            );
                          },
                          child: _buildResponsiveGrid(isTablet),
                        ),

                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              // Scroll to top button
              Positioned(
                bottom: 20,
                left: 20,
                child: AnimatedOpacity(
                  opacity: _showScrollTop ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: _showScrollTop
                      ? FloatingActionButton(
                          onPressed: _scrollToTop,
                          backgroundColor: Color(0xFF6A5ACD),
                          child: Icon(Icons.arrow_upward, color: Colors.white),
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractiveGalaxy() {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _galaxyController,
        builder: (context, child) {
          return CustomPaint(
            painter: GalaxyPainter(
              stars: _stars,
              planets: _planets,
              time: _galaxyController.value,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }

  Widget _buildResponsiveGrid(bool isTablet) {
    final children = [
      _hoverableCard(
        CreativeCard(
          title: 'مشاريعي',
          icon: Icons.work,
          subtitle: 'أعمالي المبدعة',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProjectsPage()),
            );
          },
        ),
      ),
      _hoverableCard(
        CreativeCard(
          title: 'مهاراتي',
          icon: Icons.stars,
          subtitle: 'قدراتي الخاصة',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SkillsPage()),
            );
          },
        ),
      ),
      _hoverableCard(
        CreativeCard(
          title: 'اتصل بي',
          icon: Icons.contact_page,
          subtitle: 'لعمل إبداعي',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactPage()),
            );
          },
        ),
      ),
    ];

    return GridView.count(
      crossAxisCount: isTablet ? 4 : 2,
      crossAxisSpacing: isTablet ? 25 : 20,
      mainAxisSpacing: isTablet ? 25 : 20,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: isTablet ? 0.9 : 1.0,
      children: children,
    );
  }

  Widget _hoverableCard(Widget child) {
    if (!kIsWeb &&
        ![
          TargetPlatform.windows,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(Theme.of(context).platform)) {
      return child;
    }

    return _HoverTiltWrapper(child: child);
  }
}

// نموذج النجم
class Star {
  final double x, y, z, size, speed;

  Star({
    required this.x,
    required this.y,
    required this.z,
    required this.size,
    required this.speed,
  });
}

// نموذج الكوكب
class Planet {
  double x, y;
  final double size;
  final Color color;
  final double speed;
  final double orbitRadius;

  Planet({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.speed,
    required this.orbitRadius,
  });
}

// رسام المجرة
class GalaxyPainter extends CustomPainter {
  final List<Star> stars;
  final List<Planet> planets;
  final double time;

  GalaxyPainter({
    required this.stars,
    required this.planets,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // رسم النجوم
    for (final star in stars) {
      final angle = time * star.speed * 2 * pi;
      final x = centerX + star.x * cos(angle);
      final y = centerY + star.y * sin(angle);

      final paint = Paint()
        ..color = Colors.white.withOpacity(0.8)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, star.size);

      canvas.drawCircle(Offset(x, y), star.size, paint);
    }

    // رسم الكواكب
    for (final planet in planets) {
      final angle = time * planet.speed * 2 * pi;
      final x = centerX + cos(angle) * planet.orbitRadius;
      final y = centerY + sin(angle) * planet.orbitRadius;

      // الكوكب الرئيسي
      final planetPaint = Paint()
        ..color = planet.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawCircle(Offset(x, y), planet.size, planetPaint);

      // هالة حول الكوكب
      final haloPaint = Paint()
        ..color = planet.color.withOpacity(0.3)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20);

      canvas.drawCircle(Offset(x, y), planet.size * 1.5, haloPaint);
    }

    // تأثيرات السدم
    final nebulaPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              Color(0xFF6A5ACD).withOpacity(0.1),
              Color(0xFF9370DB).withOpacity(0.05),
              Colors.transparent,
            ],
            stops: [0.0, 0.5, 1.0],
          ).createShader(
            Rect.fromCircle(
              center: Offset(centerX, centerY),
              radius: size.width / 2,
            ),
          );

    canvas.drawCircle(Offset(centerX, centerY), size.width / 2, nebulaPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// باقي الكلاسات كما هي...
class _HoverTiltWrapper extends StatefulWidget {
  final Widget child;
  const _HoverTiltWrapper({required this.child, Key? key}) : super(key: key);

  @override
  State<_HoverTiltWrapper> createState() => _HoverTiltWrapperState();
}

class _HoverTiltWrapperState extends State<_HoverTiltWrapper> {
  bool _hover = false;
  Offset _pos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() {
        _hover = false;
        _pos = Offset.zero;
      }),
      onHover: (e) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          setState(() {
            _pos = box.globalToLocal(e.position);
          });
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dx =
              (_pos.dx - constraints.maxWidth / 2) / (constraints.maxWidth / 2);
          final dy =
              (_pos.dy - constraints.maxHeight / 2) /
              (constraints.maxHeight / 2);
          final rotY = dx * 0.06;
          final rotX = -dy * 0.06;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(rotX)
            ..rotateY(rotY)
            ..scale(_hover ? 1.02 : 1.0);

          return AnimatedContainer(
            duration: Duration(milliseconds: 220),
            transform: transform,
            child: Material(
              color: Colors.transparent,
              elevation: _hover ? 14 : 6,
              borderRadius: BorderRadius.circular(14),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final waveHeight = size.height * 1.4;
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height - waveHeight * 0.6,
      size.width * 0.5,
      size.height - waveHeight * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - waveHeight * 0.2,
      size.width,
      size.height - waveHeight * 0.6,
    );
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class _LightningClipper extends CustomClipper<Path> {
  final double animationValue;

  _LightningClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.3);

    for (double i = 0; i <= 1.0; i += 0.05) {
      final x = size.width * i;
      final noise =
          sin(i * 15 + animationValue * 20) * cos(i * 8 + animationValue * 15);
      final y = size.height * 0.5 + noise * 15;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldDelegate) => true;
}
