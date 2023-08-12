import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/app_colors.dart';
import 'package:mobile/constants/app_strings.dart';
import 'package:mobile/views/home_screen.dart';
import 'package:mobile/views/section_screen.dart';
import 'package:mobile/views/weekly_screens.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

final List<Widget> _children = [
  const MyHomeScreen(),
  const MyWeeklySegmentScreen(),
  const MySectionScreen(),
];

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  void _onChangePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(AkarIcons.home),
              tooltip: AppString.home,
              color: 0 == _currentIndex
                  ? Theme.of(context).brightness == Brightness.light
                      ? AppColors.black
                      : AppColors.white
                  : AppColors.grey,
              onPressed: () {
                _onChangePage(0);
              },
            ),
            IconButton(
              icon: const Icon(AkarIcons.globe),
              tooltip: AppString.weekly,
              color: 1 == _currentIndex
                  ? Theme.of(context).brightness == Brightness.light
                      ? AppColors.black
                      : AppColors.white
                  : AppColors.grey,
              onPressed: () {
                _onChangePage(1);
              },
            ),
            IconButton(
              icon: const Icon(AkarIcons.dashboard),
              tooltip: AppString.section,
              color: 2 == _currentIndex
                  ? Theme.of(context).brightness == Brightness.light
                      ? AppColors.black
                      : AppColors.white
                  : AppColors.grey,
              onPressed: () {
                _onChangePage(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
