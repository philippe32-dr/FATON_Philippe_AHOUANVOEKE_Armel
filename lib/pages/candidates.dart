class Candidate {
  final String name;
  final String surname;
  final String party;
  final String bio;
  final String? imagePath;
  final DateTime? dateOfBirth;

  Candidate({
    required this.name,
    required this.surname,
    required this.party,
    required this.bio,
    this.imagePath,
    this.dateOfBirth,
  });
}
