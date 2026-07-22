import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  // Password visibility
  bool _obscurePassword = true;

  // Controllers
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ------------------------------------------------------------
      // APP BAR
      // ------------------------------------------------------------
      appBar: AppBar(
        title: const Text("Property Manager"),
        backgroundColor: const Color(0xFF008FA3),
        foregroundColor: Colors.white,
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      // ------------------------------------------------------------
      // BODY
      // ------------------------------------------------------------
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF006978),
              Color(0xFF008FA3),
              Color(0xFF00BCD4),
            ],
          ),
        ),

        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    
                    // App Description
                    const Text(
                      "Rental Management System",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Manage your properties, tenants and rent with ease.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    // ------------------------------------------------
                    // LOGIN CARD
                    // ------------------------------------------------

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [

                          // ------------------------------------------------
                          // PROPERTY IMAGE
                          // ------------------------------------------------

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),

                            child: Image.asset(
                              "assets/property.jpg",
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,

                              // Display a fallback icon if image has an issue
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: 180,
                                  color: const Color(0xFFE0F7FA),

                                  child: const Icon(
                                    Icons.home_work_rounded,
                                    size: 70,
                                    color: Color(0xFF008FA3),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ------------------------------------------------
                          // WELCOME TEXT
                          // ------------------------------------------------

                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006978),
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Login to manage your rental properties",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 25),

                          // ------------------------------------------------
                          // USERNAME LABEL
                          // ------------------------------------------------

                          const Align(
                            alignment: Alignment.centerLeft,

                            child: Text(
                              "Username",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // ------------------------------------------------
                          // USERNAME FIELD
                          // ------------------------------------------------

                          TextField(
                            controller: usernameController,

                            decoration: InputDecoration(
                              hintText: "Enter your username",

                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Color(0xFF008FA3),
                              ),

                              filled: true,
                              fillColor: Colors.grey.shade100,

                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15),

                                borderSide: const BorderSide(
                                  color: Color(0xFF008FA3),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ------------------------------------------------
                          // PASSWORD LABEL
                          // ------------------------------------------------

                          const Align(
                            alignment: Alignment.centerLeft,

                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // ------------------------------------------------
                          // PASSWORD FIELD
                          // ------------------------------------------------

                          TextField(
                            controller: passwordController,

                            obscureText: _obscurePassword,

                            decoration: InputDecoration(
                              hintText: "Enter your password",

                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF008FA3),
                              ),

                              // Password visibility button
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,

                                  color: Colors.grey,
                                ),

                                onPressed: () {
                                  setState(() {
                                    _obscurePassword =
                                        !_obscurePassword;
                                  });
                                },
                              ),

                              filled: true,
                              fillColor: Colors.grey.shade100,

                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15),

                                borderSide: const BorderSide(
                                  color: Color(0xFF008FA3),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // ------------------------------------------------
                          // FORGOT PASSWORD
                          // ------------------------------------------------

                          Align(
                            alignment: Alignment.centerRight,

                            child: TextButton(
                              onPressed: () {
                                // Add forgot password page here
                              },

                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xFF008FA3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // ------------------------------------------------
                          // LOGIN BUTTON
                          // ------------------------------------------------

                          SizedBox(
                            width: double.infinity,
                            height: 55,

                            child: ElevatedButton(
                              onPressed: () {

                                // Navigate to landlord dashboard
                                Get.toNamed("/home");
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF008FA3),

                                foregroundColor: Colors.white,

                                elevation: 5,

                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15),
                                ),
                              ),

                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [

                                  Icon(
                                    Icons.login,
                                    size: 20,
                                  ),

                                  SizedBox(width: 10),

                                  Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ------------------------------------------------
                          // CREATE ACCOUNT
                          // ------------------------------------------------

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [

                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              GestureDetector(
                                onTap: () {

                                  // Navigate to Sign Up
                                  Get.toNamed("/signup");
                                },

                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Color(0xFF008FA3),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ------------------------------------------------
                    // FOOTER
                    // ------------------------------------------------

                    const Text(
                      "2026 Property Manager",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Smart • Simple • Reliable Property Management",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
