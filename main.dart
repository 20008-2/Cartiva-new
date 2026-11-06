import 'package:flutter/material.dart';

void main() {
  runApp(const CartivaApp());
}

class CartivaApp extends StatelessWidget {
  const CartivaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CARTIVA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF173B67),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
      ),
      home: const CartivaHomePage(),
    );
  }
}

class Product {
  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final String name;
  final String description;
  final String price;
  final String imageUrl;
}

const List<Product> products = [
  Product(
    name: 'Everyday Backpack',
    description: 'A practical bag for everyday use.',
    price: '₦18,000',
    imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=900',
  ),
  Product(
    name: 'Classic Wristwatch',
    description: 'A simple style for every occasion.',
    price: '₦25,000',
    imageUrl: 'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=900',
  ),
  Product(
    name: 'Wireless Headphones',
    description: 'Enjoy your favourite music.',
    price: '₦22,500',
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=900',
  ),
  Product(
    name: 'Modern Desk Lamp',
    description: 'A useful light for your workspace.',
    price: '₦15,000',
    imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=900',
  ),
];

const List<Product> partnerDeals = [
  Product(
    name: 'Home & Lifestyle Picks',
    description: 'Explore selected products from partner stores.',
    price: 'Partner offer',
    imageUrl: 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=900',
  ),
  Product(
    name: 'Fashion Finds',
    description: 'Discover fashion products from partner stores.',
    price: 'Partner offer',
    imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=900',
  ),
];

class CartivaHomePage extends StatefulWidget {
  const CartivaHomePage({super.key});

  @override
  State<CartivaHomePage> createState() => _CartivaHomePageState();
}

class _CartivaHomePageState extends State<CartivaHomePage> {
  int selectedTab = 0;
  final List<Product> cart = [];

  void addToCart(Product product) {
    setState(() => cart.add(product));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to your cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _shopPage(),
      _cartPage(),
      _partnerPage(),
      _aboutPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CARTIVA',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.4),
        ),
        backgroundColor: const Color(0xFF173B67),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Open cart',
            onPressed: () => setState(() => selectedTab = 1),
            icon: Badge(
              isLabelVisible: cart.isNotEmpty,
              label: Text('${cart.length}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: pages[selectedTab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() => selectedTab = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.link_outlined),
            label: 'Partner Deals',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }

  Widget _shopPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF173B67),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Everything You Want, All in One Place.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your Home of Quality and Long-Lasting Products',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Shop Products',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...products.map((product) => _productCard(product, false)),
      ],
    );
  }

  Widget _partnerPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Partner Deals',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Browse sample partner products. Real affiliate links must be added before launch.',
        ),
        const SizedBox(height: 16),
        ...partnerDeals.map((product) => _productCard(product, true)),
      ],
    );
  }

  Widget _productCard(Product product, bool isPartner) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 170,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.black12,
                child: const Center(
                  child: Icon(Icons.image_not_supported_outlined, size: 42),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(product.description),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.price,
                      style: const TextStyle(
                        color: Color(0xFF173B67),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        if (isPartner) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Partner links are not connected yet.',
                              ),
                            ),
                          );
                        } else {
                          addToCart(product);
                        }
                      },
                      child: Text(isPartner ? 'View offer' : 'Add to cart'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartPage() {
    if (cart.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text('Products you add will appear here.'),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Your Cart',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...List.generate(cart.length, (index) {
          final product = cart[index];
          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text(product.price),
              trailing: IconButton(
                tooltip: 'Remove',
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() => cart.removeAt(index));
                },
              ),
            ),
          );
        }),
        const SizedBox(height: 12),
        const Text(
          'Demo only: secure checkout and real payments are not connected.',
          style: TextStyle(color: Colors.redAccent),
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'This is a demo checkout. Payment setup is still required.',
                ),
              ),
            );
          },
          child: const Text('Continue to checkout'),
        ),
      ],
    );
  }

  Widget _aboutPage() {
    return const ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          'About CARTIVA',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          'CARTIVA is a shopping platform concept bringing useful products and partner deals together in one place.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        SizedBox(height: 12),
        Text(
          'Your Home of Quality and Long-Lasting Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 18),
        Text(
          'This is a starter app, not a live store. Supplier ordering, delivery, affiliate tracking, customer accounts, secure payments, privacy features, and order management must be added and tested before accepting real orders.',
          style: TextStyle(color: Colors.black54, height: 1.5),
        ),
      ],
    );
  }
}
