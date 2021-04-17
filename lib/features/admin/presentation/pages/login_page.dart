import 'dart:async';

import 'package:assist_agro/core/util/app_colors.dart';
import 'package:assist_agro/core/util/app_fonts.dart';
import 'package:assist_agro/core/widgets/app_text_fild.dart';
import 'package:assist_agro/core/widgets/background.dart';
import 'package:assist_agro/core/widgets/button1.dart';
import 'package:assist_agro/core/widgets/check_box.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/admin/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Stream<bool> get showPass => _showPassController.stream;
  final _showPassController = StreamController<bool>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _showPassController.close();
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 4),
                    child: AppTextFild(labelText: 'Usuário'),
                  ),
                  StreamBuilder<bool>(
                      stream: showPass,
                      initialData: false,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: AppTextFild(
                                labelText: 'Senha',
                                onChanged: (_) {},
                                obscureText: !(snapshot.data as bool),
                              ),
                            ),
                            CheckBox1(
                              value: (snapshot.data as bool),
                              onChanged: (_) {
                                _showPassController.sink
                                    .add(!(snapshot.data as bool));
                              },
                            ),
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                        child: Button1(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()));
                            },
                            child: Text('Logar'))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
