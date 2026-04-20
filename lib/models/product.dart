class StockItem {
  final int id;
  final String name;
  final String category;
  final String icon;
  final int quantity;
  final String unit;
  final DateTime expiryDate;
  final DateTime purchaseDate;

  StockItem({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
    required this.quantity,
    required this.unit,
    required this.expiryDate,
    required this.purchaseDate,
  });

  int get daysLeft => expiryDate.difference(DateTime.now()).inDays;

  String get status {
    if (daysLeft <= 2) return 'danger';
    if (daysLeft <= 7) return 'warning';
    return 'normal';
  }

  String get statusText {
    if (daysLeft <= 0) return 'Süresi doldu!';
    if (daysLeft == 1) return '1 gün kaldı';
    return '$daysLeft gün kaldı';
  }
}