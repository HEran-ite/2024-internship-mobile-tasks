import 'package:ecommerce/dummy_data/products_data.dart';
import 'package:ecommerce/entitity/product.dart';
import 'package:ecommerce/widgets/size_container.dart';
import 'package:flutter/material.dart';

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
        (ModalRoute.of(context)?.settings?.arguments as Map?) ?? {};
    final Product product = arguments['product'];
    final List<Product> products = arguments['products'];
    selectedSize ??= product.size[0];
    return Scaffold(
      body: Container(
        child: Column(
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
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
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
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.category,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: Color.fromARGB(255, 246, 186, 45),
                          ),
                          Text(
                            product.rating,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      Text(product.price.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Size:',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Text(
                        product.description,
                        style: TextStyle(fontSize: 15),
                      )),
                  SizedBox(
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
                        child: Text('DELETE',
                            style: TextStyle(
                              color: Colors.red,
                            )),
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: 20, horizontal: 50)),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.red)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/add_product_page',
                              arguments: {
                                'product': product,
                                'products': products,
                              });
                        },
                        child: Text('UPDATE',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: 20, horizontal: 50)),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 32, 77, 202)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
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
  }
}
