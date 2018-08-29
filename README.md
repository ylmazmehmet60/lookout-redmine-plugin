# Hakkında
  Bu uygulama redmine iş takip sistemi için geliştirilmiş bir eklentidir. 
  
# Özellikler  
  -  Bir projedeki tüm iş kayıtlarının iş numarası, durumu, konusu, kategorisi, durum değişikliği sahibi ve harcanan zaman gibi bilgilerini liste halinde arayüzden sıralamaktadır.
  -  Sonuçlar için iş numarası, kategori ve durum değişikliği sahibi alanlarını sıralanabilir.
  -  Eklenti proje bazlı açıp kapanabilir.
  -  Bir işe tıklandığında iş durumu zamanları aynı sayfa üzerinde popup penceresinde grafiklerle gösterilebilir.
  -  Tüm proje için iş durumu zaman toplamları kullanıcı ve iş kategorisine göre gruplandırılıp grafiklerle gösterilebilir.

### Kurulum
```sh 
$ cd {REDMINE_ROOT}
$ git clone https://gitlab.com/ylmazmehmet60/lookout-redmine-plugin.git plugins/lookouts
$ bundle exec rake redmine:plugins:migrate RAILS_ENV=production
```

### Versiyon
- Geliştirme sürümü
	- redmine-3.4.2 
- Test sürümü
	- redmine-3.4.6
- Rails 4.2.8
- ruby 2.3.3p222

### Kullanılan yöntemler
  -  Verilere erişim
  
     Veritabanından Issue verilerine erişmek için redmine API dosyalarından faydalandım.
Bu API'lere direk kullanmak yerine özelleştirdim çünkü redminenin kendi API dosyalarında harcanan zaman ve toplam harcanan zamanlar alanı yoktu. Bunun için yeni bir controller oluşturup  gereksiz alanları sildim.  'spent_hours' ve 'total_spent_hours' gibi alanları ekledim. Bunun faydaları, tüm grafikler için ilk istek yapılan JSON dosyasının verilerini kullanabildim ve Issues.json isteğinden daha hızlı sonuç aldım. Böylece kaynakları en az maliyetle kullanabildim.

  -  Verilerin gösterilmesi
  
    Verilerin ekrana yazdırılması için JSON veriye controllerden ulaşmak yerine Vue.js framework kullandım. Bu Vue.js öğrenme aşamasında olduğum için kişisel bir tercihti. Ekrana yazılan verilerin tümüne sırayla ulaşmak için Paginator kullandım. İş numarası, kategori ve durum değişikliği sahibi alanlarının sıralanması için helper içerisinde bir fonksiyon kullandım. Çünkü sıralama isteğine göre json linkine ekleme yapılması gerekiyordu. Böylece ile üç alanında sıralamasını gerçekleştirdim. 


  -  Zaman grafikleri 
  
    Bir iş için harcanan grafiği için listede bir işe tıklandığında popup penceresi açılması için ajax modal kullandım.Konu linklerine tıkladığında JS isteği ile açılacak sayfayı belirledim. Grafikler için 'chartkick' javascript kütüphanesini kullandım ve popups controllerine linkler ile gönderidiğim verileri kullandım. Tüm proje için iş durumu zaman toplamları kullanıcı ve iş kategorisi için her iki grafikte gruplandırma olacağı için json ile ulaşmam mümkün değildi. O yüzden veritabanı sorgusu gerçekleştirdim. Elde edilen verileri grafiklere yerleştirdim. 

  -  Rotalar
  
    Listeleme, grafikler ve API'ler için üç tane rota ayarlayıp kullanılacak fonksiyonları belirledim.

### Resimler

![1](/uploads/e8af6d2ebc5efcbb3e748fef7f3fa01a/1.PNG)
![2](/uploads/9f0b6a5771a1a143397254c492533628/2.PNG)
![3](/uploads/210d080d8aa9f3727b641f2c03bdee8e/3.PNG)