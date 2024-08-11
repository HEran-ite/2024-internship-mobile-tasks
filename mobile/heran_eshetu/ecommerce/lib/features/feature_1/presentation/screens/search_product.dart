import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/product_cards.dart';
import '../widgets/text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isFilter = false;
  RangeValues _values = const RangeValues(20, 80);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Add Product',
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.arrow_forward),
                        suffixIconColor: Color.fromARGB(255, 32, 77, 202)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 32, 77, 202),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isFilter = !isFilter;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Stack(children: [
                const ProductCard(),
                if (isFilter)
                  Expanded(
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 450,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        color: Colors.white,
                        child: Column(
                          children: [
                            MyTextField(
                              controller: TextEditingController(),
                              lable: 'Category',
                              lines: 1,
                              suffIcon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Price',
                                  style: TextStyle(fontSize: 16),
                                ),
                                RangeSlider(
                                  values: _values,
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _values = values;
                                    });
                                  },
                                  min: 1,
                                  max: 100,
                                  divisions: 100,
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 32, 77, 202),
                                ),
                                padding: const EdgeInsets.all(15),
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 40, bottom: 10),
                                child: const Text(
                                  'APPLY',
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
