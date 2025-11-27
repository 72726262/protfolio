import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protfolio/CreativeCard.dart';

import 'skills_page.dart';

import 'about_page.dart';
import 'projects_page.dart';
import 'contact_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // existing controller (used for lightning)
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // new controllers
  late AnimationController _staggerController; // for staggered entry
  late AnimationController _shimmerController; // for title glow

  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _showScrollTop = false;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
    // lightning controller (kept as before)
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

    // staggered entry animation
    _staggerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    // shimmer/glow moving across title
    _shimmerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    // scroll listener for parallax and floating button
    _scrollController.addListener(_onScroll);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // start stagger a bit after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _staggerController.forward();
    });
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

  // small helper for staggered animation values
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

    // parallax translation for the avatar container (subtle)
    final double parallax = (_scrollOffset * 0.18).clamp(-40.0, 40.0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF6F7FB),
        body: Listener(
          onPointerSignal: (pointerSignal) {
            if (pointerSignal is PointerScrollEvent) {
              // التعامل مع سكرول التاتش باد
              final offset = pointerSignal.scrollDelta.dy * 2; // زيادة الحساسية
              _scrollController.animateTo(
                _scrollController.offset + offset,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeOut,
              );
            }
          },
          child: Stack(
            children: [
              // background gradient (same as before)
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
                                        width: isTablet ? 350 : 170,
                                        height: isTablet ? 350 : 170,
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
                                              color: Colors.white,
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                              offset: Offset(-4, -4),
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
                                    /// ------------------ اسمك مع نيون + Pulse + Slide ------------------
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
                                          // خلفية نيون وبلور خفيف
                                          Text(
                                            'Akram Atiia Saad',
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
                                          // النص الرئيسي
                                          Text(
                                            'Akram Atiia Saad',
                                            style: TextStyle(
                                              fontSize: isTablet ? 38 : 32,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xFF6A5ACD),
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 16),

                                    /// ------------------ لقب مطور تطبيقات + Shimmer + Glow ------------------
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
                                                Colors.white.withOpacity(0.7),
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
                                              color: Color.fromARGB(
                                                255,
                                                102,
                                                86,
                                                206,
                                              ),
                                            ),
                                          ),
                                          // Glow ناعم جداً
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

                                    /// ------------------ وصف أنيق + Slide + Fade ------------------
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
                                          color: Color(0xFF5A5A5A),
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
                                Color.fromARGB(255, 88, 32, 245),
                                Colors.white,
                                Color.fromARGB(255, 13, 109, 187),
                              ],
                              [
                                Color(0xFF6A5ACD),
                                Colors.white,
                                Color(0xFF9370DB),
                              ],
                              [
                                Color.fromARGB(255, 85, 97, 199),
                                Colors.white,
                                Color.fromARGB(255, 58, 95, 196),
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

              // Scroll to top button - positioned in stack
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
                          child: Icon(Icons.arrow_upward),
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

  Widget _buildBottomScrollButton() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white, Color(0xFFF8F9FA)]),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: _scrollDown,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A5ACD), Color(0xFF9370DB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF6A5ACD).withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_downward, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  'اكتشف أعمالي',
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
    );
  }

  Widget _buildResponsiveGrid(bool isTablet) {
    final children = [
      _hoverableCard(
        CreativeCard(
          title: 'نبذة عني',
          icon: Icons.person,
          subtitle: 'تعرف علي أكثر',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            );
          },
        ),
      ),
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

  // Wrap any widget to give a hover-tilt + elevation on web/desktop.
  Widget _hoverableCard(Widget child) {
    if (!kIsWeb &&
        ![
          TargetPlatform.windows,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(Theme.of(context).platform)) {
      // mobile: no hover, just a small scale on tap (InkWell inside CreativeCard handles tap)
      return child;
    }

    return _HoverTiltWrapper(child: child);
  }
}

/// small Hover wrapper widget
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

/// Wave clipper used under the title
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

/// Lightning clipper (kept from original)
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
