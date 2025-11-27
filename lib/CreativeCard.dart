import 'package:flutter/material.dart';

class CreativeCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? primaryColor;
  final Color? secondaryColor;

  const CreativeCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.primaryColor,
    this.secondaryColor,
  }) : super(key: key);

  @override
  _CreativeCardState createState() => _CreativeCardState();
}

class _CreativeCardState extends State<CreativeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _glowAnimation;

  final Color _defaultPrimary = Color(0xFF6A5ACD);
  final Color _defaultSecondary = Color(0xFF9370DB);

  Color get primaryColor => widget.primaryColor ?? _defaultPrimary;
  Color get secondaryColor => widget.secondaryColor ?? _defaultSecondary;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );

    _elevationAnimation = Tween<double>(begin: 15.0, end: 30.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: primaryColor.withOpacity(0.1),
      end: primaryColor.withOpacity(0.2),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  void _onHoverEnter(PointerEvent details) {
    _animationController.forward();
  }

  void _onHoverExit(PointerEvent details) {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 800;

    return MouseRegion(
      onEnter: _onHoverEnter,
      onExit: _onHoverExit,
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              constraints: BoxConstraints(
                // ⬅️ إضافة constraints لتحديد الحجم
                minHeight: isTablet ? 160 : 140,
                maxHeight: isTablet ? 200 : 180,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, _colorAnimation.value!],
                ),
                boxShadow: [
                  // Shadow principal
                  BoxShadow(
                    color: primaryColor.withOpacity(
                      0.25 * _glowAnimation.value,
                    ),
                    blurRadius: _elevationAnimation.value,
                    spreadRadius: 2,
                    offset: Offset(6, 6),
                  ),
                  // Inner glow
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 15,
                    spreadRadius: -5,
                    offset: Offset(-5, -5),
                  ),
                  // Ambient shadow
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: primaryColor.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTapCancel: _onTapCancel,
                  borderRadius: BorderRadius.circular(25),
                  highlightColor: primaryColor.withOpacity(0.1),
                  splashColor: primaryColor.withOpacity(0.2),
                  child: Stack(
                    children: [
                      // Background pattern effect
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: RadialGradient(
                              center: Alignment.topRight,
                              radius: 1.5,
                              colors: [
                                primaryColor.withOpacity(
                                  0.03 * _glowAnimation.value,
                                ),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Corner accent
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(40),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                primaryColor.withOpacity(
                                  0.1 * _glowAnimation.value,
                                ),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Main content
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(isTablet ? 25.0 : 20.0),
                          constraints: BoxConstraints(
                            minHeight: isTablet ? 160 : 140,
                            maxHeight: isTablet
                                ? 200
                                : 180, // ⬅️ منع التمدد الزائد
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon container with enhanced design
                              Container(
                                padding: EdgeInsets.all(isTablet ? 16 : 14),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [primaryColor, secondaryColor],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(
                                        0.4 * _glowAnimation.value,
                                      ),
                                      blurRadius: 15,
                                      offset: Offset(3, 3),
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: Offset(-3, -3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  widget.icon,
                                  size: isTablet ? 32 : 28,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: isTablet ? 16 : 12),

                              // Title with better typography
                              Text(
                                widget.title,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: isTablet ? 18 : 16,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                  letterSpacing: -0.5,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: isTablet ? 8 : 6),

                              // Subtitle with improved styling
                              Text(
                                widget.subtitle,
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: isTablet ? 15 : 13,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
