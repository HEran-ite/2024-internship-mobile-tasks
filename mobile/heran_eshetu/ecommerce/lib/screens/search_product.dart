import 'package:ecommerce/widgets/app_bar.dart';
import 'package:ecommerce/widgets/product_cards.dart';
import 'package:ecommerce/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isFilter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Add Product',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
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
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 32, 77, 202),
                  ),
                  child: IconButton(
                    icon: Icon(
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
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Stack(children: [
                ProductCard(),
                if (isFilter)
                  Expanded(
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 450,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        color: Colors.white,
                        child: Column(
                          children: [
                            MyTextField(
                              lable: 'Category',
                              lines: 1,
                              suff_icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(fontSize: 16),
                                ),
                                RangeSlider(
                                  values: RangeValues(1, 100),
                                  onChanged: (RangeValues values) {},
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
                                  color: Color.fromARGB(255, 32, 77, 202),
                                ),
                                padding: EdgeInsets.all(15),
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 40, bottom: 10),
                                child: Text(
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
