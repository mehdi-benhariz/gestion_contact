class Contact {
  final String nom;
  final String pseudo;
  final String numero;

  Contact({required this.nom, required this.pseudo, required this.numero});

  Contact copyWith({String? nom, String? pseudo, String? numero}) {
    return Contact(
      nom: nom ?? this.nom,
      pseudo: pseudo ?? this.pseudo,
      numero: numero ?? this.numero,
    );
  }
}
