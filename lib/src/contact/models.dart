import 'package:uuid/uuid.dart';

class Contact {
  final String id;
  final String nom;
  final String pseudo;
  final String numero;

  Contact({
    String? id, // Make id optional and generate if not provided
    required this.nom,
    required this.pseudo,
    required this.numero,
  }) : id = id ?? Uuid().v4(); // Generate a new UUID if id is not provided

  Contact copyWith({String? id, String? nom, String? pseudo, String? numero}) {
    return Contact(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      pseudo: pseudo ?? this.pseudo,
      numero: numero ?? this.numero,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'pseudo': pseudo,
      'numero': numero,
    };
  }

  // Create a Contact from a Map
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      nom: map['nom'],
      pseudo: map['pseudo'],
      numero: map['numero'],
    );
  }
}
