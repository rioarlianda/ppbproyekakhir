import 'package:flutter/material.dart';
import 'package:ppb_proyek_akhir/home_page.dart';
import 'package:ppb_proyek_akhir/login_page.dart';
import 'package:ppb_proyek_akhir/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ppb_proyek_akhir/custom_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void toLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const LoginPage()),
      ),
    );
  }

  Future addUser(
    String fullName,
    String email,
    String password,
  ) async {
    await FirebaseFirestore.instance.collection('Users').add(
      {
        'fullName': fullName,
        'email': email,
        'password': password,
      },
    );
  }

  Future register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final fullName = _fullNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
        throw ("Isi semua kolom pada form");
      }
      if (password.length < 6) {
        throw ("Password minimal harus terdiri dari 6 karakter");
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addUser(fullName, email, password);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return const HomePage();
        }),
      );
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Error: ${e.toString()}'),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Register',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 24),
                    Text('Silakan melakukan pendaftaran', style: textNormal),
                    const SizedBox(height: 20),
                    CustomForm(
                      controller: _fullNameController,
                      icon: const Icon(Icons.person),
                      label: 'Nama Lengkap',
                    ),
                    CustomForm(
                      controller: _emailController,
                      icon: const Icon(Icons.mail),
                      label: 'Email',
                    ),
                    CustomForm(
                      controller: _passwordController,
                      icon: const Icon(Icons.lock),
                      label: 'Password',
                      isObscure: true,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sudah punya akun?', style: textNormal),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => const LoginPage()),
                              ),
                            );
                          },
                          child: Text('Login', style: textLink),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
