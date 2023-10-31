import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtrack/helper/database_helper.dart';
import 'package:techtrack/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:techtrack/providers/authentication_service.dart';
import 'package:techtrack/widgets/custom_navbar.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({required this.username, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isVisible = false;
  late DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.username;
    databaseHelper = DatabaseHelper();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> updateAccount(String newUsername, String newPassword) async {
    final authService = context.read<AuthenticationService>();
    final user = authService.user;

    if (user != null) {
      int userId = user.usrId ?? 0;
      await databaseHelper.updateAccount(userId, newUsername, newPassword);

      authService.setUser(UserModel(
        usrId: userId,
        usrName: newUsername,
        usrPassword: newPassword,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Profile updated successfully!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
        usernameController.text = newUsername;
        passwordController.text = newPassword;
        confirmPasswordController.text = newPassword;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User is null. Unable to update account.'),
        ),
      );
    }
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log Out Confirmation"),
          content: const Text("Are you sure you want to Log Out?"),
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
                final authService = context.read<AuthenticationService>();
                authService.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthenticationService>();
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 25, 25, 25)),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Color.fromRGBO(67, 176, 255, 1)),
                    title: const Text('Log Out',
                        style: TextStyle(color: Color.fromRGBO(67, 176, 255, 1)),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text('Log Out "${user?.usrName ?? widget.username}"'),
                                  onTap: () {
                                Navigator.pop(context); // Tutup bottom sheet
                                showLogoutDialog(context); // Tampilkan dialog logout
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Material(
                elevation: 5,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('assets/techtrackavatar.png'),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: '${user?.usrName ?? widget.username}',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 238, 248, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 238, 248, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: !isVisible,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 238, 248, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: !isVisible,
              ),
              const SizedBox(height: 25.0),
              Container(
                height: 55,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final updatedUsername = usernameController.text;
                      final updatedPassword = passwordController.text;
                      final updatedConfirmPassword =
                          confirmPasswordController.text;

                      if (updatedPassword == updatedConfirmPassword) {
                        updateAccount(updatedUsername, updatedPassword);

                        usernameController.text = '';
                        passwordController.text = '';
                        confirmPasswordController.text = '';
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Password and Confirm Password do not match'),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color.fromRGBO(67, 176, 255, 1)),
                    ),
                    child: const Center(
                      child: Text(
                        'Edit Account',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 3,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/techtalk');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/bookmark');
          }
        },
      ),
    );
  }
}
