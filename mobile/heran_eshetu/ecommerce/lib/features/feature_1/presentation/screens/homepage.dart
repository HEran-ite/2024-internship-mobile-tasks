import 'package:flutter/material.dart';

import '../../../../core/utils/dummy_data/products_data.dart';
import '../widgets/product_cards.dart';

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
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
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
              const SizedBox(
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
              const SizedBox(
                height: 20,
              ),
              const Expanded(
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: const Color.fromARGB(255, 33, 75, 243),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
