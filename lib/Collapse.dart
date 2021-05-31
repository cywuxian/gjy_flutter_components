import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './utils/Gaps.dart';

enum ArrowDirection{
  up,
  down,
  left,
  right
}

// from https://github.com/allan-hx/flutter-weui/blob/master/weui/lib/collapse/index.dart
class Collapse extends StatefulWidget {
  // 数据
  final List<CollapseItem> children;
  // 默认展示
  final List<String> defaultActive;
  // 动画过度时间
  final int duration;
  // 卡片展示
  final bool card;
  // 卡片间距
  final double clearance;
  // 渲染标题
  final Widget Function(bool open, int index, Widget child) buildTitle;
  // 渲染内容
  final Widget Function(bool open, int index, Widget child) buildContent;
  // 变化回调
  final Function(List<String>) onChange;
  // 手风琴模式
  final bool accordion;
  // 默认箭头方向
  final ArrowDirection defaultArrow;
  // 展开箭头方向
  final ArrowDirection expandedArrow;



  Collapse({
    Key key,
    @required this.children,
    this.defaultActive,
    this.duration = 150,
    this.card = false,
    this.clearance = 13.0,
    this.buildTitle,
    this.buildContent,
    this.onChange,
    this.accordion = false,
    this.defaultArrow = ArrowDirection.right,
    this.expandedArrow = ArrowDirection.down,
  }): super(key: key);

  @override
  CollapseState createState() => CollapseState();
}

class CollapseState extends State<Collapse> {
  // 内容左右padding
  double borderPadding = 19.0;
  // title左右padding
  final double titleOrSoPadding = 19.0;
  // 上下padding
  final double titleUpAndDownPadding = 13.0;
  // 边框
  Widget border;
  // 当前激活
  List<String> activeIndex = [];

  @override
  void initState() {
    super.initState();

    if (widget.card) {
      borderPadding = 0.0;
    }

    if (widget.defaultActive != null) {
      activeIndex = widget.defaultActive;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    border = Divider(height: 1, color: Theme.of(context).dividerColor);
  }

  void onClick(String key) {
    List<String> activeList = activeIndex;
    if (activeList.indexOf(key) >= 0) {
      activeList.remove(key);
    } else {
      // 手风琴模式判断
      if (widget.accordion) {
        activeList = [key];
      } else {
        activeList.add(key);
      }
    }

    setState(() {
      activeIndex = activeList;
    });

    if (widget.onChange is Function) widget.onChange(activeList);
  }

  // 渲染title
  Widget buildTitle(String key, int index, CollapseItem item) {
    final bool checked = activeIndex.indexOf(key) >= 0;
    Widget titleWidget;

    if (widget.buildTitle is Function) {
      titleWidget = widget.buildTitle(checked, index, item.title);
    } else {
      titleWidget = Padding(
          padding: EdgeInsets.only(
              top: titleUpAndDownPadding,
              right: titleOrSoPadding,
              bottom: titleUpAndDownPadding,
              left: titleOrSoPadding
          ),
          child: Row(
              children: [
                // title
                Expanded(
                    flex: 1,
                    child: DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff333333)
                        ),
                        child: item.title
                    )
                ),
                // icon
                item.itemShowArrow ? Transform.rotate(
                    angle: checked ? renderArrow(widget.expandedArrow) : renderArrow(widget.defaultArrow),
                    child: Icon(Icons.arrow_forward_ios, size: 14.0, color: Color(0xff969799))
                ) : Gaps.empty
              ]
          )
      );
    }

    return  InkWell(
        onTap: item.itemShowArrow ? () {
          onClick(key);
        } : null,
        child: titleWidget
    );
  }

  // 渲染内容
  Widget buildContent(bool open, int index, Widget content) {
    Widget childWidget;

    if (widget.buildContent is Function) {
      childWidget = widget.buildContent(open, index, content);
    } else {
      childWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: borderPadding
                ),
                child: widget.card ? Gaps.empty :  border
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: titleOrSoPadding,
                    right: titleOrSoPadding,
                    bottom: titleOrSoPadding,
                    left: titleOrSoPadding
                ),
                child: content
            )
          ]
      );
    }

    return Align(
        alignment: Alignment.centerLeft,
        child: DefaultTextStyle(
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black
            ),
            child: childWidget
        )
    );
  }

  Widget buildItem(String key, int index, CollapseItem item) {
    final List<Widget> children = [buildTitle(key, index, item)];
    final bool open = activeIndex.indexOf(key) >= 0;

    // 内容
    children.add(
        AnimatedCrossFade(
            firstChild: Container(),
            secondChild: buildContent(open, index, item.child),
            firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
            secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState: open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: widget.duration)
        )
    );

    return Column(
        children: children
    );
  }

  renderArrow (type) {
    if (type == ArrowDirection.up) return (-90 ~/ 30) * 30.0 * 0.0174533;
    if (type == ArrowDirection.down) return (90 ~/ 30) * 30.0 * 0.0174533;
    if (type == ArrowDirection.right) return (-180 ~/ 30) * 30.0 * 0.0174533;
    if (type == ArrowDirection.left) return (180 ~/ 30) * 30.0 * 0.0174533;
  }

  renderChildren(list) {
    final List<Widget> children = [];

    // 遍历
    for (int index = 0; index < list.length; index++) {
      final item = list[index];
      final key = item.key == null ? index.toString() : item.key;
      final Widget child = Material(
          color: Colors.white,
          child: buildItem(key, index, item)
      );

      // 判断是否卡片样式
      if (widget.card) {
        children.add(
            Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0.0 : widget.clearance),
                child: child
            )
        );
      } else {
        children.add(border);
        children.add(child);
      }
    }

    // 默认边框
    if (widget.card == false)
      children.add(border);

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
            children: renderChildren(widget.children)
        )
    );
  }
}

class CollapseItem {
  // key
  final String key;
  // 标题
  final Widget title;
  // 内容
  final Widget child;
  // 是否显示箭头
  final bool itemShowArrow;

  CollapseItem({
    this.key,
    @required this.title,
    @required this.child,
    this.itemShowArrow = true,
  });
}