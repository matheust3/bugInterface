import 'package:assist_agro/core/util/app_colors.dart';
import 'package:assist_agro/core/util/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextFild extends StatefulWidget {
  final String? labelText;
  final bool? obscureText;
  final String? errorText;
  final Function(String)? onChanged;

  const AppTextFild(
      {Key? key,
      this.labelText,
      this.obscureText,
      this.errorText,
      this.onChanged})
      : super(key: key);

  @override
  _AppTextFildState createState() => _AppTextFildState();
}

class _AppTextFildState extends State<AppTextFild> {
  final _controller = _InputTextFildController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.widget.labelText != null
                  ? this.widget.labelText as String
                  : '',
              style: AppFonts.inputTextFildLabelText,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 2),
              decoration: BoxDecoration(
                color: this._controller.hasFocus
                    ? AppColors.inputTextFildFocusFillColor
                    : null,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: widget.errorText != null
                        ? Colors.red
                        : AppColors.inputTextFildBorderColor),
              ),
              child: TextField(
                obscureText: widget.obscureText != null
                    ? widget.obscureText as bool
                    : false,
                onChanged: widget.onChanged,
                focusNode: this._controller.focusNode,
                style: AppFonts.inputTextFild,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            widget.errorText != null
                ? Text(
                    widget.errorText as String,
                    style: AppFonts.inputTextFildLabelText.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class _InputTextFildController extends ChangeNotifier {
  final focusNode = FocusNode();
  bool hasFocus = false;
  _InputTextFildController() {
    focusNode.addListener(() {
      this.hasFocus = focusNode.hasFocus;
      notifyListeners();
    });
  }

  void update() {
    notifyListeners();
  }
}
