import 'package:flutter/material.dart';

class ScrapButton extends StatefulWidget{
  final bool isTapped;
  final VoidCallback onTap;
  const ScrapButton({super.key, required this.isTapped, required this.onTap});

  @override
  State<ScrapButton> createState() => ScrapState();
}

class ScrapState extends State<ScrapButton>{


  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTapCancel: () => {widget.onTap()},
      onTapUp: (_) => widget.onTap(),
      child: Image.asset('assets/Images/scrap.png', width: 30,height: 30,
      color: widget.isTapped ? Colors.red : null,
      ),
    );

  }
}