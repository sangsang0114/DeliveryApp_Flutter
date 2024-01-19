import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obsecureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obsecureText = false,
    this.autofocus = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력 시 복자 처리
      obscureText: obsecureText,

      //true로 할 경우, 위젯에 인풋이 나타나면 focus 여부
      autofocus: autofocus,

      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
        errorText: errorText,
        fillColor: INPUT_BG_COLOR,
        filled: true,
        // false: 배경색 없음, true: 있음

        border: baseBorder,
        //모든 input 상태의 기본 스타일 세팅

        enabledBorder: baseBorder,
        //선택되지 않은 상태에서 활성화 된 상태의 border

        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
        //포커스 된 input 상태의 스타일
      ),
    );
  }
}
