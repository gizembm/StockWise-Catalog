# 📦 StockWise — Akıllı Ev Stok & Son Kullanma Tarihi Takip Uygulaması

StockWise, evdeki ürünlerin stok miktarını ve son kullanma tarihlerini takip etmek için geliştirilmiş bir mobil uygulamadır. Flutter ile geliştirilmiş olup TNC Group mobil uygulama eğitiminin bitirme projesidir.

---

## 📱 Ekran Görüntüleri

| Login | Ana Sayfa | Ürün Detayı | STT Takip |
|-------|-----------|-------------|-----------|
| <img src="https://github.com/user-attachments/assets/82e83304-fe67-404e-b644-dfabd1a17f56" width="200"/> | <img src="https://github.com/user-attachments/assets/1b824de8-f342-4194-b611-885e12699375" width="200"/> | <img src="https://github.com/user-attachments/assets/cfce8741-df4a-4034-a0a6-f2f6041993ee" width="200"/> | <img src="https://github.com/user-attachments/assets/1e98bbd0-9043-4659-ad8d-4f499c905326" width="200"/> |

---

## ✨ Özellikler

- 🔐 **Kullanıcı Girişi** — E-posta ve şifre ile giriş, hatalı girişte uyarı mesajı
- 📋 **Stok Listesi** — Evdeki tüm ürünler GridView ile kart tabanlı listelenir
- 🔍 **Arama & Filtreleme** — Anlık arama ile ürünler filtrelenir
- 🟢🟡🔴 **Durum Renkleri** — Son kullanma tarihine göre otomatik renk sistemi
  - 🔴 Kırmızı → 1-2 gün kaldı (Kritik)
  - 🟡 Sarı → 3-7 gün kaldı (Uyarı)
  - 🟢 Yeşil → 7+ gün kaldı (Normal)
- ⏰ **STT Takip Sekmesi** — Son kullanma tarihi yaklaşan ürünler ayrı sekmede listelenir
- 📄 **Ürün Detayı** — Miktar, son kullanma tarihi, alınma tarihi ve kategori bilgileri
- 🚪 **Çıkış Yapma** — Kullanıcı hesabından güvenli çıkış

---

## 🛠️ Kullanılan Teknolojiler

| Teknoloji | Versiyon |
|-----------|----------|
| Flutter | 3.41.7 (channel stable) |
| Dart | 3.11.5 |
| DevTools | 2.54.2 |
| Android SDK | 37.0.0 (platform android-36-ext19) |
| Android Studio | Android Studio (latest) |

> Ekstra paket kullanılmamıştır. Yalnızca Flutter'ın yerleşik `material.dart` paketi kullanılmıştır.

---

## 📁 Proje Klasör Yapısı

```
stockwisemobil/
├── lib/
│   ├── main.dart                  # Uygulama giriş noktası, route tanımları
│   ├── models/
│   │   └── product.dart           # StockItem veri modeli
│   ├── screens/
│   │   ├── login_screen.dart      # Giriş ekranı
│   │   ├── home_screen.dart       # Ana sayfa (stok listesi)
│   │   ├── product_detail_screen.dart  # Ürün detay ekranı
│   │   └── expiry_screen.dart     # STT takip ekranı
│   ├── widgets/
│   │   └── product_card.dart      # Yeniden kullanılabilir stok kartı
│   └── data/
│       └── stock_data.dart        # JSON'dan veri yükleme
├── assets/
│   └── stocks.json                # Ürün verileri (JSON)
└── pubspec.yaml
```

---

## 🚀 Çalıştırma Adımları

### Gereksinimler
- Flutter SDK 3.41.7 (channel stable)
- Android Studio (Emülatör için)
- VS Code veya Android Studio (IDE)

### Kurulum

**1. Repoyu klonla:**
```bash
git clone https://github.com/KULLANICI_ADIN/stockwisemobil.git
cd stockwisemobil
```

**2. Bağımlılıkları yükle:**
```bash
flutter pub get
```

**3. Emülatörü başlat:**

Android Studio → Device Manager → Pixel 9 → ▶ butonuna bas

**4. Uygulamayı çalıştır:**
```bash
flutter run
```

---

## 🔑 Giriş Bilgileri

Uygulamayı test etmek için aşağıdaki bilgileri kullanabilirsiniz:

```
E-posta : gizem@stockwise.com
Şifre   : 123456
```

---

## 📂 Veri Kaynağı

Uygulama verileri `assets/stocks.json` dosyasından okunmaktadır. Bu dosya Flutter'ın `rootBundle.loadString` metodu ile yüklenmekte ve `fromJson` mantığıyla modele dönüştürülmektedir.

```json
[
  {
    "id": 1,
    "name": "Süt",
    "category": "Süt Ürünleri",
    "icon": "🥛",
    "quantity": 2,
    "unit": "adet",
    "daysUntilExpiry": 1,
    "daysSincePurchase": 5
  }
]
```

---

## 🧭 Sayfa Akışı

```
Login Ekranı
     │
     ▼  (Giriş Yap)
Ana Sayfa (Stok Listesi)
     │                  │
     ▼  (Karta tıkla)   ▼  (Alt nav: STT Takip)
Ürün Detayı         STT Takip Ekranı
     │
     ▼  (Geri)
Ana Sayfa
     │
     ▼  (Çıkış Yap)
Login Ekranı
```

---

## 📘 Öğrenilen Flutter Konuları

Bu proje kapsamında aşağıdaki Flutter konuları uygulamalı olarak kullanılmıştır:

- **Widget yapısı** — Stateless ve Stateful widget kullanımı
- **Navigator & Route** — `pushNamed`, `pushReplacementNamed`, `onGenerateRoute`
- **Route Arguments** — Sayfalar arası `StockItem` nesnesi taşıma
- **GridView.builder** — Dinamik kart tabanlı ızgara görünümü
- **ListView.builder** — Dinamik liste görünümü
- **setState** — Arama filtreleme ve UI güncelleme
- **Asset yönetimi** — `pubspec.yaml` ile JSON dosyası tanımlama
- **rootBundle** — `assets/stocks.json` dosyasını okuma
- **Proje klasör yapısı** — `models/`, `screens/`, `widgets/`, `data/`

---

## 👩‍💻 Geliştirici

**Gizem Efe**
TNC Group — Flutter Mobil Uygulama Eğitimi
