import 'package:assist_agro/core/util/app_colors.dart';
import 'package:assist_agro/core/util/app_fonts.dart';
import 'package:assist_agro/features/admin/presentation/widgets/side_bar/side_bar_main_item.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  final List<SideBarMainItem> items;
  final Duration duration;
  final bool expanded;
  final double width;
  final double widthExpanded;

  final void Function(double newWidth)? onExpandCollapse;
  const SideBar(
      {Key? key,
      required this.items,
      required this.duration,
      required this.width,
      required this.widthExpanded,
      this.expanded = false,
      this.onExpandCollapse})
      : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with TickerProviderStateMixin {
  late final _SideBarController _controller;
  final double _arrowDownItem = 20;
  @override
  void initState() {
    super.initState();
    _controller = _SideBarController(
      vsync: this,
      onExpandCollapse: widget.onExpandCollapse,
      duration: widget.duration,
      width: widget.width,
      widthExpanded: widget.widthExpanded,
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.setExpanded = widget.expanded;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => MouseRegion(
        onHover: (event) => _controller.onMouseOver(),
        onExit: (event) => _controller.onMouseExit(),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: EdgeInsets.only(top: 10, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 50, 89, 244),
                Color.fromARGB(255, 29, 140, 248)
              ],
              stops: [0.1, 0.9],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: _controller._defaultExpandedWidth,
                minWidth: _controller._defaultWidth),
            child: SizeTransition(
              axisAlignment: -1,
              sizeFactor: _controller.animation,
              axis: Axis.horizontal,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: (_controller._defaultWidth -
                                    _controller.iconsItemsSize) /
                                2),
                        child: Icon(
                          Icons.ac_unit,
                          size: _controller.iconsItemsSize,
                        ),
                      ),
                      AnimatedContainer(
                        duration: _controller.duration,
                        width: _controller.width,
                        child: Divider(
                          color: AppColors.sideBarElementsColor,
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.5,
                          height: 30,
                        ),
                      ),
                      ...List.generate(
                        widget.items.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              left: (_controller._defaultWidth -
                                          _controller.iconsItemsSize) /
                                      2 -
                                  (_controller.selectedItemIndex == index
                                      ? 5
                                      : 0),
                              bottom: 10),
                          child: TextButton(
                            onPressed: () {
                              if (widget.items[index].subItems != null) {
                                _controller.collapseExpandItem(index);
                              } else {
                                _controller.selectItem(index);
                              }
                              if (widget.items[index].callBack != null)
                                widget.items[index].callBack!();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _controller.selectedItemIndex == index
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top:
                                                _controller.iconsItemsSize / 2 -
                                                    2.5),
                                        width: 5,
                                        height: 5,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                AppColors.sideBarElementsColor),
                                      )
                                    : Container(),
                                Icon(
                                  widget.items[index].icon,
                                  size: _controller.iconsItemsSize,
                                  color: AppColors.sideBarElementsColor,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 10,
                                      top: _controller.iconsItemsSize / 2 -
                                          (AppFonts.sideBarMainItems.fontSize
                                                  as double) /
                                              1.5),
                                  width: _controller._defaultExpandedWidth -
                                      _controller._defaultWidth -
                                      _arrowDownItem,
                                  child: FadeTransition(
                                    opacity: _controller.animation,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.items[index].title,
                                          style: AppFonts.sideBarMainItems,
                                        ),
                                        Builder(builder: (context) {
                                          _controller.createAnimationController(
                                              index, this);
                                          final subItemController = _controller
                                              .getSubItemAnimationController(
                                                  index) as _SubItemAnimation;
                                          final subItems =
                                              widget.items[index].subItems ??
                                                  [];
                                          return SizeTransition(
                                            sizeFactor:
                                                subItemController.animation,
                                            axis: Axis.vertical,
                                            axisAlignment: -1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: List.generate(
                                                subItems.length,
                                                (subItemIndex) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    (_controller.selectedItemIndex ==
                                                                index &&
                                                            _controller
                                                                    .selectedSubItemIndex ==
                                                                subItemIndex)
                                                        ? Container(
                                                            width: 5,
                                                            height: 5,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 2),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .sideBarElementsColor,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            width: 7,
                                                          ),
                                                    TextButton(
                                                      style: ButtonStyle(
                                                          alignment: Alignment
                                                              .centerLeft),
                                                      onPressed: () {
                                                        _controller
                                                            .selectSubItem(
                                                                index,
                                                                subItemIndex);
                                                        if (subItems[
                                                                    subItemIndex]
                                                                .callBack !=
                                                            null)
                                                          subItems[subItemIndex]
                                                              .callBack!();
                                                      },
                                                      child: Text(
                                                        subItems[subItemIndex]
                                                            .title,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppFonts
                                                            .sideBarMainItems,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                                widget.items[index].subItems != null
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                _controller.iconsItemsSize / 2 -
                                                    _arrowDownItem / 2),
                                        child: Builder(builder: (context) {
                                          final subItemController = _controller
                                              .getSubItemAnimationController(
                                                  index) as _SubItemAnimation;

                                          return Icon(
                                            subItemController.expanded
                                                ? Icons.arrow_drop_up
                                                : Icons.arrow_drop_down,
                                            size: _arrowDownItem,
                                            color:
                                                AppColors.sideBarElementsColor,
                                          );
                                        }),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubItemAnimation {
  final parentId;
  late final AnimationController animationController;
  late final Animation<double> animation;
  final Duration _expandDuration = Duration(milliseconds: 300);

  bool expanded = false;

  _SubItemAnimation({required this.parentId, required vsync}) {
    animationController = AnimationController(
      duration: _expandDuration,
      reverseDuration: _expandDuration,
      vsync: vsync,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
  }

  void expandCollapse() {
    if (expanded) {
      expanded = false;
      animationController.animateTo(0);
    } else {
      expanded = true;
      animationController.animateTo(1);
    }
  }
}

class _SideBarController extends ChangeNotifier {
  final void Function(double newWidth)? onExpandCollapse;
  bool mouseOver = false;
  List<_SubItemAnimation> subItemsAnimationController = [];
  ValueNotifier<bool> _expanded = ValueNotifier<bool>(false);
  set setExpanded(bool e) => _expanded.value = e;
  late final AnimationController animationController;
  late final Animation<double> animation;
  final animationCurve = Curves.linear;
  final Duration duration;

  final double _defaultWidth;
  final double _defaultExpandedWidth;
  final double iconsItemsSize = 28;
  late double width;

  int selectedItemIndex = 0;
  int selectedSubItemIndex = -1;

  _SideBarController(
      {required TickerProvider vsync,
      required this.duration,
      required double width,
      required double widthExpanded,
      this.onExpandCollapse})
      : _defaultWidth = width,
        _defaultExpandedWidth = widthExpanded {
    animationController = AnimationController(
      lowerBound: _defaultWidth / _defaultExpandedWidth,
      duration: duration,
      reverseDuration: duration,
      vsync: vsync,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: animationCurve,
    );
    this.collapse();
    _expanded.addListener(() {
      if (_expanded.value == true) {
        this.expand();
      } else {
        this.collapse();
      }
    });
  }
  void selectSubItem(int itemId, int subItem) {
    selectedItemIndex = itemId;
    selectedSubItemIndex = subItem;
    notifyListeners();
  }

  void selectItem(int itemId) {
    selectedItemIndex = itemId;
    notifyListeners();
  }

  void createAnimationController(int itemId, dynamic vsync) {
    subItemsAnimationController
        .add(_SubItemAnimation(parentId: itemId, vsync: vsync));
  }

  _SubItemAnimation? getSubItemAnimationController(int itemId) {
    for (_SubItemAnimation e in subItemsAnimationController) {
      if (e.parentId == itemId) {
        return e;
      }
    }
    return null;
  }

  void collapseExpandItem(int itemId) {
    final animationController =
        getSubItemAnimationController(itemId) as _SubItemAnimation;
    animationController.expandCollapse();
    notifyListeners();
  }

  void onMouseOver() {
    if (!mouseOver && !this._expanded.value) {
      this.expand();
    }
  }

  void expand() {
    animationController.animateTo(1);
    mouseOver = !mouseOver;
    width = this._defaultExpandedWidth;
    if (this.onExpandCollapse != null) this.onExpandCollapse!(width);
    notifyListeners();
  }

  void collapse() {
    animationController.animateBack(0);
    mouseOver = !mouseOver;
    width = this._defaultWidth;
    if (this.onExpandCollapse != null) this.onExpandCollapse!(width);
    notifyListeners();
  }

  void onMouseExit() {
    if (mouseOver && !this._expanded.value) {
      this.collapse();
    }
  }
}
