import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtrack/widgets/custom_navbar.dart';
import 'package:techtrack/models/bookmark_model.dart';
import 'package:techtrack/providers/bookmark_providers.dart';
import 'package:provider/provider.dart';

class DetailOppo extends StatefulWidget {
  final Map<String, dynamic> product;

  DetailOppo({required this.product, Key? key}) : super(key: key);

  @override
  State<DetailOppo> createState() => _DetailOppoState();
}

class _DetailOppoState extends State<DetailOppo> {
  bool isFavorite = false;

  void addToBookmark() {
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    final bookmarkProduct = BookmarkProduct(
      id: widget.product['id'].toString(),
      name: widget.product['phone_name'], // Mengganti 'name' ke 'phone_name'
      description: widget.product['description'],
      imageLink: widget.product['image_url'], // Mengganti 'image_link' ke 'image_url'
    );

    if (isFavorite) {
      bookmarkProvider.removeBookmarkProduct(bookmarkProduct);
      print('Removed from bookmark: ${bookmarkProduct.name}');
    } else {
      bookmarkProvider.addBookmarkProduct(bookmarkProduct);
      print('Added to bookmark: ${bookmarkProduct.name}');
    }

  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Row(
      children: [
        Icon(
          isFavorite ? Icons.cancel : Icons.check_circle,
          color: isFavorite ? Colors.white : Colors.white,
        ),
        const SizedBox(width: 8),
        Text(
          isFavorite
              ? "Product Removed from Bookmark List"
              : "Product Added to Bookmark List",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    ),
    backgroundColor: const Color.fromRGBO(67, 176, 255, 1),
    behavior: SnackBarBehavior.floating,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: addToBookmark,
            icon: Icon(
              isFavorite ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: isFavorite ? const Color.fromRGBO(67, 176, 255, 1) : null,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              Image.network(
                widget.product['image_url'],
                width: 350,
                height: 350,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.product['phone_name'], // Mengganti 'name' ke 'phone_name'
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: const Color.fromRGBO(67, 176, 255, 1)),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                widget.product['brand_name'], // Tambahkan baris ini
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
              'Product Description:', // Tambahkan baris ini
              style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.product['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0,
        onItemTapped: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/chat');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/bookmark');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
