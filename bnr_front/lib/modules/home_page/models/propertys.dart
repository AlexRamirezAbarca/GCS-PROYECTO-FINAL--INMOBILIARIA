import 'dart:convert';

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

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as int,
      description: json['description'] as String,
      value: json['value'] as int,
      location: json['location'] as String,
      image: json['image'] as String,
    );
  }
}

List<Property> propertiesFromJson(String jsonString) {
  final List<dynamic> parsedJson = json.decode(jsonString);
  return parsedJson.map((json) => Property.fromJson(json)).toList();
}

const String propertyJson = '''
[
  {
    "id": 1,
    "description": "Encantadora casa de campo con amplias áreas verdes y un ambiente tranquilo. Perfecta para quienes buscan escapar del bullicio de la ciudad.",
    "value": 250000,
    "location": "Ciudad A",
    "image": "residences/home1.jpeg"
  },
  {
    "id": 2,
    "description": "Moderno apartamento en el corazón de la ciudad. Con diseño contemporáneo y comodidades de lujo, es ideal para aquellos que buscan vivir cerca de todo.",
    "value": 150000,
    "location": "Ciudad B",
    "image": "residences/home2.jpeg"
  },
  {
    "id": 3,
    "description": "Impresionante casa con vista al mar. Disfruta de increíbles atardeceres y una ubicación privilegiada cerca de las playas más hermosas.",
    "value": 350000,
    "location": "Ciudad C",
    "image": "residences/home3.jpeg"
  },
  {
    "id": 4,
    "description": "Acogedora residencia con estilo campestre. Rodeada de naturaleza y con todas las comodidades para una vida relajada.",
    "value": 250000,
    "location": "Ciudad A",
    "image": "residences/home4.jpeg"
  },
  {
    "id": 5,
    "description": "Amplio apartamento con diseño elegante en el centro urbano. Cuenta con excelentes servicios y una ubicación conveniente.",
    "value": 150000,
    "location": "Ciudad B",
    "image": "residences/home5.jpeg"
  },
  {
    "id": 6,
    "description": "Residencia frente al mar con arquitectura única. Vive la experiencia de despertar con vistas panorámicas al océano.",
    "value": 350000,
    "location": "Ciudad C",
    "image": "residences/home6.jpeg"
  },
  {
    "id": 7,
    "description": "Encantadora casa de campo con amplias áreas verdes y un ambiente tranquilo. Perfecta para quienes buscan escapar del bullicio de la ciudad.",
    "value": 250000,
    "location": "Ciudad A",
    "image": "residences/home7.jpeg"
  },
  {
    "id": 8,
    "description": "Moderno apartamento en el corazón de la ciudad. Con diseño contemporáneo y comodidades de lujo, es ideal para aquellos que buscan vivir cerca de todo.",
    "value": 150000,
    "location": "Ciudad B",
    "image": "residences/home2.jpeg"
  },
  {
    "id": 9,
    "description": "Impresionante casa con vista al mar. Disfruta de increíbles atardeceres y una ubicación privilegiada cerca de las playas más hermosas.",
    "value": 350000,
    "location": "Ciudad C",
    "image": "residences/home3.jpeg"
  }
]
''';
