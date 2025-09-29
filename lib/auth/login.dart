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
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.wp(6),
            vertical: responsive.hp(4),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - responsive.hp(8),
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // top spacing / logo area
                  _buildHeader(context),
                  SizedBox(height: responsive.hp(2.4)),

                  // Card with form
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive.wp(4)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(5),
                        vertical: responsive.hp(2.2),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Welcome back',
                              style: TextStyle(
                                fontSize: responsive.sp(5),
                                fontFamily: "Cairo",
                              ),
                            ),
                            SizedBox(height: responsive.hp(0.8)),
                            Text(
                              'Log in to your account',
                              style: TextStyle(
                                fontSize: responsive.sp(3.8),
                                fontFamily: "Cairo",
                              ),
                            ),
                            SizedBox(height: responsive.hp(2)),

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
                                  borderRadius: BorderRadius.circular(responsive.wp(3)),
                                ),
                              ),
                              validator: _validateEmail,
                            ),

                            SizedBox(height: responsive.hp(1.4)),

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
                                  borderRadius: BorderRadius.circular(responsive.wp(3)),
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

                            SizedBox(height: responsive.hp(1.2)),

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
                                          fontSize: responsive.sp(2.6),
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
                                            // Keep SnackBar text small but readable
                                            fontSize: 12,
                                            fontFamily: "Cairo",
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Cairo",
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: responsive.hp(1)),

                            SizedBox(
                              height: responsive.hp(6),
                              child: ElevatedButton(
                                onPressed: _onLoginPressed,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(responsive.wp(3)),
                                  ),
                                ),
                                child: const Text(
                                  'Log in',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: responsive.hp(1.2)),

                            Center(
                              child: Text(
                                'or continue with',
                                style: TextStyle(
                                  fontSize: responsive.sp(3.6),
                                  fontFamily: "Cairo",
                                ),
                              ),
                            ),
                            SizedBox(height: responsive.hp(1)),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.g_mobiledata),
                                    label: const Text(
                                      'Google',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Cairo",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: responsive.wp(2)),
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

                            SizedBox(height: responsive.hp(1.4)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontSize: 12,
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

                  SizedBox(height: responsive.hp(2)),

                  // Spacer to push content up on large screens
                  const Spacer(),

                  // Small footer note
                  Padding(
                    padding: EdgeInsets.only(top: responsive.hp(1.2)),
                    child: Center(
                      child: Text(
                        'By continuing you agree to our Terms & Privacy',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
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
    final responsive = ResponsiveHelper(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Decorative top card / logo
        Container(
          width: responsive.wp(28),
          height: responsive.wp(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsive.wp(7)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.indigo.shade400, Colors.blue.shade300],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: responsive.wp(3),
                offset: Offset(0, responsive.hp(0.8)),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(responsive.wp(7)), // match outer radius
            child: Image.asset(
              'images/elctric.png', // <-- your asset path
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: responsive.hp(1.4)),
        Text(
          'Hello again!',
          style: TextStyle(fontSize: responsive.sp(5), fontFamily: "Cairo"),
        ),
        SizedBox(height: responsive.hp(0.6)),
        Text(
          'Welcome back — please login to continue',
          style: TextStyle(fontSize: responsive.sp(4), fontFamily: "Cairo"),
        ),
      ],
    );
  }
}
