import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String token;
  const MainPage({super.key, required this.token});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Posts",
            ),
            Tab(
              text: "My Posts",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(
            child: Text("This is Post"),
          ),
          Center(
            child: Text("This is My Post"),
          ),
        ],
      ),
    );
  }
}
