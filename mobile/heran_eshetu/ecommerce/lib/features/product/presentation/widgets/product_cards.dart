import 'package:flutter/material.dart';
import '../../../../core/utils/dummy_data/products_data.dart';
import '../../domain/entitity/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    required this.product,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildCards(context),
    );
  }
}

List<Card> _buildCards(BuildContext context) {
  return Products.map((product) {
    return Card(
      shadowColor: Colors.black,
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/product_detail_page',
            arguments: {
              'product': product,
              'products': Products,
            },
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name,
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                      Text('\$ ${product.price.toString()}'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // product.category,
                        'men\'s shoe',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Color.fromARGB(255, 246, 186, 45),
                          ),
                          Text(
                            // '(${product.rating})',
                            '4.0',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }).toList();
}
