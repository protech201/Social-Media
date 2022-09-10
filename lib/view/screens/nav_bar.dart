import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:social_media/view/screens/add_post.dart';
import 'package:social_media/view/screens/feed_screen.dart';
import 'package:social_media/view/screens/login_screen.dart';
import 'package:social_media/view/screens/post_screen.dart';
import 'package:social_media/view/screens/profile_screen.dart';
import 'package:social_media/view/widgets/constans.dart';
import 'package:social_media/view/widgets/custom_dialog.dart';

PersistentTabController controller = PersistentTabController(initialIndex: 0);
class NavBar extends StatelessWidget {



  List<Widget> _buildScreens() {
    return [
      FeedScreen(),
      AddPostScreen(),
      ProfileScreen(isUser: true,)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: MainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.add,color: Colors.white,),
        // title: ("Settings"),
        activeColorPrimary: MainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        // iconSize: 44,
        title: ("profile"),
        activeColorPrimary: MainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }






  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(controller.index == 0){
          Diloge.show("هل تريد الخروج");
          return Future.value(false);
        }else{
          // SystemNavigator.pop();
          return Future.value(true);
        }
      },
      child: PersistentTabView(
        context,

        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,

// Choose the nav bar style with this property.
      ),
    );
  }
}