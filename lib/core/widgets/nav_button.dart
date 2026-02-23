import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  final String label;
  final Future<void> Function() onPressedAsync;
  final bool enabled;

  const NavButton({
    super.key,
    required this.label,
    required this.onPressedAsync,
    this.enabled = true,
  });

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool _busy = false;

  Future<void> _handle() async {
    if (!widget.enabled || _busy) return;
    setState(() => _busy = true);
    try {
      await widget.onPressedAsync();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.enabled ? _handle : null,
      child: _busy
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(widget.label),
    );
  }
}
