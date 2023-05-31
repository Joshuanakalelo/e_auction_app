import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(AuctionApp());
}

class AuctionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Auction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuctionHomePage(),
    );
  }
}

class AuctionHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoe Auction App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSection(),
            SizedBox(height: 16),
            ProductCarouselSection(),
            SizedBox(height: 16),
            NewsPromotionCarouselSection(),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          // Handle profile picture click
        },
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/profile_picture.png'),
        ),
      ),
      title: Text('Joshua Nakalelo'),
      subtitle: Text('Bidder'),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double currentBid;
  final String image;

  Product(this.name, this.description, this.currentBid, this.image);
}

class ProductCarouselSection extends StatefulWidget {
  @override
  _ProductCarouselSectionState createState() => _ProductCarouselSectionState();
}

class _ProductCarouselSectionState extends State<ProductCarouselSection> {
  List<Product> products = [
    Product(
      'Nike Air Max',
      'The Nike Air Max is a stylish and comfortable shoe with excellent cushioning.',
      100.0,
      'assets/nike_shoe.png',
    ),
    Product(
      'Adidas Ultraboost',
      'The Adidas Ultraboost is a high-performance running shoe that provides great energy return.',
      150.0,
      'assets/adidas_shoe.png',
    ),
    Product(
      'Puma RS-X',
      'The Puma RS-X is a retro-style sneaker with a unique and fashionable design.',
      120.0,
      'assets/puma_shoe.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Featured Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailPage(product: products[index]),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(products[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        products[index].name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${products[index].currentBid.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NewsPromotionCarouselSection extends StatelessWidget {
  final List<String> promotions = [
    'assets/promo.jpeg',
    'assets/promo.jpeg',
    'assets/promo.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'News & Promotions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: promotions.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 250,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(promotions[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double bidAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Price: \$${widget.product.currentBid.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        bidAmount = double.tryParse(value) ?? 0.0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Bid Amount',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid bid amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BiddingProgressPage(
                            product: widget.product,
                            bidAmount: bidAmount,
                          ),
                        ),
                      );
                    },
                    child: Text('Submit Bid'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BiddingProgressPage extends StatelessWidget {
  final Product product;
  final double bidAmount;

  BiddingProgressPage({required this.product, required this.bidAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bidding Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product: ${product.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Bid Amount: \$${bidAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Your bid has been submitted successfully.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
