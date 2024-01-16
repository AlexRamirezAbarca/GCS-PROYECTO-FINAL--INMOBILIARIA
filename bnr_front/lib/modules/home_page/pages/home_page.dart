import 'package:bnr_front/modules/home_page/models/propertys.dart';
import 'package:flutter/material.dart';

class Property {
  final int id;
  final String description;
  final int value;
  final String location;
  final String image;

  Property({
    required this.id,
    required this.description,
    required this.value,
    required this.location,
    required this.image,
  });
}

final List<Property> properties = [
  Property(
    id: 1,
    description: "Hermosa casa de lujo, con acabados de primera, jardín sacado de tus sueños, no dudes en visitarla y aocgerte a esto ",
    value: 250000,
    location: "Ciudad A",
    image: "residences/home1.jpeg",
  ),
  Property(
    id: 2,
    description: "Moderno apartamento en el corazón de la ciudad. Con diseño contemporáneo y comodidades de lujo, es ideal para aquellos que buscan vivir cerca de todo.",
    value: 150000,
    location: "Ciudad B",
    image: "residences/home2.jpeg",
  ),
  Property(
    id: 3,
    description: "Impresionante casa con vista al mar. Disfruta de increíbles atardeceres y una ubicación privilegiada cerca de las playas más hermosas.",
    value: 350000,
    location: "Ciudad C",
    image: "residences/home3.jpeg",
  ),
  Property(
    id: 4,
    description: "Acogedora residencia con estilo campestre. Rodeada de naturaleza y con todas las comodidades para una vida relajada.",
    value: 250000,
    location: "Ciudad A",
    image: "residences/home4.jpeg",
  ),
  Property(
    id: 5,
    description: "Amplio apartamento con diseño elegante en el centro urbano. Cuenta con excelentes servicios y una ubicación conveniente.",
    value: 150000,
    location: "Ciudad B",
    image: "residences/home5.jpeg",
  ),
  Property(
    id: 6,
    description: "Residencia frente al mar con arquitectura única. Vive la experiencia de despertar con vistas panorámicas al océano.",
    value: 350000,
    location: "Ciudad C",
    image: "residences/home6.jpeg",
  ),
  Property(
    id: 7,
    description: "Encantadora casa de campo con amplias áreas verdes y un ambiente tranquilo. Perfecta para quienes buscan escapar del bullicio de la ciudad.",
    value: 250000,
    location: "Ciudad A",
    image: "residences/home7.jpeg",
  ),
  Property(
    id: 8,
    description: "Moderno apartamento en el corazón de la ciudad. Con diseño contemporáneo y comodidades de lujo, es ideal para aquellos que buscan vivir cerca de todo.",
    value: 150000,
    location: "Ciudad B",
    image: "residences/home2.jpeg",
  ),
  Property(
    id: 9,
    description: "Impresionante casa con vista al mar. Disfruta de increíbles atardeceres y una ubicación privilegiada cerca de las playas más hermosas.",
    value: 350000,
    location: "Ciudad C",
    image: "residences/home3.jpeg",
  ),
  // Agregar más propiedades según sea necesario
];


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Property selectedProperty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: const Text('Inmobiliaria Gestion de Proyectos de Software'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          const Text('Cerrar sesión'),
          IconButton(
            iconSize: 40,
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: properties.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedProperty = properties[index];
                });
                _showPropertyDetailsModal(context);
              },
              child: _buildCard(properties[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(Property property) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(property.image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.description,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('Valor: \$${property.value}'),
                Text('Ubicación: ${property.location}'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                _showReservationConfirmationDialog(context, property);
              },
              child: const Text('Reservar'),
            ),
          )
        ],
      ),
    );
  }

  void _showReservationConfirmationDialog(BuildContext context, Property property) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Reserva'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('¿Está seguro de que desea reservar la siguiente propiedad?'),
              SizedBox(height: 8.0),
              Text(
                'Descripción: ${property.description}\nValor: \$${property.value}\nUbicación: ${property.location}',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _showReservationSuccessSnackbar(context, property);
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showReservationSuccessSnackbar(BuildContext context, Property property) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('La propiedad "${property.description}" fue reservada con éxito. Un asesor se pondrá en contacto contigo.'),
      ),
    );
  }

  void _showPropertyDetailsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalles de la Propiedad',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text('Descripción: ${selectedProperty.description}'),
              SizedBox(height: 8.0),
              Text('Valor: \$${selectedProperty.value}'),
              SizedBox(height: 8.0),
              Text('Ubicación: ${selectedProperty.location}'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el modal
                },
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/loginPage');
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}