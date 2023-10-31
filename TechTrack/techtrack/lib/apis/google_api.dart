import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtrack/apis/google_detail.dart';

class GoogleApi extends StatefulWidget {
  const GoogleApi({Key? key}) : super(key: key);

  @override
  State<GoogleApi> createState() => _GoogleApiState();
}

class _GoogleApiState extends State<GoogleApi> {
  List<Map<String, dynamic>> googleData = [];

  @override
  void initState() {
    super.initState();
    fetchGoogleApi();
  }

  Future<void> fetchGoogleApi() async {
    final dio = Dio();

    dio.options.headers['X-RapidAPI-Key'] = 'cfc7f94bb2msh7b6a428d66cec19p10b296jsn7aedd84b04e7';
    dio.options.headers['X-RapidAPI-Host'] = 'mobile-phones2.p.rapidapi.com';

    try {
      final response = await dio.get('https://mobile-phones2.p.rapidapi.com/107/phones');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];

        final filteredData = List<Map<String, dynamic>>.from(dataList)
            .where((item) =>
                item['image_url'] != null &&
                item['image_url'].startsWith("http"))
            .toList();

        setState(() {
          googleData = filteredData;
        });
      } else {
        print('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget apiCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        navigateToProductDetail(context, item);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Container(
          width: 180,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: Image.network(item['image_url']),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${item['phone_name']}',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(67, 176, 255, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${item['brand_name']}',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToProductDetail(BuildContext context, Map<String, dynamic> product) {
    Navigator.push(
      context,
        MaterialPageRoute(
          builder: (context) => DetailGoogle(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Google Gadgets',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: googleData.isEmpty
            ? const CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: googleData.length,
                itemBuilder: (context, index) {
                  final item = googleData[index];
                  return apiCard(context, item);
                },
              ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: GoogleApi(),
        ),
      ),
    ),
  );
}
