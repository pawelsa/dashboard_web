import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 110),
          color: Colors.blue,
          child: Wrap(
            direction: Axis.horizontal,
            children: List<int>.generate(50, (index) => 17 * index).map(
              (number) {
                double aspectRatio = 1;
                if (number % 5 == 0) {
                  aspectRatio = 5;
                } else if (number % 4 == 0) {
                  aspectRatio = 4;
                } else if (number % 3 == 0) {
                  aspectRatio = 3;
                } else if (number % 2 == 0) {
                  aspectRatio = 2;
                }

                final height = 60.0;
                return Container(
                  width: aspectRatio * height,
                  height: height,
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('This card\'s aspect ratio = $aspectRatio'),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        MainDrawer(),
      ],
    );
  }
}

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  static const _standardPadding = const EdgeInsets.all(12.0);
  static const duration = Duration(milliseconds: 100);
  EdgeInsets padding = _standardPadding;
  EdgeInsets innerPadding = const EdgeInsets.all(8.0);
  double width = 100.0;
  BorderRadiusGeometry borderRadius = BorderRadius.circular(12.0);
  bool isDetailed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      animationDuration: duration,
      elevation: isDetailed ? 20 : 0,
      child: AnimatedPadding(
        duration: duration,
        padding: padding,
        child: Material(
          child: MouseRegion(
            onHover: _onHover,
            onExit: _onExit,
            child: AnimatedContainer(
              duration: duration,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: borderRadius,
              ),
              child: AnimatedPadding(
                duration: duration,
                padding: innerPadding,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      MenuItem(
                        icon: Icons.account_circle,
                        text: 'Profile',
                        isDetailed: isDetailed,
                      ),
                      Spacer(),
                      MenuItem(
                        icon: Icons.home,
                        text: 'Home page',
                        isDetailed: isDetailed,
                      ),
                      MenuItem(
                        icon: Icons.navigation,
                        text: 'Navigate',
                        isDetailed: isDetailed,
                      ),
                      Spacer(),
                      MenuItem(
                        icon: Icons.border_color,
                        text: 'Edit',
                        isDetailed: isDetailed,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(event) {
    setState(() {
      isDetailed = true;
      padding = EdgeInsets.zero;
      innerPadding = EdgeInsets.all(20.0);
      width = 124;
      borderRadius = BorderRadius.zero;
    });
  }

  void _onExit(event) {
    setState(() {
      isDetailed = false;
      padding = _standardPadding;
      innerPadding = EdgeInsets.all(8.0);
      width = 100;
      borderRadius = BorderRadius.circular(12.0);
    });
  }
}

class MenuItem extends StatefulWidget {
  final bool isDetailed;
  final bool isSelected;
  final IconData icon;
  final String text;

  const MenuItem(
      {Key key, this.icon, this.text, this.isDetailed, this.isSelected = false})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isHoveredOver = false;
  final duration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MouseRegion(
        onHover: (_) {
          setState(() {
            isHoveredOver = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHoveredOver = false;
          });
        },
        child: AnimatedContainer(
          duration: duration,
          width: widget.isDetailed ? 200 : 70,
          height: 70,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Colors.orangeAccent
                : (isHoveredOver
                    ? Colors.deepOrangeAccent
                    : Colors.deepPurpleAccent),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedPadding(
                duration: duration,
                padding: EdgeInsets.only(left: widget.isDetailed ? 5 : 20),
                child: Container(
                  width: 30,
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: duration,
                width: widget.isDetailed ? 40 : 0,
              ),
              AnimatedDefaultTextStyle(
                duration: duration,
                child: Text(widget.text),
                style: widget.isDetailed
                    ? Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white)
                    : Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                          fontSize: 0.0,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
