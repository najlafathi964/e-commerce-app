import 'package:flutter/material.dart';
import 'package:food_delivary_app/screens/account_screen.dart';
import 'package:food_delivary_app/screens/cart/cart_history.dart';
import 'package:food_delivary_app/screens/cart/cart_screen.dart';
import 'package:food_delivary_app/screens/main_screen.dart';
import 'package:food_delivary_app/screens/order/order_screen.dart';
import '../shared/app_colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  late PersistentTabController _controller ;
  List<Widget> _buildScreens() {
    return [
      MainScreen(),
      OrderScreen(),
      CartHistory(),
      AccountScreen()

    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(){
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home) ,
          title: 'Home' ,
          activeColorPrimary: AppColors.mainColor ,
        inactiveColorPrimary: Colors.amberAccent
      ) ,
      PersistentBottomNavBarItem(
          icon: Icon(Icons.archive) ,
          title: 'Archive' ,
          activeColorPrimary: AppColors.mainColor ,
          inactiveColorPrimary: Colors.amberAccent
      ) ,
      PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_cart) ,
          title: 'Cart' ,
          activeColorPrimary: AppColors.mainColor ,
          inactiveColorPrimary: Colors.amberAccent
      ) ,
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person) ,
          title: 'Me' ,
          activeColorPrimary: AppColors.mainColor ,
          inactiveColorPrimary: Colors.amberAccent
      )
    ];
  }
  @override
  initState(){
    super.initState();
    _controller= PersistentTabController(initialIndex: 0);
  }
  onTapNav(int index) {
    setState(() {
      index = selectedIndex;
    });
  }
/*
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: pages[selectedIndex],
     bottomNavigationBar: BottomNavigationBar(
       selectedItemColor: AppColors.mainColor,
       unselectedItemColor: Colors.amberAccent ,
       onTap: onTapNav,
       currentIndex : selectedIndex ,
       items: [
         BottomNavigationBarItem(icon: Icon(Icons.home_outlined) , label: 'home') ,
         BottomNavigationBarItem(icon: Icon(Icons.archive) , label: 'history') ,
         BottomNavigationBarItem(icon: Icon(Icons.shopping_cart) , label: 'cart') ,
         BottomNavigationBarItem(icon: Icon(Icons.person) , label: 'me') ,
       ],
     ),

   );
  }

*/

@override
  Widget build (BuildContext context){
  return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens() ,
    items: _navBarItems(),
    confineInSafeArea: true,
    backgroundColor: Colors.white,
    handleAndroidBackButtonPress: true,
    resizeToAvoidBottomInset: true,
    stateManagement: true,
    hideNavigationBarWhenKeyboardShows: true,
    decoration: NavBarDecoration(
      borderRadius: BorderRadius.circular(10) ,
      colorBehindNavBar: Colors.white
    ),
    popAllScreensOnTapOfSelectedTab: true,
    popActionScreens: PopActionScreensType.all,
    itemAnimationProperties: ItemAnimationProperties(
      duration: Duration(microseconds: 200) ,
      curve: Curves.ease
    ),
    screenTransitionAnimation: ScreenTransitionAnimation(
      animateTabTransition: true ,
      curve: Curves.ease ,
      duration: Duration(microseconds: 200)
    ),
    navBarStyle: NavBarStyle.style4,
  ) ;
}

}