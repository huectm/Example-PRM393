import 'package:flutter/material.dart';
class LikeStarButton extends StatefulWidget {
  const LikeStarButton({super.key});

  @override
  State<LikeStarButton> createState() => _State();
}

class _State extends State<LikeStarButton> {
  bool color = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.star),
        color: color ? Colors.yellow : Colors.grey,
        onPressed: () {
          setState(() {
            color = !color;
          });
        });
  }
}

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  var cuValue=0.0;
  void OnchangeValue(double value)
  {
    setState(() {
      cuValue=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Slider(value: cuValue,
        onChanged: (double value){OnchangeValue(value);}
    );
  }
}
