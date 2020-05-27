import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelalot/blocs/navigation/navigation_bloc.dart';


import 'archive_page.dart';
import 'home_page.dart';
import 'settings_page.dart';

class TabPage extends StatefulWidget {
  final Map<String, String> headers;

  const TabPage({Key key, this.headers}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  void _pageDirector(int index, BuildContext context) {
    // ignore: close_sinks
    var provider = BlocProvider.of<NavigationBloc>(context);
    switch (index) {
      case 0:
        provider.add(NavigationEvent.Home);
        break;
      case 1:
        provider.add(NavigationEvent.Archived);
        break;
      case 2:
        provider.add(NavigationEvent.Settings);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationEvent>(
        builder: (context, state) => BottomNavigationBar(
          currentIndex: state.index,
          onTap: (value) => _pageDirector(value, context),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: SizedBox.shrink(),
            ),
          ],
        ),
      ),
      body: BlocBuilder<NavigationBloc, NavigationEvent>(
        builder: (context, state) {
          switch (state) {
            case NavigationEvent.Home:
              return HomePage();
            case NavigationEvent.Archived:
              return ArchivePage();
            case NavigationEvent.Settings:
              return SettingsPage();
          }
          return Center(
            child: Icon(Icons.error),
          );
        },
      ),
    );
  }
}
