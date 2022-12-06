import 'package:flutter/material.dart';
import 'package:wetrajet/Client/widget/delivery_widget.dart';
import '../widget/groups_widget.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4BE3B0),
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text("History"),
        bottom: TabBar(
          controller: _tabController,
          tabs:  [
            Tab(
              text: "GROUPS",
            ),
            Tab(
              text: "DELIVERY",
            ),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          groupWidget(),
          deliveryWidget(),
        ],
      ),
    );
  }
}
