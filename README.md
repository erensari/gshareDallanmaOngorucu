# Gshare Dallanma Öngörücü Modülü

Bu proje, Verilog dilinde yazılmış bir **Gshare Dallanma Öngörücü** modülüdür. Dallanma öngörüsü, işlemcilerde dallanma talimatlarının tahmin edilmesi amacıyla kullanılan bir tekniktir. Bu modülde **Gshare algoritması** kullanılmıştır.

## Modül Özeti

`ongorucu` modülü, verilen girişlere göre dallanma öngörüsü yapar ve tahmini dallanma adresini üretir. Bu işlem, bir geçmiş sayacı ve bir tahmin tablosu ile gerçekleştirilir.

### Temel Özellikler:
- **Gshare algoritması** ile dallanma öngörüsü.
- Dinamik dallanma tahmin tablosu (`2-bit saturating counter`).
- İlk başlatma sırasında zayıf tahmin durumu (`2'b10`) ile başlatılan tablo.
- Doğru ve yanlış tahminlere göre tahmin tablosunun güncellenmesi.
- **Offset hesaplama** ile dallanma hedef adresi tahmini.

---

## Bağımsız Değişkenler ve Giriş/Çıkışlar

### Girişler:
- `clk`: Saat sinyali.
- `rst`: Reset sinyali, tahmin tablosunu ve geçmiş sayacını sıfırlar.
- `getir_ps`: Getir aşamasındaki program sayacı (PC).
- `getir_buyruk`: Getir aşamasındaki buyruk.
- `getir_gecerli`: Getir aşamasının geçerlilik sinyali.
- `yurut_ps`: Yürütme aşamasındaki program sayacı.
- `yurut_buyruk`: Yürütme aşamasındaki buyruk.
- `yurut_dallan`: Gerçekleşen dallanma bilgisi.
- `yurut_dallan_ps`: Yürütme aşamasındaki dallanma adresi.
- `yurut_gecerli`: Yürütme aşamasının geçerlilik sinyali.

### Çıkışlar:
- `sonuc_dallan`: Öngörülen dallanma durumu (1: dallanma, 0: dallanma yok).
- `sonuc_dallan_ps`: Öngörülen dallanma program sayacı (PC).

---
