import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final StockItem item;

  const ProductDetailScreen({super.key, required this.item});

  Color get statusColor {
    if (item.status == 'danger') return const Color(0xFFEF4444);
    if (item.status == 'warning') return const Color(0xFFF59E0B);
    return const Color(0xFF10B981);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B4332),
        foregroundColor: Colors.white,
        title: const Text('Ürün Detayı'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Ürün görseli alanı
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(item.icon,
                      style: const TextStyle(fontSize: 72)),
                  const SizedBox(height: 12),
                  Text(item.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.category,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF065F46),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Uyarı kutusu
                  if (item.status != 'normal')
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: item.status == 'danger'
                            ? const Color(0xFFFFF5F5)
                            : const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: statusColor.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: statusColor, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.status == 'danger'
                                  ? 'Bu ürün çok yakında son kullanma tarihine ulaşıyor!'
                                  : 'Bu ürün bu hafta son kullanma tarihine ulaşıyor.',
                              style: TextStyle(
                                  color: statusColor, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Bilgi satırları
                  _infoRow('Miktar', '${item.quantity} ${item.unit}'),
                  _infoRow(
                    'Son Kullanma Tarihi',
                    _formatDate(item.expiryDate),
                    valueColor: item.status == 'danger'
                        ? const Color(0xFFDC2626)
                        : null,
                  ),
                  _infoRow(
                      'Alınma Tarihi', _formatDate(item.purchaseDate)),
                  _infoRow('Kategori', item.category),
                  _infoRow('Kalan Süre', item.statusText,
                      valueColor: statusColor),
                  const SizedBox(height: 24),
                  // Butonlar
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color(0xFF1B4332)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Güncelle',
                              style:
                                  TextStyle(color: Color(0xFF1B4332))),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B4332),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Tükendi'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 13, color: Colors.black45)),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? Colors.black87)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_month(date.month)} ${date.year}';
  }

  String _month(int m) {
    const months = [
      '',
      'Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz',
      'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'
    ];
    return months[m];
  }
}