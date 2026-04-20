import 'package:flutter/material.dart';
import '../models/product.dart';

class StockCard extends StatelessWidget {
  final StockItem item;
  final VoidCallback onTap;

  const StockCard({super.key, required this.item, required this.onTap});

  Color get bgColor {
    if (item.status == 'danger') return const Color(0xFFFFF5F5);
    if (item.status == 'warning') return const Color(0xFFFFFBEB);
    return Colors.white;
  }

  Color get borderColor {
    if (item.status == 'danger') return const Color(0xFFFCA5A5);
    if (item.status == 'warning') return const Color(0xFFFCD34D);
    return const Color(0xFFE5E7EB);
  }

  Color get dotColor {
    if (item.status == 'danger') return const Color(0xFFEF4444);
    if (item.status == 'warning') return const Color(0xFFF59E0B);
    return const Color(0xFF10B981);
  }

  Color get textColor {
    if (item.status == 'danger') return const Color(0xFF7F1D1D);
    if (item.status == 'warning') return const Color(0xFF78350F);
    return Colors.black87;
  }

  Color get subTextColor {
    if (item.status == 'danger') return const Color(0xFFB91C1C);
    if (item.status == 'warning') return const Color(0xFFD97706);
    return Colors.black45;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst satır: ikon + durum noktası
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: borderColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(item.icon,
                        style: const TextStyle(fontSize: 22)),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: dotColor, shape: BoxShape.circle),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Ürün adı
            Text(
              item.name,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor),
            ),
            const SizedBox(height: 4),
            // Miktar
            Text(
              '${item.quantity} ${item.unit}',
              style: TextStyle(fontSize: 12, color: subTextColor),
            ),
            const Spacer(),
            // Kalan süre etiketi
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: dotColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item.statusText,
                style: TextStyle(
                    fontSize: 10,
                    color: dotColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}