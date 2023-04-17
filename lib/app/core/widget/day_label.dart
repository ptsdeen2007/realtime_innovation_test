import 'package:flutter/material.dart';

class DayLabel extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onTap;
  const DayLabel({Key? key,this.isSelected=false,required this.text,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelected?Colors.blue:Colors.blue.shade50
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(text,style: TextStyle(color: isSelected?Colors.white:Colors.blue),),
            ),
          ),
        ),
      ),
    );
  }
}
