import 'package:flutter/material.dart';
import '../models/product.dart';

class ExpiryScreen extends StatelessWidget {
  final List<StockItem> stocks;

  const ExpiryScreen({super.key, required this.stocks});

  List<StockItem> get danger =>
      stocks.where((s) => s.status == 'danger').toList();
  List<StockItem> get warning =>
      stocks.where((s) => s.status == 'warning').toList();
  List<StockItem> get normal =>
      stocks.where((s) => s.status == 'normal').toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFF1B4332),
          padding: const EdgeInsets.fromLTRB(20, 52, 20, 20),
          width: double.infinity,
          child: const Text(
            'STT Takip',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (danger.isNotEmpty) ...[
                _sectionTitle('Kritik', const Color(0xFFEF4444)),
                ...danger.map((s) => _expiryCard(s)),
                const SizedBox(height: 12),
              ],
              if (warning.isNotEmpty) ...[
                _sectionTitle('Bu Hafta', const Color(0xFFF59E0B)),
                ...warning.map((s) => _expiryCard(s)),
                const SizedBox(height: 12),
              ],
              if (normal.isNotEmpty) ...[
                _sectionTitle('Normal', const Color(0xFF10B981)),
                ...normal.map((s) => _expiryCard(s)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color),
          ),
        ],
      ),
    );
  }

  Widget _expiryCard(StockItem item) {
    final dotColor = item.status == 'danger'
        ? const Color(0xFFEF4444)
        : item.status == 'warning'
            ? const Color(0xFFF59E0B)
            : const Color(0xFF10B981);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Text(item.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                Text(
                  'Son kullanma: ${item.expiryDate.day}/${item.expiryDate.month}/${item.expiryDate.year}',
                  style: const TextStyle(
                      fontSize: 11, color: Colors.black45),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: dotColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              item.statusText,
              style: TextStyle(
                  fontSize: 11,
                  color: dotColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}