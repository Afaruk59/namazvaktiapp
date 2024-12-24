#Namaz Vakti Uygulaması

Namaz Vakti Uygulaması, kullanıcıların günlük namaz vakitlerini takip etmelerine, kıble yönünü bulmalarına ve özelleştirilebilir ayarlarla uygulamayı kişisel tercihlerine göre kullanmalarına olanak tanıyan, Flutter tabanlı bir mobil uygulamadır.

#Genel Bakış
Bu uygulama, modern bir kullanıcı arayüzü ve kolay kullanım sağlayan özelliklerle donatılmıştır. Namaz Vakti Uygulaması, kullanıcıların bulunduğu konuma özel olarak namaz vakitlerini güncel bir şekilde sunar ve ibadetlerini kolaylaştırmak için ek araçlar sağlar.

#Özellikler

Namaz Vakitleri: Güncel namaz vakitlerini görüntüler ve belirli bir tarih için geçmiş ve gelecekteki vakitlere erişim sağlar.
Kıble Yönü: Kullanıcı cihazının sensörlerini kullanarak kıble yönünü belirler.
Tema Seçenekleri: Açık ve koyu tema arasında geçiş yapabilme.
Geçişli Arka Plan: Kullanıcı arayüzünde arka plan geçiş efektini etkinleştirme veya devre dışı bırakma.
Şehir Konumu: Kullanıcının bulunduğu şehir bilgisini otomatik olarak algılar veya manuel olarak değiştirme seçeneği sunar.


Kurulum
Gereksinimler
Flutter SDK (v3.0.0 veya üzeri)
Android Studio veya Visual Studio Code
Android/iOS cihaz ya da emülatör

Adımlar

Projeyi Klonlayın:
git clone <repository-link>

Proje Dizinine Geçin:
cd namaz-vakti-app

Gerekli Bağımlılıkları Yükleyin:
flutter pub get

Uygulamayı Çalıştırın:

Kullanım

Başlangıç

Uygulamayı açtığınızda sizi "Hoşgeldiniz" ekranı karşılar. Burada konum bilgilerinizi ayarlayabilir ve başlangıç seçeneklerinizi yapılandırabilirsiniz.

Namaz Vakitleri
Ana ekran üzerinden bulunduğunuz konuma göre namaz vakitlerini takip edebilirsiniz.
Tarih seçerek geçmiş veya gelecekteki namaz vakitlerini görüntüleyebilirsiniz.

Kıble Yönü

Kıble sekmesinden cihaz pusulası yardımıyla kıble yönünü bulabilirsiniz.

Ayarlar

Tema seçeneklerini (koyu/açık) ve arka plan geçiş efektlerini özelleştirebilirsiniz.
Şehir bilgilerinizi güncelleyerek doğru namaz vakitlerine erişebilirsiniz.

Yapı

Uygulama aşağıdaki ana dosya ve modüllerden oluşur:

main.dart: Uygulamanın giriş noktası.
home_page.dart: Ana ekran ve gezinme işlemleri.
settings.dart: Kullanıcı ayarlarını yapılandırma ekranı.
qibla.dart: Kıble yönü hesaplama ve görselleştirme modülü.
time_data.dart: Namaz vakitlerini yönetmek ve işlemek için kullanılan veri sınıfı.
location.dart: Kullanıcı konum bilgilerini işleyen modül.


Kullanılan Bağımlılıklar

provider: Durum yönetimi.
shared_preferences: Kullanıcı ayarlarının yerel cihazda depolanması.
connectivity_plus: İnternet bağlantı durumunu kontrol etmek için.
geolocator: Kullanıcı konumunu almak için.
intl: Tarih ve saat formatlama.
hijri: Hicri takvim hesaplamaları.
