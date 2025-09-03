//////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:gyandarshan/core/colors.dart';

class DropdownItem {
  final String id;
  final String display;

  DropdownItem({required this.id, required this.display});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropdownItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class CustomDropdown extends StatefulWidget {
  final DropdownItem? value;
  final String hintText;
  final List<DropdownItem>
  items; // Changed from List<String> to List<DropdownItem>
  final void Function(DropdownItem?)?
  onChanged; // Changed from String? to DropdownItem?
  final String? Function(DropdownItem?)? validator; // Changed parameter type
  final FocusNode? focusNode;

  const CustomDropdown({
    super.key,
    this.value,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.validator,
    this.focusNode,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isOpen = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  // Static variable to keep track of currently open dropdown
  static _CustomDropdownState? _currentOpenDropdown;

  @override
  void dispose() {
    // Clean up without calling setState
    _overlayEntry?.remove();
    _overlayEntry = null;

    // Clear static reference if this is the currently open dropdown
    if (_currentOpenDropdown == this) {
      _currentOpenDropdown = null;
    }

    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    // Close any other open dropdown first
    _currentOpenDropdown?._closeDropdown();

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);

    if (mounted) {
      setState(() {
        _isOpen = true;
        _currentOpenDropdown = this; // Set this as the currently open dropdown
      });
    }
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }

    // Clear static reference if this is the currently open dropdown
    if (_currentOpenDropdown == this) {
      _currentOpenDropdown = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        // This will detect taps outside the dropdown
        onTap: () => _closeDropdown(),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            // Invisible full-screen overlay to catch outside taps
            Positioned.fill(child: Container(color: Colors.transparent)),
            // The actual dropdown
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height),
                child: GestureDetector(
                  // Prevent the dropdown itself from closing when tapped
                  onTap: () {},
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 200, // Limit dropdown height
                      ),
                      decoration: BoxDecoration(
                        color: Appcolors.kwhitecolor,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: .5,
                        ),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final isSelected = widget.value?.id == item.id;

                          return InkWell(
                            onTap: () {
                              widget.onChanged?.call(
                                item,
                              ); // Pass the entire DropdownItem
                              _closeDropdown();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue.shade50
                                    : Colors.white,
                                border: index < widget.items.length - 1
                                    ? Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 1.0,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Text(
                                item.display, // Show the display name
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected
                                      ? Colors.blue.shade700
                                      : Colors.black87,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 235, 248, 241),
            borderRadius: BorderRadius.circular(50),
            // border: Border.all(color: Appcolors.kbordercolor, width: 1),
          ),
          child: Container(
            //decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.value?.display ??
                        widget.hintText, // Show display name or hint
                    style: TextStyle(
                      fontSize: 14,
                      color: Appcolors.ktextcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Appcolors.kbordercolor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
