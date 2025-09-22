import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/App/Core/Theme/riverpod/theme_provider.dart';
import 'package:civic_reporter/Web/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideBar extends ConsumerStatefulWidget {
  const SideBar({super.key});

  @override
  ConsumerState<SideBar> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(ConstantsofSideBar.pageIndexProvider);
    final currentTheme = ref.watch(themeProvider);
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: _isExpanded ? 250 : 80,
          decoration: BoxDecoration(
            color: theme.cardColor,
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            children: [
              _buildHeader(),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: ConstantsofSideBar.labels.length,
                  itemBuilder: (context, index) {
                    final isSelected = pageIndex == index;
                    // final isSelected = ConstantsofSideBar.pages == index;
                    return _buildSidebarItem(
                      iconData: ConstantsofSideBar.icons[index],
                      label: ConstantsofSideBar.labels[index],
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          ref.read(ConstantsofSideBar.pageIndexProvider.notifier).state = index;
                          // ConstantsofSideBar.pageno = index;
                        });
                      },
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IconButton(
                  onPressed: () {
                    final notifier = ref.read(themeProvider.notifier);
                    notifier.state = currentTheme == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  },
                  icon: Icon(
                    currentTheme == ThemeMode.light
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    size: 24,
                    color: theme.iconTheme.color,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: ConstantsofSideBar.pages[pageIndex]),
        // Expanded(child: ConstantsofSideBar.pages[ConstantsofSideBar.pageno]),
      ],
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: _isExpanded
            ? [
                Icon(Icons.language, color: theme.primaryColor, size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringConstants.CivicReporter,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Admin Portal",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _isExpanded = false),
                  icon: const Icon(Icons.chevron_left),
                ),
              ]
            : [
                IconButton(
                  onPressed: () => setState(() => _isExpanded = true),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData iconData,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Tooltip(
        message: label,
        waitDuration: const Duration(milliseconds: 500),
        child: ListTile(
          onTap: onTap,
          selected: isSelected,
          leading: Icon(iconData),
          minLeadingWidth: 0,
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isExpanded ? 1 : 0,
            child: Text(label, maxLines: 1),
          ),
          selectedTileColor: theme.primaryColor.withOpacity(0.1),
          selectedColor: theme.primaryColor,
          textColor: theme.textTheme.bodyMedium?.color,
          iconColor: theme.iconTheme.color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}