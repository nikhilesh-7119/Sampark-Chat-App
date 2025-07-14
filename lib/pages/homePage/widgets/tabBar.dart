import 'package:flutter/material.dart';

myTabBar(TabController tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: TabBar(
      // indicator: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 4,
      labelPadding: EdgeInsets.all(5),
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      controller: tabController,
      tabs: [Text('Chats'), Text('Groups'), Text('Calls')],
    ),
  );
}
