import 'package:flutter/material.dart';
import '../data/stock_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'expiry_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StockItem> stocks = [];
  String searchQuery = '';
  int currentIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await loadStocks();
    setState(() {
      stocks = data;
      isLoading = false;
    });
  }

  List<StockItem> get filtered => stocks
      .where((s) =>
          s.name.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  List<StockItem> get expiringSoon =>
      stocks.where((s) => s.daysLeft <= 7).toList();

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesabınızdan çıkmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal',
                style: TextStyle(color: Colors.black45)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B4332),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text('Çıkış Yap'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F0),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF1B4332),
              ),
            )
          : currentIndex == 0
              ? _buildStockPage()
              : ExpiryScreen(stocks: stocks),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        selectedItemColor: const Color(0xFF1B4332),
        unselectedItemColor: Colors.black38,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Stok',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_rounded),
            label: 'STT Takip',
          ),
        ],
      ),
    );
  }

  Widget _buildStockPage() {
    return Column(
      children: [
        // Header
        Container(
          color: const Color(0xFF1B4332),
          padding: const EdgeInsets.fromLTRB(20, 52, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Merhaba,',
                      style: TextStyle(
                          color: Color(0xFF6EE7B7), fontSize: 13)),
                  Text('Gizem',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF2D6A4F),
                    child: Text('G',
                        style: TextStyle(
                            color: Color(0xFF6EE7B7),
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  // Çıkış butonu
                  IconButton(
                    onPressed: () => _logout(context),
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: Color(0xFF6EE7B7),
                    ),
                    tooltip: 'Çıkış Yap',
                  ),
                ],
              ),
            ],
          ),
        ),
        // Uyarı banner
        if (expiringSoon.isNotEmpty)
          Container(
            color: const Color(0xFFFFF3E0),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Color(0xFFD97706), size: 18),
                const SizedBox(width: 8),
                Text(
                  '${expiringSoon.length} ürün bu hafta bitiyor!',
                  style: const TextStyle(
                      color: Color(0xFF92400E), fontSize: 13),
                ),
              ],
            ),
          ),
        // Arama
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (val) => setState(() => searchQuery = val),
            decoration: InputDecoration(
              hintText: 'Ürün ara...',
              prefixIcon:
                  const Icon(Icons.search, color: Color(0xFF1B4332)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        // Liste başlığı
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Stok Listesi',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: const Text('+ Ekle',
                    style: TextStyle(color: Color(0xFF1B4332))),
              ),
            ],
          ),
        ),
        // GridView
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('Ürün bulunamadı'))
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return StockCard(
                      item: filtered[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: filtered[index],
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}