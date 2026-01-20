import 'package:dio_contact/services/api_services.dart';
import 'package:dio_contact/services/auth_manager.dart';
import 'package:dio_contact/model/login_model.dart';
import 'package:dio_contact/view/screen/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtl = TextEditingController();
  final _passwordCtl = TextEditingController();
  bool _isLoading = false;
  final ApiServices _apiServices = ApiServices();

  // Validasi Username
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.length < 4) {
      return 'Username minimal 4 karakter';
    }
    return null;
  }

  // Validasi Password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Password minimal 3 karakter';
    }
    return null;
  }

  // Fungsi Login
  Future<void> _handleLogin() async {
    final isValidForm = _formKey.currentState!.validate();
    if (!isValidForm) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final loginInput = LoginInput(
        username: _usernameCtl.text,
        password: _passwordCtl.text,
      );

      final response = await _apiServices.login(loginInput);

      if (response != null && response.status == 200 && response.token != null) {
        // Simpan username dan token ke SharedPreferences
        await AuthManager.login(_usernameCtl.text, response.token!);

        if (mounted) {
          // Navigasi ke HomePage
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response?.message ?? 'Login gagal'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Cek status login di initState
  void _checkLoginStatus() async {
    final isLoggedIn = await AuthManager.isLoggedIn();
    if (isLoggedIn && mounted) {
      // Jika sudah login, langsung arahkan ke HomePage
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void dispose() {
    _usernameCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Judul
                const Text(
                  'Contacts API',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Silakan login untuk melanjutkan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32.0),

                // Form Login
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username Field
                      TextFormField(
                        controller: _usernameCtl,
                        validator: _validateUsername,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Username',
                          hintText: 'Masukkan username',
                          prefixIcon: const Icon(Icons.person),
                          suffixIcon: IconButton(
                            onPressed: _usernameCtl.clear,
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Password Field
                      TextFormField(
                        controller: _passwordCtl,
                        validator: _validatePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Masukkan password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: _passwordCtl.clear,
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      // Login Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
