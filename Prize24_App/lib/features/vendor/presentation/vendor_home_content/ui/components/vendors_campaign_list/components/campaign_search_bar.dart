import 'package:flutter/material.dart';

class CampaignSearchBar extends StatefulWidget {
  final void Function(String) onSearchChanged;
  final VoidCallback? onFilterTap;

  const CampaignSearchBar({
    super.key,
    required this.onSearchChanged,
    this.onFilterTap,
  });

  @override
  State<CampaignSearchBar> createState() => _CampaignSearchBarState();
}

class _CampaignSearchBarState extends State<CampaignSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isSearchActive
              ? theme.colorScheme.primary.withOpacity(0.5)
              : theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Search TextField
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                widget.onSearchChanged(value);
                setState(() {
                  _isSearchActive = value.isNotEmpty;
                });
              },
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontFamily: 'Gilroy',
              ),
              decoration: InputDecoration(
                hintText: 'Search campaigns...',
                hintStyle: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: _isSearchActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.5),
                  size: 20,
                ),
                suffixIcon: _isSearchActive
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          widget.onSearchChanged('');
                          setState(() {
                            _isSearchActive = false;
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                          size: 20,
                        ),
                      )
                    : null,
              ),
            ),
          ),

          // Filter Button
          if (widget.onFilterTap != null) ...[
            Container(
              width: 1,
              height: 24,
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
            IconButton(
              onPressed: widget.onFilterTap,
              icon: Icon(
                Icons.tune,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                size: 20,
              ),
              style: IconButton.styleFrom(
                minimumSize: const Size(48, 48),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
