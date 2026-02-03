import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../layout/responsive_layout.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  double _scrollOpacity = 0.0;

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final double metrics = notification.metrics.pixels;
      final double newOpacity = (metrics / 100).clamp(0.0, 1.0);
      if (newOpacity != _scrollOpacity) {
        setState(() {
          _scrollOpacity = newOpacity;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _Header(scrollOpacity: _scrollOpacity),
      ),
      drawer: ResponsiveLayout.isMobile(context) ? _MobileDrawer() : null,
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: widget.child,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final double scrollOpacity;

  const _Header({required this.scrollOpacity});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final String location = GoRouterState.of(context).matchedLocation;
    
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 1200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.4 + (scrollOpacity * 0.45)),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08 + (scrollOpacity * 0.04)),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(context, scrollOpacity),
                    if (!isMobile)
                      Row(
                        children: [
                          _PremiumNavLink(text: 'HOME', path: '/', isActive: location == '/'),
                          _PremiumNavLink(text: 'PROJECTS', path: '/projects', isActive: location.startsWith('/projects')),
                          _PremiumNavLink(text: 'BLOG', path: '/blog', isActive: location.startsWith('/blog')),
                          _PremiumNavLink(text: 'RESUME', path: '/resume', isActive: location == '/resume'),
                        ],
                      )
                    else
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu_rounded, color: AppColors.gold, size: 28),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context, double scrollOpacity) {
    return GestureDetector(
      onTap: () => context.go('/'),
      child: Hero(
        tag: 'logo',
        child: Row(
          children: [
            Container(
              width: 8,
              height: 24,
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withOpacity(0.3 * scrollOpacity),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ShaderMask(
              shaderCallback: (bounds) => AppColors.goldGradient.createShader(bounds),
              child: const Text(
                'MOSTAFA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumNavLink extends StatefulWidget {
  final String text;
  final String path;
  final bool isActive;

  const _PremiumNavLink({required this.text, required this.path, required this.isActive});

  @override
  State<_PremiumNavLink> createState() => _PremiumNavLinkState();
}

class _PremiumNavLinkState extends State<_PremiumNavLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextButton(
          onPressed: () => context.go(widget.path),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.isActive 
                      ? AppColors.gold 
                      : (_isHovering ? Colors.white : Colors.white.withOpacity(0.6)),
                  fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                height: 2,
                width: widget.isActive || _isHovering ? 20 : 0,
                color: AppColors.gold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.bgDark,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
            ),
            child: const Center(
              child: Text('MOSTAFA', 
                style: TextStyle(color: AppColors.gold, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 4)),
            ),
          ),
          _DrawerTile(text: 'HOME', path: '/', icon: Icons.home_rounded),
          _DrawerTile(text: 'PROJECTS', path: '/projects', icon: Icons.grid_view_rounded),
          _DrawerTile(text: 'RESUME', path: '/resume', icon: Icons.description_rounded),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text('© 2026 Mostafa Portfolio', 
              style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String text;
  final String path;
  final IconData icon;

  const _DrawerTile({required this.text, required this.path, required this.icon});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isActive = location == path || (path != '/' && location.startsWith(path));

    return ListTile(
      leading: Icon(icon, color: isActive ? AppColors.gold : Colors.white24),
      title: Text(text, 
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white60,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          letterSpacing: 1,
        )),
      selected: isActive,
      onTap: () {
        context.go(path);
        Navigator.pop(context);
      },
    );
  }
}
