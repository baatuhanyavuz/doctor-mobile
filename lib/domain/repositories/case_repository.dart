import '../../data/models/case.dart';

/// Abstract repository interface for Case operations
/// 
/// Bu interface ile lokaldeki JSON veya remote API arasında 
/// kolayca geçiş yapılabilir.
abstract class ICaseRepository {
  /// Tüm vakaları getir
  Future<List<Case>> getAllCases();

  /// ID'ye göre tek vaka getir
  Future<Case?> getCaseById(String id);
}
