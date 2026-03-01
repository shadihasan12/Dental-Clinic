class Tooth {
  final String id;
  final String name;
  final String universalCode;
  final String quadrant;

  const Tooth({
    required this.id,
    required this.name,
    required this.universalCode,
    required this.quadrant,
  });

  factory Tooth.fromJson(Map<String, dynamic> json) {
    return Tooth(
      id: json['id'] as String,
      name: json['name'] as String,
      universalCode: json['universal_code'] as String,
      quadrant: json['quadrant'] as String,
    );
  }

  /// Returns the quadrant number (1-4) derived from the universal code.
  /// 1=Upper Right, 2=Upper Left, 3=Lower Left, 4=Lower Right
  int get quadrantNumber => int.parse(universalCode) ~/ 10;

  /// Returns the tooth type index (1-8) derived from the universal code.
  /// 1=Central Incisor, 2=Lateral Incisor, 3=Canine, 4=1st Premolar,
  /// 5=2nd Premolar, 6=1st Molar, 7=2nd Molar, 8=Wisdom
  int get toothTypeIndex => int.parse(universalCode) % 10;
}
