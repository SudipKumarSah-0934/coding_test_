import 'package:coding_test_/screens/components/custom_carousel_slider.dart';
import 'package:coding_test_/screens/components/custom_circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0), // here the desired height
        child: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/splash.png')),
              const Text(
                'Fluxstore',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCircularIcon(
                  categoryIcon: Icons.male,
                  categoryType: 'Men',
                ),
                CustomCircularIcon(
                    categoryIcon: Icons.female, categoryType: 'Women'),
                CustomCircularIcon(
                    categoryIcon: Icons.close_outlined,
                    categoryType: 'Clothing'),
                CustomCircularIcon(
                    categoryIcon: Icons.local_post_office_rounded,
                    categoryType: 'Posters'),
                CustomCircularIcon(
                    categoryIcon: Icons.male, categoryType: 'Music'),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Column(
            children: [
              SizedBox(
                height: 200.0,
                child: CustomCarouselSlider(),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 200.0,
                width: double.infinity,
                child: InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.blue),
                  onTap: () {},
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/watch-3.jpg',
                            fit: BoxFit.fitWidth,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: const TextSpan(
                              text: 'For Gen\n',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 178, 181, 184),
                                  fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Hangout Party',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 245, 246, 247),
                                      fontSize: 18),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 200.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.blue),
                        onTap: () {},
                        child:
                            Stack(alignment: Alignment.centerRight, children: [
                          SizedBox(
                              width: double.maxFinite,
                              child: Image.asset(
                                'assets/watch-3.jpg',
                                fit: BoxFit.fitWidth,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: const TextSpan(
                                  text: 'For Gen\n',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 178, 181, 184),
                                      fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Hangout Party',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 246, 247),
                                          fontSize: 18),
                                    )
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.blue),
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            SizedBox(
                                width: double.maxFinite,
                                child: Image.asset(
                                  'assets/watch-3.jpg',
                                  fit: BoxFit.fitWidth,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                text: const TextSpan(
                                    text: 'For Gen\n',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 178, 181, 184),
                                        fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Hangout Party',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 245, 246, 247),
                                            fontSize: 18),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GNav(
        activeColor: const Color.fromARGB(255, 154, 206, 236),
        gap: 2.0,
        tabs: const [
          GButton(
            icon: Icons.home_rounded,
            text: 'Shop',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.shopping_bag_outlined,
            text: 'Carts',
          ),
          GButton(
            icon: Icons.account_circle_rounded,
            text: 'Profile',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
