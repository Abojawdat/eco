import 'package:flutter/material.dart';
import '../pages/home_screen.dart';
import '../resposive_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  bool _remember = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    // Basic email regex
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!emailRegex.hasMatch(value.trim())) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // After validation -> navigate to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const homescreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 64,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // top spacing / logo area
                  _buildHeader(context),
                  const SizedBox(height: 24),

                  // Card with form
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 18.0,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Welcome back',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Cairo",
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Log in to your account',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Cairo",
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Email
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'you@example.com',
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: _validateEmail,
                            ),

                            const SizedBox(height: 12),

                            // Password
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscure,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _onLoginPressed(),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () =>
                                      setState(() => _obscure = !_obscure),
                                  tooltip: _obscure
                                      ? 'Show password'
                                      : 'Hide password',
                                ),
                              ),
                              validator: _validatePassword,
                            ),

                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _remember,
                                      onChanged: (v) => setState(
                                        () => _remember = v ?? false,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => setState(
                                        () => _remember = !_remember,
                                      ),
                                      child: Text(
                                        'Remember me',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Cairo",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    // UI-only: show placeholder
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Forgot password pressed',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Cairo",
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _onLoginPressed,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Log in',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            Center(
                              child: Text(
                                'or continue with',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Cairo",
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.g_mobiledata),
                                    label: const Text(
                                      'Google',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Cairo",
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.facebook),
                                    label: const Text(
                                      'Facebook',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Cairo",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Spacer to push content up on large screens
                  const Spacer(),

                  // Small footer note
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Center(
                      child: Text(
                        'By continuing you agree to our Terms & Privacy',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Decorative top card / logo
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.indigo.shade400, Colors.blue.shade300],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28), // match outer radius
            child: Image.asset(
              'images/elctric.png', // <-- your asset path
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Hello again!',
          style: TextStyle(fontSize: 20, fontFamily: "Cairo"),
        ),
        const SizedBox(height: 6),
        const Text(
          'Welcome back — please login to continue',
          style: TextStyle(fontSize: 20, fontFamily: "Cairo"),
        ),
      ],
    );
  }
}
