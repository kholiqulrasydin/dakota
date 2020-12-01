import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator = Container(
    width: 250,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: MyColors.primaryColorLight,
    ),
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Container(
          margin: const EdgeInsets.only(top: 25),
          child: Text(
            'sedang memproses data, mohon bersabar',
            style: TextStyle(color: MyColors.textColor, fontSize: 10),
          ),
        )
      ],
    )),
  );
  final bool dismissible;
  final Widget child;

  Loader({
    Key key,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    return Stack(
      children: [
        child,
        Opacity(
          child: ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        Center(child: progressIndicator),
      ],
    );
  }
}

class MyColors {
  static Color primaryColor = Colors.blueAccent.shade400;
  static Color primaryColorLight = Colors.white;
  static Color textColor = Colors.blueAccent;
}
