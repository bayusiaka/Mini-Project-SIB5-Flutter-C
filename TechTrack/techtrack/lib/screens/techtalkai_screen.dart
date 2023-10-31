import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtrack/widgets/custom_navbar.dart';
import 'package:techtrack/providers/smartphone_providers.dart';
import 'package:techtrack/screens/recommendation_screen.dart';
import 'package:provider/provider.dart';

class SmartphoneRecommendationScreen extends StatefulWidget {
  const SmartphoneRecommendationScreen({Key? key});

  @override
  State<SmartphoneRecommendationScreen> createState() =>
      _SmartphoneRecommendationScreenState();
}

class _SmartphoneRecommendationScreenState
    extends State<SmartphoneRecommendationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _brandPreferenceController = TextEditingController();
  final TextEditingController _operatingSystemController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final recommendationProvider =
        Provider.of<SmartphoneRecommendationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TechTalk AI',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 25, 25, 25),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/techtalkai.png'),
                  height: 180,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  cursorColor: const Color.fromRGBO(67, 176, 255, 1),
                  controller: _budgetController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 238, 248, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Budget',
                    hintText: 'Enter your budget',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your budget';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  cursorColor: const Color.fromRGBO(67, 176, 255, 1),
                  controller: _brandPreferenceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 238, 248, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Brand Preference',
                    hintText: 'Enter brand preference (optional)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  cursorColor: const Color.fromRGBO(67, 176, 255, 1),
                  controller: _operatingSystemController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 238, 248, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Operating System',
                    hintText: 'Enter operating system (optional)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(30, 50)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(67, 176, 255, 1)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await recommendationProvider.getRecommendations(
                              budget: _budgetController.text,
                              brandPreference: _brandPreferenceController.text,
                              operatingSystem: _operatingSystemController.text,
                            );

                            if (recommendationProvider.recommendation != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RecommendationScreen(
                                        responseData: recommendationProvider
                                            .recommendation!);
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('An error occurred.'),
                                ),
                              );
                            }

                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Let's Rock!",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
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