// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<List<Map<String, dynamic>?>> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> userList = prefs.getStringList('userList') ?? [];

    return userList
        .map((user) {
          try {
            return json.decode(user) as Map<String, dynamic>?;
          } catch (e) {
            // Si hay un error al decodificar la cadena, retorna null
            return null;
          }
        })
        .where((user) => user != null) // Filtra los usuarios válidos
        .toList();
  }

  Future<void> _login() async {
    final userList = await _loadUserData();

    // Obtener el usuario y la contraseña ingresados por el usuario
    String enteredUsername = username.text;
    String enteredPassword = password.text;

    // Verificar si el usuario y la contraseña coinciden con algún usuario almacenado
    bool isValidUser = userList.any((userData) {
      return userData!['usuario'] == enteredUsername &&
          userData['contrasena'] == enteredPassword;
    });

    if (isValidUser) {
      // Usuario válido, avanzar a la siguiente pantalla
      Navigator.pushNamed(context, '/homePage');
    } else {
      // Usuario o contraseña incorrectos, mostrar alerta y Snackbar
      _showErrorDialog('Error', 'Usuario o contraseña incorrectos');
      _showErrorSnackbar('Usuario o contraseña incorrectos');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset('images/logo_demo.png'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'TU HOGAR ESPERADO TE ESPERA',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: username,
                      decoration: const InputDecoration(
                        labelText: 'Ingrese el usuario',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Ingrese la contraseña',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para iniciar sesión
                          _login();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                        ),
                        child: const Text('Ingresar'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para registrarse
                          Navigator.pushNamed(context, '/registerPage');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                        ),
                        child: const Text('Registrarse'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Lógica para "¿Olvidó su contraseña?"
                      },
                      child: const Text('¿Olvidó su contraseña?'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
