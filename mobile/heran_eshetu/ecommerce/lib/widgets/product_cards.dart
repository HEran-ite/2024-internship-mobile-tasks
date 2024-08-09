import 'package:flutter/material.dart';
import '../dummy_data/products_data.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.category,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Color.fromARGB(255, 246, 186, 45),
                          ),
                          Text(
                            '(${product.rating})',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey),
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
