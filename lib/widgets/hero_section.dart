import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));
    
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;
    final isTablet = screenSize.width > 768;

    return Container(
      height: screenSize.height * 0.75,
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80 : (isTablet ? 48 : 24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Image.network(
                    'https://www.amtronics.co/amtronics-logo.webp',
                    height: isDesktop ? 120 : (isTablet ? 100 : 80),
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: isDesktop ? 120 : (isTablet ? 100 : 80),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'AM TRONICS',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: isDesktop ? 32 : 24,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                Text(
                  'Innovation & Technology Solutions',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'AMtronics where ideas become reality',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _ProfessionalCTAButton(
                      text: 'Submit Report',
                      isPrimary: true,
                      icon: Icons.assignment_outlined,
                      onPressed: () => _launchURL(
                        'https://docs.google.com/forms/d/e/1FAIpQLSclwHXiXmHketd7EvWNKBLKwnDKu3581WyIbbVbtjURg_HJ-Q/viewform?usp=header'
                      ),
                    ),
                    _ProfessionalCTAButton(
                      text: 'Submit Prototype',
                      isPrimary: false,
                      icon: Icons.science_outlined,
                      onPressed: () => _launchURL(
                        'https://docs.google.com/forms/d/e/1FAIpQLSd67PZ7WO-paPGat9f-Uw5RrhC6AkGLuD3cp-CcznES_mW2tg/viewform?usp=header'
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ProfessionalCTAButton extends StatefulWidget {
  final String text;
  final bool isPrimary;
  final IconData icon;
  final VoidCallback onPressed;

  const _ProfessionalCTAButton({
    required this.text,
    required this.isPrimary,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_ProfessionalCTAButton> createState() => _ProfessionalCTAButtonState();
}

class _ProfessionalCTAButtonState extends State<_ProfessionalCTAButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _elevationAnimation = Tween<double>(
      begin: 2.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _elevationAnimation,
        builder: (context, child) {
          return Semantics(
            button: true,
            label: widget.text,
            child: SizedBox(
              width: 280,
              height: 64,
              child: widget.isPrimary
                  ? ElevatedButton.icon(
                      onPressed: widget.onPressed,
                      icon: Icon(widget.icon, size: 20),
                      label: Text(widget.text),
                      style: ElevatedButton.styleFrom(
                        elevation: _elevationAnimation.value,
                        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                      ),
                    )
                  : OutlinedButton.icon(
                      onPressed: widget.onPressed,
                      icon: Icon(widget.icon, size: 20),
                      label: Text(widget.text),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: _isHovered 
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.05)
                          : Colors.transparent,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
