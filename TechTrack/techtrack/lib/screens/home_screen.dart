import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtrack/apis/google_api.dart';
import 'package:techtrack/apis/huawei_api.dart';
import 'package:techtrack/apis/iphone_api.dart';
import 'package:techtrack/apis/oppo_api.dart';
import 'package:techtrack/apis/samsung_api.dart';
import 'package:techtrack/apis/vivo_api.dart';
import 'package:techtrack/apis/xiaomi_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:techtrack/widgets/custom_navbar.dart';
import 'package:techtrack/providers/authentication_service.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({required this.username, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthenticationService>();
    final user = authService.user;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/techtracklogo.png',
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome! ${user?.usrName ?? widget.username}',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(67, 176, 255, 1),
                            ),
                          ),
                          Text(
                            'Member of TechTrack',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 25, 25, 25),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: TextField(
                          cursorColor: const Color.fromRGBO(67, 176, 255, 1),
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Smartphones',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear_all_rounded),
                                onPressed: () => _searchController.clear(),
                              ),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                              ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                  ),
                  // Image slider
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150.0,
                      aspectRatio: 16/9,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true, // Enable auto-scroll
                      autoPlayInterval: const Duration(seconds: 3), // Adjust the interval
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    ),
                    items: [
                      'assets/news1.jpeg',
                      'assets/news2.jpg',
                      'assets/news3.jpg',
                      'assets/news4.jpg',
                      'assets/news5.jpg',
                    ].map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Recommendation Brand',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(67, 176, 255, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  imageCard(context, 'assets/samsung.jpg', 'Samsung',
                      const SamsungApi()),
                  const SizedBox(
                    height: 10,
                  ),
                  imageCard(context, 'assets/xiaomi.jpg', 'Xiaomi',
                      const XiaomiApi()),
                  const SizedBox(
                    height: 10,
                  ),
                  imageCard(context, 'assets/iphone.jpg', 'Iphone',
                      const IphoneApi()),
                  const SizedBox(
                    height: 10,
                  ),
                  imageCard(context, 'assets/google.jpg', 'Google',
                      const GoogleApi()),
                  const SizedBox(
                    height: 10,
                  ),
                  imageCard(context, 'assets/huawei.jpg', 'Huawei',
                      const HuaweiApi()),
                  const SizedBox(
                    height: 10,
                  ),
                  imageCard(context, 'assets/oppo.jpg', 'Oppo', 
                      const OppoApi()),
                  const SizedBox(
                    height: 10,
                  ),
                  imageCard(context, 'assets/vivo.jpg', 'Vivo', 
                      const VivoApi()),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
          bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 0,
          onItemTapped: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/techtalk');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/bookmark');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          }),
    );
  }
}

Widget imageCard(BuildContext context, String imagePath, String title,
        Widget destinationPage) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destinationPage));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
              image: AssetImage(imagePath),
              height: 120,
              fit: BoxFit.cover,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                shadows: [
                  const Shadow(
                    blurRadius: 20.0,
                    color: Colors.black,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
