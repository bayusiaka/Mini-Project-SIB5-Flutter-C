import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:techtrack/providers/bookmark_providers.dart';
import 'package:techtrack/widgets/custom_navbar.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final bookmarkProducts = bookmarkProvider.bookmarkProducts;

    print("Total Bookmark Products: ${bookmarkProducts.length}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmark Products',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 25, 25, 25),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: bookmarkProducts.isEmpty
    ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bookmark.png',
              width: 200,
            ),
            const SizedBox(height: 16),
            const Text(
              "No Bookmarked Products",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
              itemCount: bookmarkProducts.length,
              itemBuilder: (context, index) {
                final bookmarkProduct = bookmarkProducts[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.network(
                        bookmarkProduct.imageLink,
                        width: double.infinity,
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          bookmarkProduct.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: const Color.fromRGBO(67, 176, 255, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          bookmarkProduct.description,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.bookmark_rounded,
                                color: Color.fromRGBO(67, 176, 255, 1),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Remove from Bookmarks?"),
                                      content: const Text(
                                        "Are you sure to remove this product from your bookmarked list?",
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text("No"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Text("Yes"),
                                          onPressed: () {
                                            bookmarkProvider
                                                .removeBookmarkProduct(
                                                    bookmarkProduct);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 2,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/techtalk');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
