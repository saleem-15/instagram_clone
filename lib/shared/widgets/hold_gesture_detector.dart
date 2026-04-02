import 'dart:async';
import 'package:flutter/material.dart';

/// A widget that detects a continuous "hold" gesture.
/// It uses lower-level pointer events to allow configuring an exact delay.
class HoldGestureDetector extends StatefulWidget {
  const HoldGestureDetector({
    super.key,
    required this.child,
    required this.onHold,
    required this.onHoldEnd,
    this.holdDuration = const Duration(milliseconds: 300),
  });

  final Widget child;
  final VoidCallback onHold;
  final VoidCallback onHoldEnd;
  final Duration holdDuration;

  @override
  State<HoldGestureDetector> createState() => _HoldGestureDetectorState();
}

class _HoldGestureDetectorState extends State<HoldGestureDetector> {
  Timer? _timer;
  bool _isHolding = false;

  void _onPointerDown(PointerDownEvent event) {
    _timer?.cancel();
    _timer = Timer(widget.holdDuration, () {
      if (mounted) {
        _isHolding = true;
        widget.onHold();
      }
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    _timer?.cancel();
    if (_isHolding) {
      _isHolding = false;
      widget.onHoldEnd();
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _timer?.cancel();
    if (_isHolding) { 
      _isHolding = false; 
      widget.onHoldEnd();
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    // Cancel the hold if the user moves their finger off the initial touch point
    // too quickly (e.g., they are scrolling through a view)
    if (event.delta.distance > 2.0 && !_isHolding) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      onPointerMove: _onPointerMove,
      child: widget.child,
    );
  }
}
