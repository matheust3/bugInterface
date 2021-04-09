import 'package:assist_agro/core/util/app_colors.dart';
import 'package:assist_agro/core/util/app_fonts.dart';
import 'package:assist_agro/core/widgets/app_text_fild.dart';
import 'package:assist_agro/features/admin/presentation/widgets/page_model.dart';
import 'package:flutter/material.dart';

class AddUserPage extends PageModel {
  @override
  Widget build({double? paddingSize, Duration? animationDuration}) {
    final padding = paddingSize ?? 0;
    final duration = animationDuration ?? Duration(milliseconds: 300);

    return AnimatedContainer(
      duration: duration,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.boxes,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(left: padding + 40, top: 4, right: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10),
              child: Text(
                'Cadastrar novo usuário',
                style: AppFonts.boxesTitle,
              ),
            ),
            AppTextFild(
              labelText: 'Nome do usuário',
            ),
            AppTextFild(
              labelText: 'E-mail',
            ),
            AppTextFild(
              labelText: 'Organização',
            ),
            AppTextFild(
              labelText: 'CPF',
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Cadastrar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
