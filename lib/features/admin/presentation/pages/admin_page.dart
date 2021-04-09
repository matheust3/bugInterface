import 'dart:async';

import 'package:assist_agro/core/util/app_colors.dart';
import 'package:assist_agro/core/widgets/background.dart';
import 'package:assist_agro/features/admin/presentation/cubits/admin_page/admin_page_cubit.dart';
import 'package:assist_agro/features/admin/presentation/pages/add_user_page.dart';
import 'package:assist_agro/features/admin/presentation/widgets/side_bar/side_bar.dart';
import 'package:assist_agro/features/admin/presentation/widgets/side_bar/side_bar_main_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatefulWidget {
  static const String route = '/admin';
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Stream<bool> get expanded => _expandedController.stream;
  final _expandedController = StreamController<bool>();
  bool expandedValue = false;
  final Duration animationDuration = Duration(milliseconds: 300);
  final double sideBarWidth = 48;
  final double sideBarExpandedWidth = 160;
  late final AdminPageCubit cubit;

  @override
  void initState() {
    cubit = AdminPageCubit(
        paddingSize: expandedValue ? sideBarExpandedWidth : sideBarWidth);
    super.initState();
  }

  @override
  void dispose() {
    _expandedController.close();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Stack(
        children: [
          Container(
            child: ListView(
              children: [
                Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.supervised_user_circle,
                          color: AppColors.boxesTitle,
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<AdminPageCubit, AdminPageState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is NewPageState) {
                      return state.pageWidget.build(
                          paddingSize: state.paddingSize,
                          animationDuration: animationDuration);
                    } else if (state is ResizePage) {
                      return state.pageWidget.build(
                          paddingSize: state.paddingSize,
                          animationDuration: animationDuration);
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
          Positioned(
            left: 10,
            child: IconButton(
              icon: Icon(
                Icons.format_list_bulleted_rounded,
                color: AppColors.boxesTitle,
                size: 25,
              ),
              onPressed: () {
                _expandedController.sink.add(!expandedValue);
                expandedValue = !expandedValue;
              },
            ),
          ),
          Positioned(
            top: 35,
            bottom: 0,
            left: 0,
            child: StreamBuilder<bool>(
              stream: expanded,
              initialData: expandedValue,
              builder: (context, snapshot) {
                return SideBar(
                  width: sideBarWidth,
                  widthExpanded: sideBarExpandedWidth,
                  onExpandCollapse: (newWidth) {
                    cubit.resizeEvent(newWidth);
                  },
                  duration: animationDuration,
                  expanded: snapshot.data as bool,
                  items: [
                    SideBarMainItem(
                        icon: Icons.app_registration,
                        title: 'Usuários',
                        callBack: () {
                          cubit.newPage(AddUserPage());
                        }),
                    SideBarMainItem(
                        callBack: () {
                          print('item');
                        },
                        icon: Icons.file_present,
                        title: 'Relatórios',
                        subItems: [
                          SideBarSubItem(
                              title: 'Do mes 1234',
                              callBack: () {
                                print('test sub Item');
                              }),
                          SideBarSubItem(title: 'Do'),
                          SideBarSubItem(title: 'Sempre'),
                        ]),
                    SideBarMainItem(
                        icon: Icons.admin_panel_settings_outlined,
                        title: 'Senhas'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
