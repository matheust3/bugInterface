import 'package:flutter/material.dart';

class SideBarMainItem {
  final void Function()? callBack;
  final IconData icon;
  final String title;
  final List<SideBarSubItem>? subItems;
  SideBarMainItem(
      {required this.title, required this.icon, this.callBack, this.subItems});
}

class SideBarSubItem {
  final String title;
  final void Function()? callBack;
  SideBarSubItem({required this.title, this.callBack});
}
