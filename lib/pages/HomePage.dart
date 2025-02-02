import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'RegistrationPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  late AnimationController _buttonController;
  late Animation<Offset> _buttonAnimation;
  late AnimationController _backgroundController;
  late Animation<Color?> _backgroundAnimation;
  late AnimationController _textController;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // Logo bounce animation
    _logoController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut,
      ),
    );

    // Text zoom animation
    _textController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOut,
      ),
    );

    // Button slide animation
    _buttonController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _buttonAnimation = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeOutBack,
      ),
    );

    // Background color animation
    _backgroundController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundAnimation = ColorTween(
      begin: Colors.brown[200],
      end: Colors.brown[300],
    ).animate(_backgroundController);

    // Start animations
    _logoController.forward();
    _textController.forward();
    _buttonController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _buttonController.dispose();
    _backgroundController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    // Calculate responsive sizes
    final double logoSize = screenWidth * (screenWidth > 600 ? 0.20 : 0.30);
    final double titleFontSize = screenWidth * (screenWidth > 600 ? 0.06 : 0.085);
    final double taglineFontSize = screenWidth * (screenWidth > 600 ? 0.035 : 0.055);
    final double buttonFontSize = screenWidth * (screenWidth > 600 ? 0.035 : 0.05);
    final double buttonPadding = screenWidth * (screenWidth > 600 ? 0.05 : 0.1);
    final double starSize = screenWidth * (screenWidth > 600 ? 0.03 : 0.05);

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedBuilder(
            animation: _backgroundAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _backgroundAnimation.value ?? Colors.brown[100]!,
                      Colors.brown[200]!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          // Curved Design with animation
          AnimatedBuilder(
            animation: _logoController,
            builder: (context, child) {
              return ClipPath(
                clipper: CustomWaveClipper(),
                child: Container(
                  height: screenHeight * (screenWidth > 600 ? 0.35 : 0.45),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.15),
                  // Animated Logo
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(seconds: 1),
                      builder: (context, double value, child) {
                        return Transform.rotate(
                          angle: value * 2 * 3.14,
                          child: Container(
                            width: logoSize,
                            height: logoSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.brown[50],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 10,
                                  blurRadius: 9,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: logoSize * 0.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  // Zoom-in animation for app name
                  ScaleTransition(
                    scale: _textAnimation,
                    child: Text(
                      'bondify',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[800],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.035),
                  // Animated Tagline with typewriter effect
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: taglineFontSize,
                      color: Colors.redAccent[400],
                      fontStyle: FontStyle.italic,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '"Connecting hearts, Creating bonds."',
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Animated Stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 1200 + (index * 200)),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: starSize + (index * starSize * 0.1),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // Animated Button
                  SlideTransition(
                    position: _buttonAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => RegistrationPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 800),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                            horizontal: buttonPadding,
                            vertical: screenHeight * 0.02,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [Colors.white, Colors.white70],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: Text(
                            'Get Started!!',
                            style: TextStyle(
                              fontSize: buttonFontSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 50);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(3 * size.width / 4, size.height - 100);
    var secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}