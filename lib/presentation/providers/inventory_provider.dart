import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/consumable.dart';

/// Kullanıcı sarf malzeme envanteri
class InventoryState {
  final Map<ConsumableType, int> items;

  const InventoryState({this.items = const {}});

  int count(ConsumableType type) => items[type] ?? 0;
  bool has(ConsumableType type) => count(type) > 0;

  InventoryState copyWith({Map<ConsumableType, int>? items}) {
    return InventoryState(items: items ?? this.items);
  }
}

class InventoryNotifier extends StateNotifier<InventoryState> {
  InventoryNotifier() : super(const InventoryState(
    // Başlangıç envanteri (test için ücretsiz)
    items: {
      ConsumableType.disposableGloves: 10,
      ConsumableType.surgicalMask: 5,
      ConsumableType.n95Mask: 2,
      ConsumableType.painKiller: 3,
      ConsumableType.sedative: 2,
      ConsumableType.tea: 5,
      ConsumableType.blanket: 3,
    },
  ));

  /// Malzeme ekle
  void add(ConsumableType type, int amount) {
    final newItems = {...state.items};
    newItems[type] = (newItems[type] ?? 0) + amount;
    state = state.copyWith(items: newItems);
  }

  /// Malzeme kullan (varsa true döner)
  bool use(ConsumableType type) {
    final current = state.count(type);
    if (current <= 0) return false;
    final newItems = {...state.items};
    newItems[type] = current - 1;
    state = state.copyWith(items: newItems);
    return true;
  }
}

final inventoryProvider = StateNotifierProvider<InventoryNotifier, InventoryState>(
  (ref) => InventoryNotifier(),
);

/// Sarf malzeme katalog bilgileri
const consumableCatalog = <ConsumableType, Consumable>{
  ConsumableType.disposableGloves: Consumable(
    type: ConsumableType.disposableGloves,
    name: 'Tek Kullanımlık Eldiven',
    description: 'Muayene için steril eldiven',
    category: ConsumableCategory.protection,
    creditCost: 2,
  ),
  ConsumableType.surgicalMask: Consumable(
    type: ConsumableType.surgicalMask,
    name: 'Cerrahi Maske',
    description: 'Standart koruyucu maske',
    category: ConsumableCategory.protection,
    creditCost: 3,
  ),
  ConsumableType.n95Mask: Consumable(
    type: ConsumableType.n95Mask,
    name: 'N95 Maske',
    description: 'Yüksek koruma sağlayan maske',
    category: ConsumableCategory.protection,
    creditCost: 8,
  ),
  ConsumableType.painKiller: Consumable(
    type: ConsumableType.painKiller,
    name: 'Ağrı Kesici',
    description: 'Hasta ağrısını hafifletir, konfor artırır',
    category: ConsumableCategory.comfort,
    creditCost: 5,
  ),
  ConsumableType.sedative: Consumable(
    type: ConsumableType.sedative,
    name: 'Sakinleştirici',
    description: 'Hastayı sakinleştirir, nabzı düşürür',
    category: ConsumableCategory.comfort,
    creditCost: 8,
  ),
  ConsumableType.tea: Consumable(
    type: ConsumableType.tea,
    name: 'Sıcak Çay',
    description: 'Hastayı rahatlatır, tansiyon düşer',
    category: ConsumableCategory.comfort,
    creditCost: 1,
  ),
  ConsumableType.blanket: Consumable(
    type: ConsumableType.blanket,
    name: 'Battaniye',
    description: 'Hastayı ısıtır, vücut ısısını normalize eder',
    category: ConsumableCategory.comfort,
    creditCost: 2,
  ),
};
