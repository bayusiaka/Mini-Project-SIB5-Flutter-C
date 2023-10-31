import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationScreen extends StatelessWidget {
  final Map<String, dynamic>? responseData;

  RecommendationScreen({Key? key, required this.responseData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'TechTalk AI',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 25, 25, 25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'Here is your Recommendation by TechTalk AI!',
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w500),
            )),
            const SizedBox(height: 5),
            if (responseData != null && responseData!['choices'] != null)
              Column(
                children: responseData!['choices'].map<Widget>((choice) {
                  return Card(
                    color: const Color.fromRGBO(67, 176, 255, 1),
                    elevation: 2,
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        choice['message']['content'] ??
                            "No recommendation text available",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 16, color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              const Text("No recommendations available"),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}