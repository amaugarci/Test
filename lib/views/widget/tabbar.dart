import 'package:flutter/material.dart';
import 'package:test/views/widget/indicator.dart';

class TabBarWidget extends StatefulWidget {
  final double? padding;
  final bool? isScrollable;
  final TabController tabController;
  final List<String> tabMenus;
  final VoidCallback onpress;
  const TabBarWidget(
      {Key? key,
      required this.tabMenus,
      required this.tabController,
      this.padding = 12,
      this.isScrollable = true,
      required this.onpress})
      : super(key: key);
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            indicator: CircleTabIndicator(color: Colors.blue, radius: 15),
            padding: EdgeInsets.only(left: 9, top: 0, right: 1, bottom: 3),
            labelPadding: EdgeInsets.only(
                left: widget.padding!,
                top: 4,
                right: widget.padding!,
                bottom: 8),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.lightBlue,
            indicatorColor: Colors.lightBlue,
            indicatorWeight: 2,
            indicatorSize: widget.isScrollable!
                ? TabBarIndicatorSize.label
                : TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.only(bottom: -1, left: 4, right: 4),
            isScrollable: widget.isScrollable!,
            onTap: (value) {
              widget.onpress();
            },
            tabs: [
              for (final tabMenu in widget.tabMenus) _buildTab(tabMenu),
            ],
            controller: widget.tabController,
          ),
        ],
      ),
    );
  }
}

Tab _buildTab(String tabMenu) {
  return Tab(
    height: 18,
    child: Text(
      tabMenu,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Hiragino Kaku Gothic Pro w6",
        fontSize: 12,
        letterSpacing: 0.3,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
