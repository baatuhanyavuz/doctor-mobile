import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Çözülmüş çelişkilerin evidence ID'lerini tutar.
/// Board'da çelişki deduction'ı bulunduğunda güncellenir,
/// Interrogation tab'ı bu provider'ı izleyerek truthReveal gösterir.
final solvedContradictionEvidenceIdsProvider =
    StateProvider<Set<String>>((ref) => {});
