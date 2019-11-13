import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  const Button({Key key, this.text, this.color,@required this.onPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return      Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
