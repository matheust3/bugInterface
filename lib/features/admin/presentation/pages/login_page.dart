import 'package:assist_agro/core/util/app_colors.dart';
import 'package:assist_agro/core/util/app_fonts.dart';
import 'package:assist_agro/core/widgets/app_text_fild.dart';
import 'package:assist_agro/core/widgets/background.dart';
import 'package:assist_agro/core/widgets/button1.dart';
import 'package:assist_agro/core/widgets/check_box.dart';
import 'package:assist_agro/core/widgets/loading_indicator.dart';
import 'package:assist_agro/features/admin/presentation/cubits/login_page/login_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/admin/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginPageCubit loginPageCubit;

  @override
  void initState() {
    loginPageCubit = sl();
    super.initState();
  }

  @override
  void dispose() {
    loginPageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.boxes,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.borderBoxes,
                      blurRadius: 1,
                      spreadRadius: 0.01,
                    ),
                  ]),
              width: 500,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 8),
                    child: Text(
                      'Login do Administrador',
                      style: AppFonts.boxesTitle,
                    ),
                  ),
                  StreamBuilder<String?>(
                      stream: loginPageCubit.userNameError,
                      initialData: null,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 4),
                          child: AppTextFild(
                            labelText: 'Usuário',
                            errorText: snapshot.data,
                            onChanged: loginPageCubit.onUserName,
                          ),
                        );
                      }),
                  StreamBuilder<bool>(
                      stream: loginPageCubit.showPass,
                      initialData: false,
                      builder: (context, showPassSnapshot) {
                        return Column(
                          children: [
                            StreamBuilder<String?>(
                                stream: loginPageCubit.passError,
                                initialData: null,
                                builder: (context, snapshot) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: AppTextFild(
                                      labelText: 'Senha',
                                      errorText: snapshot.data,
                                      onChanged: loginPageCubit.onPass,
                                      obscureText:
                                          !(showPassSnapshot.data as bool),
                                    ),
                                  );
                                }),
                            CheckBox1(
                              value: showPassSnapshot.data as bool,
                              onChanged: (_) => loginPageCubit.onShowPass(),
                            ),
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                        child: Button1(
                            onPressed: loginPageCubit.login,
                            child: Text('Logar'))),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<bool>(
              stream: loginPageCubit.loading,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data == true)
                  return LoadingIndicator();
                else
                  return Container();
              }),
          StreamBuilder(
              stream: loginPageCubit.snackMessage,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(snapshot.data as String)));
                  });
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
