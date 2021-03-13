import 'package:flutter/material.dart';
import '../colors.dart';

class Categories {
  final IconData icons;
  final String categoryName;
  final List lists;

  Categories({
    this.icons,
    this.categoryName,
    this.lists,
  });
}

List<Categories> categories = <Categories>[
  Categories(
    icons: Icons.shopping_bag,
    categoryName: 'Магазины мебели',
  ),
  Categories(
    icons: Icons.laptop_mac,
    categoryName: 'Ноутбуки',
    lists: laptops,
  ),
  Categories(
    categoryName: 'Стулья',
    icons: Icons.event_seat,
    lists: chairs,
  ),
  Categories(
    icons: Icons.single_bed,
    categoryName: 'Кровати',
    lists: laptops,
  ),
  Categories(
    icons: Icons.card_travel,
    categoryName: 'Другие компьютеры',
    lists: laptops,
  ),
  Categories(
    icons: Icons.event_seat,
    categoryName: 'Другие магазины',
    lists: laptops,
  ),
  Categories(
    icons: Icons.laptop_chromebook,
    categoryName: 'Другие магазины',
    lists: laptops,
  ),
  Categories(
    icons: Icons.laptop,
    categoryName: 'Другие магазины',
    lists: laptops,
  ),
  Categories(
    icons: Icons.shopping_basket,
    categoryName: 'Другие магазины',
    lists: laptops,
  ),
  Categories(
    icons: Icons.shopping_basket,
    categoryName: 'Другие магазины',
    lists: laptops,
  ),
  Categories(
    icons: Icons.shopping_basket,
    categoryName: 'Другие магазины',
    lists: laptops,
  ),
];

class Shops {
  final String shopName;
  final String subtitle;
  final String products;
  final String rating;
  final String imageUrl;

  Shops({
    this.shopName,
    this.subtitle,
    this.products,
    this.rating,
    this.imageUrl,
  });
}

List<Shops> shops = [
  Shops(
      shopName: 'Mebel.kz',
      subtitle:
          'Наш мазагин самый лучший в стране, имеет большое количество хороших товаров.',
      products: '512',
      rating: '4.8',
      imageUrl: 'assets/images/mebelKz.png'),
  Shops(
    shopName: 'EuroMebel',
    subtitle:
        'Наш мазагин самый лучший в Казахстане, имеет большое количество хороших товаров.',
    products: '456',
    rating: '4.5',
    imageUrl: 'assets/images/euroMebel.png',
  )
];

class Products {
  final String laptopName;
  final String subtitle;
  final int cost;
  bool isLiked;
  bool exists;
  final List<String> imageUrl;
  final String typeImage;
  final List<Color> colors;
  int amount;
  int selectedColor;

  Products({
    this.laptopName,
    this.subtitle,
    this.cost,
    this.isLiked,
    this.imageUrl,
    this.exists,
    this.colors,
    this.amount = 1,
    this.typeImage,
    this.selectedColor = 0,
  });
}

List<Products> laptops = [
  Products(
    laptopName: 'Lenovo',
    subtitle:
        'Наш мазагин самый лучший в стране, имеет большое количество хороших товаров. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Id semper risus in hendrerit gravida rutrum quisque. Molestie ac feugiat sed lectus vestibulum mattis ullamcorper velit sed. Ut aliquam purus sit amet luctus venenatis. Fermentum et sollicitudin ac orci phasellus.',
    cost: 512000,
    exists: true,
    isLiked: false,
    colors: [
      blue,
      Colors.blueAccent,
      Colors.grey,
    ],
    imageUrl: [
      'assets/images/lenovo.png',
      'assets/images/laptop-1.webp',
      'assets/images/laptop-2.jpg'
    ],
    typeImage: "assets/images/laptop 2.png",
  ),
  Products(
    laptopName: 'Macbook Pro',
    subtitle:
        'Наш мазагин самый лучший в Казахстане, имеет большое количество хороших товаров.',
    cost: 456000,
    exists: false,
    isLiked: false,
    colors: [
      white,
      Colors.blue,
      Colors.green[300],
      Colors.amber,
    ],
    imageUrl: [
      'assets/images/macbook.jpg',
      'assets/images/laptop-3.jpg',
      'assets/images/laptop-4.webp',
    ],
    typeImage: "assets/images/laptop 2.png",
  ),
  Products(
    laptopName: 'Macbook Pro',
    subtitle:
        'Наш мазагин самый лучший в Казахстане, имеет большое количество хороших товаров.',
    cost: 456000,
    exists: false,
    isLiked: false,
    colors: [
      white,
      Colors.blue,
      Colors.green[300],
      Colors.amber,
    ],
    imageUrl: [
      'assets/images/laptop-4.webp',
      'assets/images/macbook.jpg',
      'assets/images/laptop-3.jpg',
    ],
    typeImage: "assets/images/laptop 2.png",
  )
];

List<Products> chairs = [
  Products(
    laptopName: 'Excellent Chair',
    subtitle:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Id semper risus in hendrerit gravida rutrum quisque. Molestie ac feugiat sed lectus vestibulum mattis ullamcorper velit sed. Ut aliquam purus sit amet luctus venenatis. Fermentum et sollicitudin ac orci phasellus.',
    cost: 114000,
    exists: true,
    isLiked: false,
    colors: [
      blue,
      Colors.blueAccent,
      Colors.grey,
    ],
    imageUrl: [
      'assets/images/chair1.jpg',
      'assets/images/chair2.jpg',
    ],
    typeImage: "assets/images/chair 2.png",
  ),
  Products(
    laptopName: 'Chair Pro',
    subtitle: 'adkjnkpkjdvbnajlcnajldncdjalvndajlvnadjlnvcadjlvndajl',
    cost: 136000,
    exists: false,
    isLiked: false,
    colors: [
      white,
      Colors.blue,
      Colors.green[300],
      Colors.amber,
    ],
    imageUrl: [
      'assets/images/chair3.jpg',
      'assets/images/chair4.jpg',
    ],
    typeImage: "assets/images/chair 2.png",
  )
];

List<Products> purchases = List<Products>();
List<Products> favorites = List<Products>();
