import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SINGUP extends StatefulWidget {
  const SINGUP({super.key});

  @override
  State<SINGUP> createState() => _SINGUPState();
}

class _SINGUPState extends State<SINGUP> {
  // Password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.all(25),

              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),

                child: Column(
                  children: [
                    // App Logo
                    Container(
                      width: 80,
                      height: 80,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.home_work_rounded,
                        size: 45,
                        color: Color(0xFF008FA3),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Application Name
                    const Text(
                      "Property Manager",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Rental Management System",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Create your account to manage your rental properties.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),

                    // Registration Card
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
                          // Registration Icon
                          Container(
                            width: 90,
                            height: 90,

                            decoration: const BoxDecoration(
                              color: Color(0xFFE0F7FA),
                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.person_add_rounded,
                              size: 50,
                              color: Color(0xFF008FA3),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Registration Title
                          const Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006978),
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Register to manage your rental properties",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 30),

                          // Full Name
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Full Name",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter your full name",

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

                          // Email
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            keyboardType:
                                TextInputType.emailAddress,

                            decoration: InputDecoration(
                              hintText: "Enter your email",

                              prefixIcon: const Icon(
                                Icons.email_outlined,
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

                          // Username
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

                          TextField(
                            decoration: InputDecoration(
                              hintText: "Choose a username",

                              prefixIcon: const Icon(
                                Icons.account_circle_outlined,
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

                          // Password
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

                          TextField(
                            obscureText: _obscurePassword,

                            decoration: InputDecoration(
                              hintText: "Enter your password",

                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF008FA3),
                              ),

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword =
                                        !_obscurePassword;
                                  });
                                },

                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey,
                                ),
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

                          // Confirm Password
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Confirm Password",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            obscureText:
                                _obscureConfirmPassword,

                            decoration: InputDecoration(
                              hintText: "Confirm your password",

                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF008FA3),
                              ),

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },

                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey,
                                ),
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

                          const SizedBox(height: 30),

                          // Register Button
                          SizedBox(
                            width: double.infinity,
                            height: 55,

                            child: ElevatedButton(
                              onPressed: () {
                                // Registration logic here
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
                                    Icons.person_add,
                                    size: 20,
                                  ),

                                  SizedBox(width: 10),

                                  Text(
                                    "REGISTER",
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

                          const SizedBox(height: 25),

                          // Login
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/");
                                },

                                child: const Text(
                                  "Login",
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

                    const SizedBox(height: 25),

                    // Footer
                    const Text(
                      "© 2026 Property Manager",
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