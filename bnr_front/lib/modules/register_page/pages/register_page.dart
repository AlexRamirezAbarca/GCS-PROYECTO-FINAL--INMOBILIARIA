import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String selectedGender = 'Femenino'; // Default gender

  List<String> genders = ['Femenino', 'Masculino', 'Otros'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100, top: 100, left: 250, right: 250),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Registro de Usuario',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInputField('Nombre', firstNameController),
                const SizedBox(height: 10),
                _buildInputField('Apellidos', lastNameController),
                const SizedBox(height: 10),
                _buildInputField('Cédula', idController),
                const SizedBox(height: 10),
                _buildInputField('Teléfono', phoneController),
                const SizedBox(height: 10),
                _buildDropdown('Sexo', genders, selectedGender),
                const SizedBox(height: 10),
                _buildInputField('Correo Electrónico', emailController),
                const SizedBox(height: 10),
                _buildInputField('Usuario', usernameController),
                const SizedBox(height: 10),
                _buildInputField('Contraseña', passwordController, obscureText: true),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_validateFields()) {
                        _saveToLocalStorage();
                        _showSuccessDialog();
                      } else {
                        _showErrorSnackbar('Todos los campos son obligatorios');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('Registrarse'),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                     Navigator.pushNamed(context, '/loginPage');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String selectedValue) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedGender = value!;
        });
      },
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  bool _validateFields() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        idController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  Future<void> _saveToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> userList = prefs.getStringList('userList')?.map((user) => Map<String, String>.from(json.decode(user)))?.toList() ?? [];

    Map<String, String> newUser = {
      'nombre': firstNameController.text,
      'apellidos': lastNameController.text,
      'cedula': idController.text,
      'telefono': phoneController.text,
      'sexo': selectedGender,
      'email': emailController.text,
      'usuario': usernameController.text,
      'contrasena': passwordController.text,
    };

    userList.add(newUser);

    prefs.setStringList('userList', userList.map((user) => json.encode(user)).toList());
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Éxito'),
          content: const Text('Usuario creado con éxito'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/loginPage');
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
