import 'package:ecommerce/dummy_data/products_data.dart';
import 'package:ecommerce/widgets/product_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey,
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'August 14 ,2024',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text('Hello ,'),
                              Text(
                                'Heran',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ]),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined)),
                )
              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ' Available Products',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/search_page');
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ProductCard(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_product_page',
            arguments: {'products': Products});
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: const Color.fromARGB(255, 33, 75, 243),
        ));
  }
}
