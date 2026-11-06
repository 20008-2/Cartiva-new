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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF173B67),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
      ),
      home: const CartivaHomePage(),
    );
  }
}

class Product {
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

const List<Product> shopProducts = [
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

const List<Product> partnerProducts = [
  Product(
    name: 'Home & Lifestyle Picks',
    description: 'Discover selected products from partner stores.',
    price: 'View partner offer',
    imageUrl: 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=900',
  ),
  Product(
    name: 'Fashion Finds',
    description: 'Explore fashion products from partner stores.',
    price: 'View partner offer',
    imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=900',
  ),
];

class CartivaHomePage extends StatefulWidget {
  const CartivaHomePage({super.key});

  @override
  State<CartivaHomePage> createState() => _CartivaHomePageState();
}

class _CartivaHomePageState extends State<CartivaHomePage> {
  int selectedIndex = 0;
  final List<Product> cart = [];

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to your cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildShopPage(),
      _buildCartPage(),
      _buildPartnerPage(),
      _buildAboutPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CARTIVA',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: false,
        backgroundColor: const Color(0xFF173B67),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Shopping cart',
            onPressed: () => setState(() => selectedIndex = 1),
            icon: Badge(
              label: Text('${cart.length}'),
              isLabelVisible: cart.isNotEmpty,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Shop'),
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.link_outlined), label: 'Partner Deals'),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'About'),
        ],
      ),
    );
  }

  Widget _buildShopPage() {
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
              SizedBox(height: 8),
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
        ...shopProducts.map(
          (product) => _productCard(product, isPartner: false),
        ),
      ],
    );
  }

  Widget _buildPartnerPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Partner Deals',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Browse products offered by partner stores. Partner links and tracking still need to be connected before launch.',
        ),
        const SizedBox(height: 16),
        ...partnerProducts.map(
          (product) => _productCard(product, isPartner: true),
        ),
      ],
    );
  }

  Widget _productCard(Product product, {required bool isPartner}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 170,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.image_not_supported_outlined, size: 42),
                  ),
                );
              },
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
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B67),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        if (isPartner) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Partner shopping links have not been connected yet.',
                              ),
                            ),
                          );
                        } else {
                          addToCart(product);
                        }
                      },
                      child: Text(isPartner ? 'Partner offer' : 'Add to cart'),
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

  Widget _buildCartPage() {
    if (cart.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
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
                tooltip: 'Remove item',
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() {
                    cart.removeAt(index);
                  });
                },
              ),
            ),
          );
        }),
        const SizedBox(height: 12),
        const Text(
          'Demo only: checkout and real payments are not connected yet.',
          style: TextStyle(color: Colors.redAccent),
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Checkout is a demo. Payment setup is still required.',
                ),
              ),
            );
          },
          child: const Text('Continue to checkout'),
        ),
      ],
    );
  }

  Widget _buildAboutPage() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About CARTIVA',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'CARTIVA is a shopping platform concept designed to bring useful products and partner deals together in one place.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          SizedBox(height: 12),
          Text(
            'Your Home of Quality and Long-Lasting Products',
            style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
          ),
          SizedBox(height: 18),
          Text(
            'This is an early starter app. Supplier ordering, delivery, affiliate tracking, customer accounts, secure payments, and order management must be added and tested before the app is used for real purchases.',
            style: TextStyle(color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }
}
