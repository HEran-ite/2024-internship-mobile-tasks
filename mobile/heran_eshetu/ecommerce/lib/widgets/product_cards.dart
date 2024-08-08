import 'package:ecommerce/dummy_data/products_data.dart';
import 'package:ecommerce/screens/product_detail_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

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
              borderRadius: BorderRadius.only(
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
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name,
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      Text("\$ ${product.price.toString()}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.category,
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
                            '(${product.rating})',
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
