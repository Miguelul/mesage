import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymtesis/screens/home/home_page.dart';
import 'package:provider/provider.dart';

import '../../constanst.dart';
import '../me/me.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
  
    tabController.index = selectedIndex;
    // ignore: no_leading_underscores_for_local_identifiers
    void _handleTabSelection() {
      if (tabController.indexIsChanging) {
        setState(() {
          selectedIndex = tabController.index;
        });
      }
    }

//  if(tabController.index==2){
//     Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const MentalPage()));
//   }
    tabController.addListener(_handleTabSelection);

    return WillPopScope(
      onWillPop: (() async {
        SystemNavigator.pop();
        return false;
      }),
      child: Scaffold(
        // ignore: prefer_const_literals_to_create_immutables
        body: TabBarView(
          physics:const NeverScrollableScrollPhysics(),
          controller: tabController, children: const [
          HomePage(),
          MePage1(),
          MePage(),
        ]),
    
        // ignore: prefer_const_literals_to_create_immutables
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: kBackgroundColor,
          ),
          child: SizedBox(
            height: 50,
            child: BottomNavigationBar(
                selectedItemColor: kPrimaryColor,
                unselectedItemColor: const Color.fromARGB(255, 107, 106, 106),
                currentIndex: selectedIndex = tabController.index,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                // selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
                // unselectedItemColor: const Color.fromARGB(255, 77, 76, 76),
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
    
                  
                  });
                },
                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_filled,
                        size: 20,
                      ),
                      label: 'Inicio'),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.plus_rectangle_on_rectangle,
                        size: 20,
                      ),
                      label: 'Mi post'),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 20,
                      ),
                      label: 'Yo'),
                ]),
          ),
        ),
      ),
    );
  }
}
