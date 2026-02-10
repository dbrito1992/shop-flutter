import 'dart:math';

import 'package:shop/models/product.dart';

final dummyProduct = [
  Product(
    id: Random().nextDouble().toString(),
    name: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: Random().nextDouble().toString(),
    name: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl:
        'https://static.vecteezy.com/ti/fotos-gratis/p2/4962532-jeans-calca-jeans-isolado-azul-dobrado-jeans-isolado-no-fundo-branco-close-up-foto.jpg',
  ),
  Product(
    id: Random().nextDouble().toString(),
    name: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: Random().nextDouble().toString(),
    name: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'https://io.convertiez.com.br/m/lojasedmil/shop/products/images/1683/medium/panela-philco-definitive-pph240apr-redstone-com-tampa-de-vidro-27l-cinza-e-vermelho_14136.jpg',
  ),
];
