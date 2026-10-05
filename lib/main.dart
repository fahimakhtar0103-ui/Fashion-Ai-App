import 'package:flutter/material.dart';

import 'update_gate.dart';

void main() {
  runApp(const FashionAiApp());
}

class FashionAiApp extends StatelessWidget {
  const FashionAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion AI',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          surface: AppColors.surface,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 34,
            height: 1.05,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.1,
            color: AppColors.ink,
          ),
          headlineMedium: TextStyle(
            fontSize: 27,
            height: 1.08,
            fontWeight: FontWeight.w800,
            letterSpacing: -.7,
            color: AppColors.ink,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -.3,
            color: AppColors.ink,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.4,
            color: AppColors.ink,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: AppColors.muted,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            height: 1.35,
            color: AppColors.muted,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: AppColors.muted),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppColors.line),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.4,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          side: const BorderSide(color: AppColors.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          selectedColor: AppColors.primarySoft,
          backgroundColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      home: const UpdateGate(child: AppShell()),
    );
  }
}

class AppColors {
  static const canvas = Color(0xFFF7F7FA);
  static const surface = Color(0xFFFFFFFF);
  static const ink = Color(0xFF15121B);
  static const muted = Color(0xFF77717F);
  static const line = Color(0xFFEAE7EF);
  static const primary = Color(0xFF6D38D5);
  static const primaryDeep = Color(0xFF3A176E);
  static const primarySoft = Color(0xFFF0E8FF);
  static const pink = Color(0xFFFF5D92);
  static const teal = Color(0xFF32B9A2);
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  void goTo(int value) => setState(() => index = value);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onNavigate: goTo),
      const CreateReelScreen(),
      const TemplatesScreen(),
      const LibraryScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: index, children: pages),
      ),
      bottomNavigationBar: _PremiumBottomNav(
        index: index,
        onSelected: goTo,
      ),
    );
  }
}

class _PremiumBottomNav extends StatelessWidget {
  const _PremiumBottomNav({
    required this.index,
    required this.onSelected,
  });

  final int index;
  final ValueChanged<int> onSelected;

  static const items = [
    (Icons.home_rounded, Icons.home_outlined, 'Home'),
    (Icons.add_box_rounded, Icons.add_box_outlined, 'Create'),
    (Icons.auto_awesome_mosaic_rounded,
        Icons.auto_awesome_mosaic_outlined, 'Templates'),
    (Icons.video_library_rounded, Icons.video_library_outlined, 'Library'),
    (Icons.tune_rounded, Icons.tune_outlined, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(14, 0, 14, 10),
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF18131F),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 28,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: _NavItem(
                  selected: index == i,
                  selectedIcon: items[i].$1,
                  icon: items[i].$2,
                  label: items[i].$3,
                  onTap: () => onSelected(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.selected,
    required this.selectedIcon,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final IconData selectedIcon;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 2),
        decoration: BoxDecoration(
          color: selected ? Colors.white.withOpacity(.11) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              size: 22,
              color: selected ? Colors.white : Colors.white54,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white54,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                fontSize: 9.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 110),
      children: [
        _TopBar(
          eyebrow: 'FASHION AI STUDIO',
          title: 'Create. Style. Sell.',
          trailing: _AvatarButton(onTap: () => onNavigate(4)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 2, 18, 0),
          child: _HeroStudioCard(
            onCreate: () => onNavigate(1),
            onTemplates: () => onNavigate(2),
          ),
        ),
        const SizedBox(height: 22),
        const _SectionHeader(
          title: 'Quick start',
          subtitle: 'From garment photo to social-ready content',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.add_photo_alternate_outlined,
                  title: 'New reel',
                  subtitle: 'Upload product',
                  accent: AppColors.primary,
                  onTap: () => onNavigate(1),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.auto_awesome_outlined,
                  title: 'Templates',
                  subtitle: '20+ styles',
                  accent: AppColors.pink,
                  onTap: () => onNavigate(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.video_collection_outlined,
                  title: 'Library',
                  subtitle: 'Your exports',
                  accent: AppColors.teal,
                  onTap: () => onNavigate(3),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeader(
          title: 'Popular templates',
          subtitle: 'Designed for fashion sellers',
          action: 'See all',
          onAction: () => onNavigate(2),
        ),
        SizedBox(
          height: 208,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            scrollDirection: Axis.horizontal,
            children: const [
              _HomeTemplateCard(
                title: 'Editorial',
                subtitle: 'Clean luxury',
                icon: Icons.auto_awesome,
                colors: [Color(0xFF231634), Color(0xFF7247A8)],
              ),
              _HomeTemplateCard(
                title: 'Bridal',
                subtitle: 'Rich & royal',
                icon: Icons.diamond_outlined,
                colors: [Color(0xFF6D1837), Color(0xFFD75E77)],
              ),
              _HomeTemplateCard(
                title: 'Runway',
                subtitle: 'Walk motion',
                icon: Icons.directions_walk,
                colors: [Color(0xFF16353B), Color(0xFF4FAF9E)],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeader(
          title: 'Recent projects',
          subtitle: 'Pick up where you left off',
          action: 'Library',
          onAction: () => onNavigate(3),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              _ProjectRow(
                title: 'Wine Silk Saree',
                template: 'Premium Cinematic',
                status: 'Ready',
                progress: 1,
                accent: Color(0xFF8B335E),
              ),
              SizedBox(height: 10),
              _ProjectRow(
                title: 'Royal Bridal Lehenga',
                template: 'Bridal Luxury',
                status: 'Draft',
                progress: .35,
                accent: Color(0xFFC47A3A),
              ),
              SizedBox(height: 10),
              _ProjectRow(
                title: 'Festive Kurti',
                template: 'Festive Glow',
                status: 'Generating',
                progress: .68,
                accent: Color(0xFF427D72),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 18, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 5),
                  Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFEEE5FF), Color(0xFFFFE5EE)],
          ),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: const Icon(Icons.person_outline_rounded, color: AppColors.ink),
      ),
    );
  }
}

class _HeroStudioCard extends StatelessWidget {
  const _HeroStudioCard({
    required this.onCreate,
    required this.onTemplates,
  });

  final VoidCallback onCreate;
  final VoidCallback onTemplates;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 255),
      padding: const EdgeInsets.fromLTRB(22, 24, 14, 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1D1328),
            Color(0xFF4B2470),
            Color(0xFF7A44BF),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2A4C2473),
            blurRadius: 30,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -55,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.07),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.11),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: Colors.white.withOpacity(.13),
                          ),
                        ),
                        child: const Text(
                          'AI FASHION CONTENT',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Your product.\nYour model.\nYour reel.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          height: 1.02,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -.6,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Create fashion content without a full photoshoot.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 17),
                      Row(
                        children: [
                          FilledButton.icon(
                            onPressed: onCreate,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 46),
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primaryDeep,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            ),
                            icon: const Icon(Icons.auto_awesome, size: 18),
                            label: const Text('Create reel'),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: onTemplates,
                            style: IconButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white.withOpacity(.11),
                              minimumSize: const Size(46, 46),
                            ),
                            icon: const Icon(Icons.grid_view_rounded, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 112,
                child: _ReelPhoneMockup(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReelPhoneMockup extends StatelessWidget {
  const _ReelPhoneMockup();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: .035,
      child: Container(
        height: 210,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: Colors.white24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4A000000),
              blurRadius: 22,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF4D8D0),
                      Color(0xFF9B5A78),
                      Color(0xFF281A2B),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 18,
                left: 19,
                right: 19,
                child: Container(
                  height: 114,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.15),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Icon(
                    Icons.checkroom_rounded,
                    color: Colors.white,
                    size: 66,
                  ),
                ),
              ),
              const Positioned(
                bottom: 21,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NEW DROP',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 7,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Wine Silk\nCollection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.05,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    this.action,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 14, 11),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          if (action != null)
            TextButton(
              onPressed: onAction,
              child: Text(
                action!,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        height: 122,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: accent.withOpacity(.11),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: accent, size: 20),
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTemplateCard extends StatelessWidget {
  const _HomeTemplateCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146,
      margin: const EdgeInsets.only(right: 11),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            top: 18,
            child: Icon(icon, size: 95, color: Colors.white.withOpacity(.10)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _MiniPill('POPULAR'),
              const Spacer(),
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  const _MiniPill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 8,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  const _ProjectRow({
    required this.title,
    required this.template,
    required this.status,
    required this.progress,
    required this.accent,
  });

  final String title;
  final String template;
  final String status;
  final double progress;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final isReady = status == 'Ready';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 72,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent.withOpacity(.58), accent],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.checkroom, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  template,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 4,
                    backgroundColor: AppColors.line,
                    valueColor: AlwaysStoppedAnimation<Color>(accent),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(
              color: isReady
                  ? const Color(0xFFE8F7EF)
                  : AppColors.primarySoft,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isReady ? const Color(0xFF287B4D) : AppColors.primary,
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateReelScreen extends StatefulWidget {
  const CreateReelScreen({super.key});

  @override
  State<CreateReelScreen> createState() => _CreateReelScreenState();
}

class _CreateReelScreenState extends State<CreateReelScreen> {
  String category = 'Saree';
  String quality = 'Standard';
  String template = 'Editorial Clean';
  String motion = 'Walk + turn';
  bool hasPhotos = false;

  final templates = const [
    ('Editorial Clean', Icons.auto_awesome_outlined,
        [Color(0xFF342044), Color(0xFF8B65AF)]),
    ('Bridal Luxury', Icons.diamond_outlined,
        [Color(0xFF7D2342), Color(0xFFDB6A84)]),
    ('Runway Walk', Icons.directions_walk,
        [Color(0xFF15515A), Color(0xFF55B3A1)]),
    ('Festive Glow', Icons.celebration_outlined,
        [Color(0xFF9A5C16), Color(0xFFE3B556)]),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 120),
      children: [
        const _TopBar(
          eyebrow: 'NEW PROJECT',
          title: 'Create a reel',
          subtitle: 'Add your garment, choose a look, export.',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: _StepStrip(),
        ),
        const SizedBox(height: 20),
        const _SectionHeader(
          title: '1. Product photos',
          subtitle: 'Front, back and detail views give better results',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: InkWell(
            onTap: () => setState(() => hasPhotos = !hasPhotos),
            borderRadius: BorderRadius.circular(28),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              height: 210,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: hasPhotos
                    ? const LinearGradient(
                        colors: [Color(0xFFF4ECFF), Color(0xFFFFF4F8)],
                      )
                    : null,
                color: hasPhotos ? null : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: hasPhotos ? AppColors.primary : AppColors.line,
                  width: hasPhotos ? 1.4 : 1,
                ),
              ),
              child: hasPhotos
                  ? const Row(
                      children: [
                        Expanded(
                          child: _PhotoSlot(
                            label: 'Front',
                            icon: Icons.checkroom,
                            filled: true,
                          ),
                        ),
                        SizedBox(width: 9),
                        Expanded(
                          child: _PhotoSlot(
                            label: 'Back',
                            icon: Icons.rotate_left,
                            filled: true,
                          ),
                        ),
                        SizedBox(width: 9),
                        Expanded(
                          child: _PhotoSlot(
                            label: 'Detail',
                            icon: Icons.center_focus_strong,
                            filled: true,
                          ),
                        ),
                      ],
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _UploadOrb(),
                        SizedBox(height: 14),
                        Text(
                          'Tap to add product photos',
                          style: TextStyle(
                            color: AppColors.ink,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'JPG / PNG • Front, back, details',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: '2. Garment type',
          subtitle: 'Helps AI keep styling and motion appropriate',
        ),
        _ChoiceScroller(
          values: const ['Saree', 'Lehenga', 'Kurti', 'Suit', 'Gown', 'Other'],
          selected: category,
          onSelected: (value) => setState(() => category = value),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: '3. Choose a look',
          subtitle: 'You can change this before final generation',
        ),
        SizedBox(
          height: 156,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            scrollDirection: Axis.horizontal,
            itemCount: templates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) {
              final item = templates[i];
              final selected = template == item.$1;
              return InkWell(
                onTap: () => setState(() => template = item.$1),
                borderRadius: BorderRadius.circular(22),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 132,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: item.$3),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: selected ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: selected
                        ? const [
                            BoxShadow(
                              color: Color(0x284C2473),
                              blurRadius: 18,
                              offset: Offset(0, 8),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(item.$2, color: Colors.white, size: 22),
                          const Spacer(),
                          if (selected)
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        item.$1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Preview style',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: '4. Motion',
          subtitle: 'How the model should present the garment',
        ),
        _ChoiceScroller(
          values: const [
            'Walk + turn',
            'Front pose',
            'Slow spin',
            'Detail focus',
            'Pallu flow'
          ],
          selected: motion,
          onSelected: (value) => setState(() => motion = value),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: '5. Export quality',
          subtitle: 'Higher quality can use more generation credits',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Expanded(
                child: _QualityCard(
                  title: 'Draft',
                  subtitle: 'Fast preview',
                  selected: quality == 'Draft',
                  onTap: () => setState(() => quality = 'Draft'),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _QualityCard(
                  title: 'Standard',
                  subtitle: '720p',
                  badge: 'BEST',
                  selected: quality == 'Standard',
                  onTap: () => setState(() => quality = 'Standard'),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _QualityCard(
                  title: 'Premium',
                  subtitle: '1080p',
                  selected: quality == 'Premium',
                  onTap: () => setState(() => quality = 'Premium'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: 'Product details',
          subtitle: 'Optional details for text overlays and captions',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Product name / SKU',
                  prefixIcon: Icon(Icons.sell_outlined),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Price',
                        prefixIcon: Icon(Icons.currency_rupee),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Collection',
                        prefixIcon: Icon(Icons.collections_bookmark_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'CTA / note',
                  hintText: 'DM for availability, Visit store...',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, Color(0xFF9D5CE8)],
              ),
              borderRadius: BorderRadius.circular(21),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x296D38D5),
                  blurRadius: 20,
                  offset: Offset(0, 9),
                ),
              ],
            ),
            child: FilledButton.icon(
              onPressed: () => _demoMessage(
                context,
                'Frontend ready. AI generation will connect in the API phase.',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Generate preview'),
            ),
          ),
        ),
      ],
    );
  }
}

class _StepStrip extends StatelessWidget {
  const _StepStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: const Row(
        children: [
          _StepDot(number: '1', label: 'Photos', active: true),
          _StepLine(),
          _StepDot(number: '2', label: 'Style'),
          _StepLine(),
          _StepDot(number: '3', label: 'Export'),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.number,
    required this.label,
    this.active = false,
  });

  final String number;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.primarySoft,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: TextStyle(
              color: active ? Colors.white : AppColors.primary,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: active ? AppColors.ink : AppColors.muted,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: Divider(height: 1, color: AppColors.line),
      ),
    );
  }
}

class _UploadOrb extends StatelessWidget {
  const _UploadOrb();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF9D5CE8)],
        ),
        borderRadius: BorderRadius.circular(19),
        boxShadow: const [
          BoxShadow(
            color: Color(0x286D38D5),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: const Icon(
        Icons.add_photo_alternate_outlined,
        color: Colors.white,
        size: 27,
      ),
    );
  }
}

class _PhotoSlot extends StatelessWidget {
  const _PhotoSlot({
    required this.label,
    required this.icon,
    this.filled = false,
  });

  final String label;
  final IconData icon;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: filled
            ? const LinearGradient(
                colors: [Color(0xFF7B4CA8), Color(0xFFCF86AA)],
              )
            : null,
        color: filled ? null : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              icon,
              color: filled ? Colors.white : AppColors.primary,
              size: 34,
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 9,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.19),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChoiceScroller extends StatelessWidget {
  const _ChoiceScroller({
    required this.values,
    required this.selected,
    required this.onSelected,
  });

  final List<String> values;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 7),
        itemBuilder: (_, i) {
          final value = values[i];
          final isSelected = value == selected;
          return ChoiceChip(
            label: Text(value),
            selected: isSelected,
            avatar: isSelected
                ? const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: AppColors.primary,
                  )
                : null,
            onSelected: (_) => onSelected(value),
          );
        },
      ),
    );
  }
}

class _QualityCard extends StatelessWidget {
  const _QualityCard({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primarySoft : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.line,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (badge != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                const Spacer(),
                if (selected)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: 17,
                  ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  String query = '';
  String filter = 'All';
  final Set<String> favourites = {'Editorial Clean', 'Bridal Luxury'};

  static const templates = [
    _TemplateInfo('Editorial Clean', 'Magazine-style minimal fashion',
        'Premium', Icons.auto_awesome_outlined,
        [Color(0xFF2A1A38), Color(0xFF9368AE)]),
    _TemplateInfo('Bridal Luxury', 'Rich bridal presentation', 'Premium',
        Icons.diamond_outlined, [Color(0xFF741B3A), Color(0xFFDD718A)]),
    _TemplateInfo('Runway Walk', 'Model walking presentation', 'Premium',
        Icons.directions_walk, [Color(0xFF144A54), Color(0xFF5AAE9E)]),
    _TemplateInfo('Festive Glow', 'Bright festive movement', 'Festive',
        Icons.celebration_outlined, [Color(0xFF8D4F12), Color(0xFFE7B65B)]),
    _TemplateInfo('3-Angle Short', 'Front, turn and detail', 'Catalogue',
        Icons.view_in_ar_outlined, [Color(0xFF324969), Color(0xFF7B9EC8)]),
    _TemplateInfo('Offer Reel', 'Promotion + urgency CTA', 'Offer',
        Icons.local_offer_outlined, [Color(0xFF9B244B), Color(0xFFFF7D88)]),
    _TemplateInfo('Minimal Studio', 'Neutral background, soft motion',
        'Catalogue', Icons.crop_portrait_outlined,
        [Color(0xFF5D5863), Color(0xFFB6AAB3)]),
    _TemplateInfo('Royal Heritage', 'Traditional premium look', 'Premium',
        Icons.account_balance_outlined, [Color(0xFF513A22), Color(0xFFC59455)]),
    _TemplateInfo('Soft Pastel', 'Light elegant social aesthetic', 'Social',
        Icons.blur_on_outlined, [Color(0xFF9C7CB0), Color(0xFFF0B7C7)]),
    _TemplateInfo('Detail Focus', 'Fabric and embroidery closeups',
        'Catalogue', Icons.center_focus_strong_outlined,
        [Color(0xFF3A4F58), Color(0xFF85A7A6)]),
    _TemplateInfo('New Arrival', 'Fast launch announcement', 'Social',
        Icons.new_releases_outlined, [Color(0xFF433A82), Color(0xFF8A77E0)]),
    _TemplateInfo('Wedding Edit', 'Wedding collection showcase', 'Festive',
        Icons.favorite_border, [Color(0xFF8B405A), Color(0xFFD59B99)]),
    _TemplateInfo('Story Promo', 'Short 9:16 story format', 'Social',
        Icons.smartphone_outlined, [Color(0xFF1C6170), Color(0xFF5FC6BD)]),
    _TemplateInfo('Price Drop', 'Offer + price highlight', 'Offer',
        Icons.trending_down, [Color(0xFFA03B33), Color(0xFFE98558)]),
    _TemplateInfo('Premium Black', 'Dark luxury studio', 'Premium',
        Icons.dark_mode_outlined, [Color(0xFF101010), Color(0xFF4A3B55)]),
    _TemplateInfo('Saree Pallu Walk', 'Flow-focused saree movement', 'Premium',
        Icons.air_outlined, [Color(0xFF5A2F79), Color(0xFFB66FB2)]),
    _TemplateInfo('Dupatta Flow', 'Natural dupatta motion showcase', 'Festive',
        Icons.waves_outlined, [Color(0xFF8B536A), Color(0xFFDF9D91)]),
    _TemplateInfo('Flash Sale', 'Fast hook + bold offer frames', 'Offer',
        Icons.flash_on_outlined, [Color(0xFFB32B45), Color(0xFFFFA85B)]),
    _TemplateInfo('Boutique Daily', 'Simple everyday social reel', 'Social',
        Icons.storefront_outlined, [Color(0xFF4C6178), Color(0xFF98B4C2)]),
    _TemplateInfo('Fabric Zoom', 'Texture and embroidery closeup', 'Catalogue',
        Icons.zoom_in_outlined, [Color(0xFF5A5363), Color(0xFFAA9EAE)]),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = templates.where((item) {
      final q = query.trim().toLowerCase();
      final queryMatch = q.isEmpty ||
          item.title.toLowerCase().contains(q) ||
          item.subtitle.toLowerCase().contains(q);
      final categoryMatch = filter == 'All' || item.category == filter;
      return queryMatch && categoryMatch;
    }).toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: 115),
      children: [
        const _TopBar(
          eyebrow: 'STYLE LIBRARY',
          title: 'Templates',
          subtitle: 'Pick a repeatable look for your brand.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
            onChanged: (value) => setState(() => query = value),
            decoration: const InputDecoration(
              hintText: 'Search styles, moods, formats...',
              prefixIcon: Icon(Icons.search_rounded),
              suffixIcon: Icon(Icons.tune_rounded),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _ChoiceScroller(
          values: const [
            'All',
            'Premium',
            'Festive',
            'Catalogue',
            'Offer',
            'Social'
          ],
          selected: filter,
          onSelected: (value) => setState(() => filter = value),
        ),
        const SizedBox(height: 20),
        _SectionHeader(
          title: filter == 'All' ? 'All templates' : filter,
          subtitle: '${filtered.length} styles available',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 11,
              mainAxisSpacing: 11,
              childAspectRatio: .72,
            ),
            itemBuilder: (_, i) {
              final item = filtered[i];
              return _TemplatePosterCard(
                item: item,
                favourite: favourites.contains(item.title),
                onFavourite: () {
                  setState(() {
                    if (!favourites.add(item.title)) {
                      favourites.remove(item.title);
                    }
                  });
                },
                onTap: () =>
                    _demoMessage(context, '${item.title} selected for preview.'),
              );
            },
          ),
        ),
        if (filtered.isEmpty)
          const Padding(
            padding: EdgeInsets.all(36),
            child: Center(
              child: Text(
                'No matching template yet.',
                style: TextStyle(
                  color: AppColors.muted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: 'My brand styles',
          subtitle: 'Save the looks you want to reuse',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: InkWell(
            onTap: () => _demoMessage(
              context,
              'Custom template builder comes after frontend approval.',
            ),
            borderRadius: BorderRadius.circular(24),
            child: Ink(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF1EAFF), Color(0xFFFFEEF4)],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE8DAFA)),
              ),
              child: const Row(
                children: [
                  _SquareIcon(
                    icon: Icons.add_rounded,
                    color: AppColors.primary,
                    background: Colors.white,
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create your own template',
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Save model, background, motion, text & CTA',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_rounded, color: AppColors.primary),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TemplateInfo {
  const _TemplateInfo(
    this.title,
    this.subtitle,
    this.category,
    this.icon,
    this.colors,
  );
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final List<Color> colors;
}

class _TemplatePosterCard extends StatelessWidget {
  const _TemplatePosterCard({
    required this.item,
    required this.favourite,
    required this.onFavourite,
    required this.onTap,
  });

  final _TemplateInfo item;
  final bool favourite;
  final VoidCallback onFavourite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: item.colors),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -28,
              top: 45,
              child: Icon(
                item.icon,
                color: Colors.white.withOpacity(.10),
                size: 120,
              ),
            ),
            Positioned(
              right: 9,
              top: 9,
              child: IconButton(
                onPressed: onFavourite,
                style: IconButton.styleFrom(
                  minimumSize: const Size(34, 34),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.black.withOpacity(.18),
                  foregroundColor: Colors.white,
                ),
                icon: Icon(
                  favourite ? Icons.favorite : Icons.favorite_border,
                  size: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MiniPill(item.category.toUpperCase()),
                  const Spacer(),
                  Container(
                    width: 55,
                    height: 82,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(item.icon, color: Colors.white, size: 33),
                  ),
                  const Spacer(),
                  Text(
                    item.title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.05,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9.5,
                      height: 1.25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String selected = 'All';

  static const projects = [
    _LibraryItem('Wine Silk Saree', 'Editorial Clean', 'Ready', 1,
        Color(0xFF8C3E65)),
    _LibraryItem('Royal Bridal Lehenga', 'Bridal Luxury', 'Draft', .34,
        Color(0xFFB26A37)),
    _LibraryItem('Gold Festive Saree', 'Festive Glow', 'Generating', .67,
        Color(0xFF9A741A)),
    _LibraryItem('Pastel Kurti Set', 'Soft Pastel', 'Ready', 1,
        Color(0xFF886EA4)),
    _LibraryItem('Wedding Collection', 'Royal Heritage', 'Draft', .22,
        Color(0xFF764F3B)),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = projects.where((item) {
      if (selected == 'All') return true;
      if (selected == 'Ready') return item.status == 'Ready';
      if (selected == 'Drafts') return item.status == 'Draft';
      return item.status == 'Generating';
    }).toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: 115),
      children: [
        const _TopBar(
          eyebrow: 'CONTENT LIBRARY',
          title: 'Your reels',
          subtitle: 'Drafts, generations and ready-to-post exports.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.line),
            ),
            child: Row(
              children: [
                for (final item in const ['All', 'Ready', 'Drafts', 'Working'])
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => selected = item),
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected == item
                              ? const Color(0xFF19141F)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            color: selected == item
                                ? Colors.white
                                : AppColors.muted,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _SectionHeader(
          title: selected == 'All' ? 'Recent projects' : selected,
          subtitle: '${visible.length} items',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              for (var i = 0; i < visible.length; i++) ...[
                _LibraryProjectCard(
                  item: visible[i],
                  onTap: () =>
                      _demoMessage(context, '${visible[i].title} opened.'),
                ),
                if (i != visible.length - 1) const SizedBox(height: 11),
              ],
            ],
          ),
        ),
        if (visible.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Text(
                'Nothing here yet.',
                style: TextStyle(
                  color: AppColors.muted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _LibraryItem {
  const _LibraryItem(
    this.title,
    this.template,
    this.status,
    this.progress,
    this.accent,
  );
  final String title;
  final String template;
  final String status;
  final double progress;
  final Color accent;
}

class _LibraryProjectCard extends StatelessWidget {
  const _LibraryProjectCard({
    required this.item,
    required this.onTap,
  });

  final _LibraryItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ready = item.status == 'Ready';
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.line),
        ),
        child: Row(
          children: [
            Container(
              width: 78,
              height: 105,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [item.accent.withOpacity(.55), item.accent],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.checkroom_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                  if (ready)
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  const Positioned(
                    left: 8,
                    top: 8,
                    child: _MiniPill('9:16'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.template,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      _StatusBadge(status: item.status),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_rounded),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  if (!ready) ...[
                    const SizedBox(height: 7),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: item.progress,
                        minHeight: 4,
                        backgroundColor: AppColors.line,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(item.accent),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;
    switch (status) {
      case 'Ready':
        background = const Color(0xFFE7F6ED);
        foreground = const Color(0xFF277849);
        break;
      case 'Generating':
        background = const Color(0xFFFFF2D9);
        foreground = const Color(0xFF99631A);
        break;
      default:
        background = AppColors.primarySoft;
        foreground = AppColors.primary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool watermark = false;
  bool smartCaptions = true;
  bool autoSave = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 115),
      children: [
        const _TopBar(
          eyebrow: 'WORKSPACE',
          title: 'Settings',
          subtitle: 'Brand, export and app preferences.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF22172E), Color(0xFF65418D)],
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.storefront_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 13),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Brand',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Add logo, colours and default CTA',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _demoMessage(context, 'Brand editor coming next.'),
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white.withOpacity(.10),
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 19),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: 'Creation defaults',
          subtitle: 'Make every new project start your way',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: _SettingsPanel(
            children: [
              const _SettingsNavTile(
                icon: Icons.high_quality_outlined,
                title: 'Default quality',
                subtitle: 'Standard • 720p',
              ),
              const _PanelDivider(),
              const _SettingsNavTile(
                icon: Icons.aspect_ratio_outlined,
                title: 'Reel format',
                subtitle: '9:16 vertical',
              ),
              const _PanelDivider(),
              _SettingsSwitchTile(
                icon: Icons.closed_caption_outlined,
                title: 'Smart captions',
                subtitle: 'Generate caption suggestions',
                value: smartCaptions,
                onChanged: (value) => setState(() => smartCaptions = value),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: 'Export',
          subtitle: 'Control how finished content is saved',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: _SettingsPanel(
            children: [
              _SettingsSwitchTile(
                icon: Icons.branding_watermark_outlined,
                title: 'Watermark',
                subtitle: 'Add brand mark to exports',
                value: watermark,
                onChanged: (value) => setState(() => watermark = value),
              ),
              const _PanelDivider(),
              _SettingsSwitchTile(
                icon: Icons.save_alt_rounded,
                title: 'Auto-save exports',
                subtitle: 'Keep a copy in your library',
                value: autoSave,
                onChanged: (value) => setState(() => autoSave = value),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: 'Connections',
          subtitle: 'These will be connected after frontend approval',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: _SettingsPanel(
            children: [
              _SettingsConnectionTile(
                icon: Icons.cloud_outlined,
                title: 'Supabase',
                status: 'Not connected',
              ),
              _PanelDivider(),
              _SettingsConnectionTile(
                icon: Icons.auto_awesome_outlined,
                title: 'AI generation',
                status: 'API pending',
              ),
              _PanelDivider(),
              _SettingsConnectionTile(
                icon: Icons.camera_alt_outlined,
                title: 'Instagram',
                status: 'Coming later',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsPanel extends StatelessWidget {
  const _SettingsPanel({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsNavTile extends StatelessWidget {
  const _SettingsNavTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 38,
      leading: _SquareIcon(
        icon: icon,
        color: AppColors.primary,
        background: AppColors.primarySoft,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.ink,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.muted,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.muted,
      ),
      onTap: () => _demoMessage(context, '$title opened.'),
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: _SquareIcon(
        icon: icon,
        color: AppColors.primary,
        background: AppColors.primarySoft,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.ink,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.muted,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}

class _SettingsConnectionTile extends StatelessWidget {
  const _SettingsConnectionTile({
    required this.icon,
    required this.title,
    required this.status,
  });

  final IconData icon;
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 38,
      leading: _SquareIcon(
        icon: icon,
        color: AppColors.muted,
        background: AppColors.canvas,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.ink,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.canvas,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          status,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 8.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _SquareIcon extends StatelessWidget {
  const _SquareIcon({
    required this.icon,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _PanelDivider extends StatelessWidget {
  const _PanelDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      indent: 64,
      color: AppColors.line,
    );
  }
}

void _demoMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF201827),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
}
