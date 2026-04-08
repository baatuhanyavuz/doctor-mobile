/// NPC Uzman Doktor Konsültanları
class Consultant {
  final String id;
  final String name;
  final String specialty;
  final String photoPath;
  final String greeting;
  final int creditCost;

  const Consultant({
    required this.id,
    required this.name,
    required this.specialty,
    required this.photoPath,
    required this.greeting,
    required this.creditCost,
  });
}

/// Mevcut konsültanlar
const consultants = <Consultant>[
  Consultant(
    id: 'cardio',
    name: 'Prof. Dr. Kemal Aydın',
    specialty: 'Kardiyoloji',
    photoPath: '',
    greeting: 'Buyurun meslektaşım, kalple ilgili bir şey mi var?',
    creditCost: 15,
  ),
  Consultant(
    id: 'neuro',
    name: 'Doç. Dr. Ayşe Yıldız',
    specialty: 'Nöroloji',
    photoPath: '',
    greeting: 'Nörolojik bir bulgu mu buldunuz? Dinliyorum.',
    creditCost: 15,
  ),
  Consultant(
    id: 'pulmo',
    name: 'Prof. Dr. Mehmet Demir',
    specialty: 'Göğüs Hastalıkları',
    photoPath: '',
    greeting: 'Solunum sistemiyle ilgili bir sorun mu var?',
    creditCost: 15,
  ),
  Consultant(
    id: 'infect',
    name: 'Dr. Zeynep Kara',
    specialty: 'Enfeksiyon Hastalıkları',
    photoPath: '',
    greeting: 'Enfeksiyon şüphesi mi var? Bulgulara bakalım.',
    creditCost: 15,
  ),
  Consultant(
    id: 'pediatr',
    name: 'Prof. Dr. Fatma Özkan',
    specialty: 'Pediatri',
    photoPath: '',
    greeting: 'Çocuk hastanız mı var? Nasıl yardımcı olabilirim?',
    creditCost: 15,
  ),
  Consultant(
    id: 'ent',
    name: 'Op. Dr. Ali Şahin',
    specialty: 'KBB (Kulak Burun Boğaz)',
    photoPath: '',
    greeting: 'KBB ile ilgili konsültasyon mu istiyorsunuz?',
    creditCost: 15,
  ),
];
