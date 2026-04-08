# Teknik Mimari Raporu: Dedektif - Suç Dosyaları

Bu belge, "Dedektif: Suç Dosyaları" uygulamasının teknik yapısını, kullanılan teknolojileri ve mimari desenleri özetlemektedir.

## 1. Genel Bakış

Uygulama, **Flutter** framework'ü kullanılarak geliştirilmiş, **Clean Architecture** prensiplerine sadık kalan, modern ve ölçeklenebilir bir mobil oyundur.

*   **Platform**: Cross-platform (iOS & Android)
*   **Dil**: Dart
*   **Framework**: Flutter

## 2. Mimari Yapı (Architecture)

Proje, sorumlulukların ayrıştırılması ilkesine dayanan **Clean Architecture** yapısını takip etmektedir. Klasör yapısı şu şekildedir:

```
lib/
├── core/           # Çekirdek yardımcılar, sabitler, router ve temalar
├── data/           # Veri katmanı (Model, Repository Implementasyonları)
├── domain/         # İş mantığı katmanı (Repository Arayüzleri)
└── presentation/   # Sunum katmanı (UI, Widget'lar, State Management)
```

### 2.1. Domain Layer (İş Mantığı Katmanı)
Uygulamanın kalbidir. Dış dünyadan bağımsızdır.
*   **Repositories Interface**: Veri kaynağına nasıl erişileceğini soyutlayan arayüzler (Örn: `ICaseRepository`).
*   *Not: Bu projede Entity'ler pratiklik adına `data/models` altında tanımlanmış ve domain katmanında da kullanılıyor olabilir.*

### 2.2. Data Layer (Veri Katmanı)
Domain katmanındaki arayüzlerin somut uygulamalarını ve veri modellerini içerir.
*   **Models**: `freezed` kütüphanesi ile immutable (değiştirilemez) olarak tanımlanmış, JSON serileştirme desteği olan veri sınıfları (Örn: `Case`, `Evidence`, `Suspect`).
*   **Datasources**: Veriye erişim noktaları.
*   **Repositories Implementation**: `domain` katmanındaki arayüzleri implemente eden sınıflar (Örn: `LocalCaseRepository`). Local JSON verilerini veya veritabanını okur.

### 2.3. Presentation Layer (Sunum Katmanı)
Kullanıcının etkileşime girdiği katmandır.
*   **Screens**: Uygulama ekranları (Briefing, Game, Conclusion vb.).
*   **Widgets**: Tekrar kullanılabilir UI bileşenleri.
*   **Providers**: State management (Durum yönetimi) mantığını barındırır. İş mantığı ile UI arasındaki köprüdür.

### 2.4. Core Layer (Çekirdek Katmanı)
Tüm katmanların ortak kullandığı yapılar.
*   **Router**: Sayfa geçişleri yönetimi (`go_router`).
*   **Utils**: Yardımcı sınıflar (Örn: `SoundManager` ses yönetimi için).
*   **Theme**: Uygulama teması ve renk paletleri.

## 3. Teknoloji Yığını (Tech Stack)

### 3.1. State Management (Durum Yönetimi)
*   **flutter_riverpod**: Uygulamanın genel durum yönetimi ve Dependency Injection (Bağımlılık Enjeksiyonu) için kullanılıyor.
    *   `Provider`: Repository'leri enjekte etmek için.
    *   `FutureProvider`: Asenkron veri çekmek için (Vaka listesi vb.).
    *   `StateNotifier` / `Notifier`: Oyun durumu ve etkileşimleri yönetmek için.

### 3.2. Veri Modelleme ve Serileştirme
*   **freezed**: Immutable modeller ve union typelar oluşturmak için. Boilerplate kodunu azaltır ve güvenli kod yazmayı sağlar.
*   **json_serializable**: JSON verilerini Dart nesnelerine (ve tersi) çevirmek için.

### 3.3. Navigasyon
*   **go_router**: Derin bağlantı (deep linking) desteği olan, path tabanlı modern navigasyon çözümü.
    *   Rota tanımları `lib/core/router/app_router.dart` içinde merkezi olarak yönetiliyor.

### 3.4. Medya ve Materyaller
*   **just_audio** / **audioplayers**: Ses efektleri ve sorgu kayıtlarını oynatmak için.
*   **cached_network_image**: İnternet üzerinden gelen görselleri önbelleğe alıp performansı artırmak için.
*   **google_fonts**: Özel tipografi kullanımı için.
*   **animated_text_kit**: Daktilo efekti gibi metin animasyonları için.

## 4. Önemli Tasarım Kararları

1.  **Repository Pattern**: Veri kaynağının (Local JSON, API, Firebase vb.) UI'dan soyutlanmasını sağlar. İleride backend entegrasyonu yapıldığında sadece `data` katmanında değişiklik yapmak yeterli olacaktır. UI kodları değişmeden kalır.
2.  **Code Generation**: `build_runner` kullanılarak `freezed` ve `json_serializable` kodları otomatik üretiliyor. Bu, manuel hata yapma riskini sıfıra indirir.
3.  **Dependency Injection**: Riverpod kullanılarak servisler ve repository'ler ihtiyaç duyulan yerlere enjekte ediliyor. Test edilebilirliği artırır.
