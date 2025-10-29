class Product {
  final String name, subtitle, price, image_path;
  final bool isNew;
  final double rating;
  const Product({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.image_path,
    this.isNew = false,
    this.rating = 0,
  });
}

const products = <Product>[
  Product(
    name: 'Modern Chair',
    subtitle: 'Armchair',
    price: '\$185',
    image_path: 'assets/images/chair2.jpg',
    isNew: true,
    rating: 4.8,
  ),
  Product(
    name: 'Minimalist Chair',
    subtitle: 'Armchair',
    price: '\$258',
    image_path: 'assets/images/chair3.jpg',
    isNew: true,
    rating: 4.8,
  )
];