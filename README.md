Namaz Vakti Uygulaması

Genel Bakış

Namaz Vakti Uygulaması, kullanıcılara namaz vakitlerini, kıble yönünü ve diğer önemli dini bilgileri sunan bir Flutter tabanlı mobil uygulamadır. Kullanıcı dostu arayüzü ve özelleştirilebilir tema seçenekleriyle kolay kullanım sağlar.

Özellikler

Namaz Vakitleri: Güncel namaz vakitlerini gösterir.

Kıble Yönü: Kıble yönünü tespit ederek kullanıcıya yönlendirme sağlar.

Tema Seçenekleri: Koyu ve açık tema arasında geçiş yapma.

Geçişli Arka Plan: Arka plan geçiş efektini etkinleştirme veya devre dışı bırakma.

Şehir Konumu: Kullanıcının bulunduğu şehir bilgilerini otomatik olarak algılama veya manuel olarak güncelleme.

Kurulum

Gereksinimler

Flutter SDK (v3.0.0 veya üzeri)

Android Studio veya Visual Studio Code

Android/iOS cihaz ya da emülatör

Adımlar

Projeyi klonlayın:

git clone <repository-link>

Proje dizinine gidin:

cd namaz-vakti-app

Gerekli bağımlılıkları yükleyin:

flutter pub get

Uygulamayı çalıştırın:

flutter run

Kullanım

Başlangıç

Uygulamayı açtığınızda, "Hoşgeldiniz" ekranı sizi karşılar. Buradan konumunuzu belirleyebilir ve başlangıç ayarlarınızı yapabilirsiniz.

Namaz Vakitleri

Ana ekran üzerinden güncel namaz vakitlerini takip edebilirsiniz.

Tarih seçerek farklı günlerin namaz vakitlerine ulaşabilirsiniz.

Kıble Yönü

"Kıble" sekmesine giderek kıble yönünüzü bulabilirsiniz.

Ayarlar

Uygulama temasını (koyu/açık) ve arka plan geçiş efektlerini ayarlayabilirsiniz.

Şehir bilgilerinizi güncelleyebilirsiniz.

Yapı

Uygulama şu temel modüllerden oluşur:

main.dart: Uygulamanın başlangıç noktası.

home_page.dart: Ana ekran tasarımı ve gezinme işlemleri.

settings.dart: Kullanıcı ayarlarının yönetildiği ekran.

qibla.dart: Kıble yönü hesaplama ve görselleştirme modülü.

time_data.dart: Namaz vakitleri verilerinin yönetimi ve işlenmesi.

location.dart: Kullanıcının konum bilgilerini işleme ve güncelleme.

Bağımlılıklar

provider: Durum yönetimi için.

shared_preferences: Kullanıcı ayarlarını yerel olarak saklamak için.

connectivity_plus: İnternet bağlantı kontrolü için.

geolocator: Kullanıcı konumunu almak için.

intl: Tarih ve saat formatlama için.

hijri: Hicri takvim hesaplamaları için.
