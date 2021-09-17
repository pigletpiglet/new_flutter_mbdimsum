import 'package:flutter/material.dart';

class BigIconButton extends StatelessWidget {
  Function() function;
  Color color;
  String label;
  IconData iconData;

  BigIconButton({
    required this.function,
    required this.color,
    required this.label,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              splashColor: color,
              onTap: function,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: color,
                      style: BorderStyle.solid,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      iconData,
                      color: color,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
