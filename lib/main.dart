import 'package:flutter/material.dart';

void main() {
  runApp(const FashionAiApp());
}

class FashionAiApp extends StatelessWidget {
  const FashionAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF6D28D9);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion AI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xFFE9E7EF)),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    HomeScreen(),
    CreateReelScreen(),
    TemplatesScreen(),
    LibraryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_mosaic_outlined), selectedIcon: Icon(Icons.auto_awesome_mosaic), label: 'Templates'),
          NavigationDestination(icon: Icon(Icons.video_library_outlined), selectedIcon: Icon(Icons.video_library), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader(this.title, this.subtitle, {super.key, this.trailing});
  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54)),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const PageHeader(
          'Fashion AI',
          'Turn garment photos into ready-to-post reels.',
          trailing: CircleAvatar(child: Icon(Icons.person_outline)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6D28D9), Color(0xFF9333EA)]),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create your next reel', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Text('Upload a saree, lehenga or kurti and choose a style template.', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 18),
                FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF6D28D9)),
                  onPressed: () {},
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Start creating'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        const SectionTitle('Quick actions'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(child: QuickAction(icon: Icons.photo_camera_back_outlined, label: 'Upload product')),
              SizedBox(width: 12),
              Expanded(child: QuickAction(icon: Icons.auto_awesome_mosaic_outlined, label: 'Browse templates')),
              SizedBox(width: 12),
              Expanded(child: QuickAction(icon: Icons.video_collection_outlined, label: 'My reels')),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const SectionTitle('Recent projects'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ProjectTile(title: 'Wine Silk Saree', status: 'Draft', icon: Icons.checkroom),
              SizedBox(height: 10),
              ProjectTile(title: 'Bridal Lehenga', status: 'Ready', icon: Icons.checkroom),
              SizedBox(height: 10),
              ProjectTile(title: 'Festive Kurti', status: 'Generating', icon: Icons.hourglass_top),
            ],
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}

class QuickAction extends StatelessWidget {
  const QuickAction({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 10),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        ],
      ),
    );
  }
}

class ProjectTile extends StatelessWidget {
  const ProjectTile({super.key, required this.title, required this.status, required this.icon});
  final String title;
  final String status;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primaryContainer, child: Icon(icon)),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
          Chip(label: Text(status)),
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
  String template = 'Premium Cinematic';
  bool hasPhotos = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const PageHeader('Create Reel', 'Upload product photos and choose your reel style.'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            borderRadius: BorderRadius.circular(26),
            onTap: () => setState(() => hasPhotos = !hasPhotos),
            child: Container(
              height: 190,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: hasPhotos ? Theme.of(context).colorScheme.primary : const Color(0xFFE5E3EA),
                  width: hasPhotos ? 1.6 : 1,
                ),
              ),
              child: hasPhotos
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        children: [
                          _MockPhoto(label: 'Front', icon: Icons.checkroom_outlined),
                          SizedBox(width: 8),
                          _MockPhoto(label: 'Back', icon: Icons.rotate_left_outlined),
                          SizedBox(width: 8),
                          _MockPhoto(label: 'Detail', icon: Icons.center_focus_strong_outlined),
                        ],
                      ),
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_outlined, size: 46),
                        SizedBox(height: 10),
                        Text('Add product photos', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                        SizedBox(height: 4),
                        Text('Tap to add front, back and detail photos', style: TextStyle(color: Colors.black54)),
                      ],
                    ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SectionTitle('Category'),
        HorizontalChoice(
          values: const ['Saree', 'Lehenga', 'Kurti', 'Suit', 'Other'],
          selected: category,
          onSelected: (v) => setState(() => category = v),
        ),
        const SizedBox(height: 18),
        const SectionTitle('Template'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonFormField<String>(
            initialValue: template,
            items: const [
              'Premium Cinematic',
              'Classic Catalogue',
              'Bridal Luxury',
              'Festive Glow',
              '3-Angle Short',
              'Offer Reel',
              'Minimal Studio',
              'Royal Heritage',
              'Soft Pastel',
              'Runway Walk',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => template = v ?? template),
          ),
        ),
        const SizedBox(height: 18),
        const SectionTitle('Quality'),
        HorizontalChoice(
          values: const ['Draft', 'Standard', 'Premium'],
          selected: quality,
          onSelected: (v) => setState(() => quality = v),
        ),
        const SizedBox(height: 18),
        const SectionTitle('Product details'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(decoration: InputDecoration(labelText: 'Product name / SKU')),
              SizedBox(height: 12),
              TextField(decoration: InputDecoration(labelText: 'Price (optional)')),
              SizedBox(height: 12),
              TextField(maxLines: 3, decoration: InputDecoration(labelText: 'CTA / note (optional)')),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FilledButton.icon(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => const AlertDialog(
                title: Text('Frontend demo'),
                content: Text('Generation API will be connected in the next phase.'),
              ),
            ),
            icon: const Icon(Icons.auto_awesome),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text('Generate Reel'),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _MockPhoto extends StatelessWidget {
  const _MockPhoto({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF0E7FA), Color(0xFFE1C7F4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF6D28D9), size: 30),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class HorizontalChoice extends StatelessWidget {
  const HorizontalChoice({super.key, required this.values, required this.selected, required this.onSelected});
  final List<String> values;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => ChoiceChip(
          label: Text(values[i]),
          selected: values[i] == selected,
          onSelected: (_) => onSelected(values[i]),
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

  static const templates = [
    ('Premium Cinematic', 'Luxury motion + elegant typography', 'Premium', Icons.movie_creation_outlined),
    ('Classic Catalogue', 'Clean product-first showcase', 'Catalogue', Icons.grid_view_rounded),
    ('Bridal Luxury', 'Rich bridal presentation', 'Premium', Icons.diamond_outlined),
    ('Festive Glow', 'Bright festive movement', 'Festive', Icons.celebration_outlined),
    ('3-Angle Short', 'Front, turn and detail', 'Catalogue', Icons.view_in_ar_outlined),
    ('Offer Reel', 'Promotion + urgency CTA', 'Offer', Icons.local_offer_outlined),
    ('Minimal Studio', 'Neutral background, soft motion', 'Catalogue', Icons.crop_portrait_outlined),
    ('Royal Heritage', 'Traditional premium look', 'Premium', Icons.account_balance_outlined),
    ('Soft Pastel', 'Light elegant social aesthetic', 'Social', Icons.blur_on_outlined),
    ('Runway Walk', 'Model walking presentation', 'Premium', Icons.directions_walk_outlined),
    ('Detail Focus', 'Fabric and embroidery closeups', 'Catalogue', Icons.center_focus_strong_outlined),
    ('New Arrival', 'Fast launch announcement', 'Social', Icons.new_releases_outlined),
    ('Wedding Edit', 'Wedding collection showcase', 'Festive', Icons.favorite_border),
    ('Story Promo', 'Short 9:16 story format', 'Social', Icons.smartphone_outlined),
    ('Price Drop', 'Offer + price highlight', 'Offer', Icons.trending_down),
    ('Premium Black', 'Dark luxury studio', 'Premium', Icons.dark_mode_outlined),
    ('Saree Pallu Walk', 'Flow-focused saree movement', 'Premium', Icons.air_outlined),
    ('Dupatta Flow', 'Natural dupatta motion showcase', 'Festive', Icons.waves_outlined),
    ('Editorial Clean', 'Magazine-style minimal fashion', 'Premium', Icons.article_outlined),
    ('Flash Sale', 'Fast hook + bold offer frames', 'Offer', Icons.flash_on_outlined),
    ('Boutique Daily', 'Simple everyday social reel', 'Social', Icons.storefront_outlined),
    ('Fabric Zoom', 'Texture and embroidery closeup', 'Catalogue', Icons.zoom_in_outlined),
    ('Outdoor Chic', 'Lifestyle fashion presentation', 'Social', Icons.park_outlined),
    ('Velvet Night', 'Deep luxury evening aesthetic', 'Premium', Icons.nightlight_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = templates.where((item) {
      final q = query.trim().toLowerCase();
      final matchesQuery = q.isEmpty || item.$1.toLowerCase().contains(q) || item.$2.toLowerCase().contains(q);
      final matchesFilter = filter == 'All' || item.$3 == filter;
      return matchesQuery && matchesFilter;
    }).toList();

    return ListView(
      children: [
        const PageHeader('Templates', 'Choose a repeatable reel style for your products.'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) => setState(() => query = value),
            decoration: const InputDecoration(
              hintText: 'Search templates',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 42,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            children: ['All', 'Premium', 'Festive', 'Catalogue', 'Offer', 'Social'].map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(item),
                  selected: filter == item,
                  onSelected: (_) => setState(() => filter = item),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 18),
        SectionTitle(filter == 'All' ? 'All templates' : filter),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: .93,
            ),
            itemBuilder: (_, i) {
              final item = filtered[i];
              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: ${item.$1}')),
                ),
                child: Ink(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            child: Icon(item.$4),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2ECFB),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(item.$3, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text(item.$2, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (filtered.isEmpty)
          const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: Text('No template found.', style: TextStyle(color: Colors.black54))),
          ),
        const SizedBox(height: 28),
        const SectionTitle('My Templates'),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Custom template builder will connect after frontend approval.')),
            ),
            child: Ink(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
              child: const Row(
                children: [
                  Icon(Icons.add_box_outlined),
                  SizedBox(width: 12),
                  Expanded(child: Text('Create and save your own repeatable style.', style: TextStyle(fontWeight: FontWeight.w600))),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ),
      ],
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
    ('Wine Silk Saree', 'Ready', Icons.play_circle_outline),
    ('Royal Bridal Lehenga', 'Draft', Icons.edit_outlined),
    ('Gold Festive Saree', 'Generating', Icons.hourglass_top),
    ('Pastel Kurti Set', 'Ready', Icons.play_circle_outline),
    ('Wedding Collection', 'Draft', Icons.edit_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = projects.where((item) {
      if (selected == 'All') return true;
      if (selected == 'Ready') return item.$2 == 'Ready';
      return item.$2 == 'Draft';
    }).toList();

    return ListView(
      children: [
        const PageHeader('Library', 'Your generated reels, drafts and exports.'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'All', label: Text('All')),
              ButtonSegment(value: 'Ready', label: Text('Ready')),
              ButtonSegment(value: 'Drafts', label: Text('Drafts')),
            ],
            selected: {selected},
            onSelectionChanged: (value) => setState(() => selected = value.first),
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              for (var i = 0; i < visible.length; i++) ...[
                ProjectTile(title: visible[i].$1, status: visible[i].$2, icon: visible[i].$3),
                if (i != visible.length - 1) const SizedBox(height: 10),
              ],
              if (visible.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text('Nothing here yet.', style: TextStyle(color: Colors.black54)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageHeader('Settings', 'Brand, export and app preferences.'),
        SettingsGroup(
          title: 'Brand',
          items: [
            SettingsItem(Icons.storefront_outlined, 'Brand profile', 'Logo, store name and CTA'),
            SettingsItem(Icons.palette_outlined, 'Brand style', 'Fonts and visual preferences'),
            SettingsItem(Icons.music_note_outlined, 'Music preference', 'Default reel music style'),
          ],
        ),
        SettingsGroup(
          title: 'Export',
          items: [
            SettingsItem(Icons.high_quality_outlined, 'Default quality', 'Standard 720p'),
            SettingsItem(Icons.aspect_ratio_outlined, 'Aspect ratio', '9:16 vertical'),
            SettingsItem(Icons.download_outlined, 'Download settings', 'Watermark and file naming'),
          ],
        ),
        SettingsGroup(
          title: 'Coming later',
          items: [
            SettingsItem(Icons.cloud_outlined, 'Supabase', 'Backend not connected yet'),
            SettingsItem(Icons.auto_awesome_outlined, 'AI providers', 'Image + video API setup'),
            SettingsItem(Icons.camera_alt_outlined, 'Instagram', 'Publishing integration'),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.title, required this.items});
  final String title;
  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  items[i],
                  if (i != items.length - 1) const Divider(height: 1, indent: 58),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem(this.icon, this.title, this.subtitle, {super.key});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
