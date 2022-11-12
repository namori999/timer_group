import 'package:flutter/material.dart';
import 'package:timer_group/views/configure/theme.dart';

class ToggleTextButton extends StatefulWidget {
  ToggleTextButton({
    required this.onRightSelected,
    required this.onLeftSelected,
    Key? key,
  }) : super(key: key);

  VoidCallback onRightSelected;
  VoidCallback onLeftSelected;

  @override
  _ToggleTextButtonState createState() => _ToggleTextButtonState();
}

const double width = 240.0;
const double height = 30.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black;

class _ToggleTextButtonState extends State<ToggleTextButton> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;

  VoidCallback get onRightSelected => widget.onRightSelected;
  VoidCallback get onLeftSelected => widget.onLeftSelected;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Themes.grayColor[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(xAlign, 0),
              duration: Duration(milliseconds: 300),
              child: Container(
                width: width * 0.5,
                height: height,
                decoration: const BoxDecoration(
                  color: Themes.grayColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onLeftSelected();
                setState(() {
                  xAlign = loginAlign;
                  loginColor = selectedColor;
                  signInColor = normalColor;
                });
              },
              child: Align(
                alignment: Alignment(-1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    '画像',
                    style: TextStyle(
                      fontSize: 12,
                      color: loginColor,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onRightSelected();
                setState(() {
                  xAlign = signInAlign;
                  signInColor = selectedColor;
                  loginColor = normalColor;
                });
              },
              child: Align(
                alignment: Alignment(1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    '動画',
                    style: TextStyle(
                      fontSize: 12,
                      color: signInColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
