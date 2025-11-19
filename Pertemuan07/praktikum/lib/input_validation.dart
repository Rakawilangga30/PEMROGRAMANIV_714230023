import 'package:flutter/material.dart';

class MyFormvalidation extends StatefulWidget {
  const MyFormvalidation({super.key});

  @override
  State<MyFormvalidation> createState() => _MyFormvalidationState();
}

class _MyFormvalidationState extends State<MyFormvalidation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerNama.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    const String expression =
        "[a-zA-Z0-9+._%-+]{1,256}"
        "\\@"
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
        "("
        "\\."
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
        ")+";
    final RegExp regExp = RegExp(expression);

    if (value!.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    if (!regExp.hasMatch(value)) {
      return 'Masukkan email yang valid';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value!.length < 3) {
      return 'Nama harus terdiri dari minimal 3 karakter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Validation')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                decoration: const InputDecoration(
                  hintText: 'Write your email here...',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Color.fromARGB(255, 222, 254, 255),
                  filled: true,
                ),
              ),
            ),

            // Nama
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _controllerNama,
                validator: _validateName,
                decoration: const InputDecoration(
                  hintText: 'Write your name here...',
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Color.fromARGB(255, 222, 254, 255),
                  filled: true,
                ),
              ),
            ),

            // Tombol Submit
            ElevatedButton(
              child: const Text("Submit"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Processing Data'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // 🟢 Tampilkan AlertDialog berisi data
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          'Nama: ${_controllerNama.text}\nEmail: ${_controllerEmail.text}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please complete the form'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
