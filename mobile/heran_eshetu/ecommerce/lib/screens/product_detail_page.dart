import 'package:flutter/material.dart';

import '../dummy_data/products_data.dart';
import '../entitity/product.dart';
import '../widgets/size_container.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int? selectedSize;
  @override
  Widget build(BuildContext context) {
    final Map arguments =
        (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final Product product = arguments['product'];
    final List<Product> products = arguments['products'];
    selectedSize ??= product.size[0];
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            AspectRatio(
              aspectRatio: 16 / 12,
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.category,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Color.fromARGB(255, 246, 186, 45),
                        ),
                        Text(
                          product.rating,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    Text(product.price.toString()),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      'Size:',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    for (var sz in product.size)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = sz;
                          });
                        },
                        child: SizeContainer(
                            size: sz, isSelected: selectedSize == sz),
                      )
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Text(
                      product.description,
                      style: const TextStyle(fontSize: 15),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        for (Product pro in Products) {
                          if (product.name == pro.name) {
                            products.remove(product);
                            break;
                          }
                        }
                        Navigator.pushNamed(context, '/homepage');
                      },
                      style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(
                            vertical: 20, horizontal: 50)),
                        side: WidgetStateProperty.all(
                            const BorderSide(color: Colors.red)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      ),
                      child: const Text('DELETE',
                          style: TextStyle(
                            color: Colors.red,
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add_product_page',
                            arguments: {
                              'product': product,
                              'products': products,
                            });
                      },
                      style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(
                            vertical: 20, horizontal: 50)),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 32, 77, 202)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      ),
                      child: const Text('UPDATE',
                          style: TextStyle(color: Colors.white)),
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
}
