import 'package:flutter/material.dart';

class AniListOverviewListContainerWidget extends StatefulWidget {
  final Widget child;
  final bool expanded;

  AniListOverviewListContainerWidget({ this.expanded = false, this.child });

  @override
  _AniListOverviewListContainerWidgetState createState() => _AniListOverviewListContainerWidgetState();
}

class _AniListOverviewListContainerWidgetState extends State<AniListOverviewListContainerWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void _prepareAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(AniListOverviewListContainerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void initState() {
    super.initState();
    _prepareAnimations();
    _runExpandCheck();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: _animation,
      child: widget.child,
    );
  }
}
