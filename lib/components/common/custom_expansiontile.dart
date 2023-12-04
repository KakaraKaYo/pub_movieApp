import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final Widget? leading;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? tilePadding;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    this.children = const <Widget>[],
    this.leading,
    this.backgroundColor,
    this.tilePadding,
  }) : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5)
        .chain(CurveTween(curve: Curves.easeIn)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return Column(
          children: <Widget>[
            ListTile(
              onTap: _handleTap,
              leading: widget.leading,
              title: widget.title,
              trailing: RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.expand_more),
              ),
            ),
            ClipRect(
              child: Align(
                heightFactor: _controller.value,
                child: Column(children: widget.children),
              ),
            ),
          ],
        );
      },
    );
  }
}
