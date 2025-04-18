import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = await _auth.loginUser(emailController.text, passwordController.text);
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed. Please check your credentials."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // Logo
                Center(
                  child: Image.asset(
                    'assets/Login.png', // Add your logo to assets
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                // Welcome text
                Text(
                  "Welcome back",
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Sign in to continue",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6E6E6E),
                  ),
                ),
                const SizedBox(height: 40),
                // Email field
                _buildInputField(
                  controller: emailController,
                  label: "Email",
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                // Password field
                _buildInputField(
                  controller: passwordController,
                  label: "Password",
                  hintText: "Enter your password",
                  obscureText: _obscurePassword,
                  icon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF6E6E6E),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add forgot password logic
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Login button

                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Or continue with
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Color(0xFFE5E5E5),
                        thickness: 1,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Color(0xFFE5E5E5),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Register link
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF6E6E6E),
                      ),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                            ),
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4CAF50),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    IconData? icon,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E5E5)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF333333),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFFAAAAAA),
              ),
              prefixIcon: icon != null
                  ? Icon(
                icon,
                color: const Color(0xFF6E6E6E),
              )
                  : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Image.asset(
            icon,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}