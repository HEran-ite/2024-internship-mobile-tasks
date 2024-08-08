import 'package:ecommerce/widgets/size_container.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(children: [
              AspectRatio(
                aspectRatio: 16 / 12,
                child: Image.asset(
                  'images/nike.jpg',
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
                        'Men\'s shoe',
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
                            '(4.0)',
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
                        'Nike Air Max 270',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      Text("\$ 100"),
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
                      SizeContainer(size: 39),
                      SizeContainer(size: 40),
                      SizeContainer(size: 41),
                      SizeContainer(size: 42),
                      SizeContainer(size: 43),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Text(
                        'Lorem ipsum dolor sit amet  derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
