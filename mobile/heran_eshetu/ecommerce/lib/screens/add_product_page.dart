import 'package:ecommerce/widgets/app_bar.dart';
import 'package:ecommerce/widgets/text_field.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

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
              Container(
                padding: EdgeInsets.symmetric(vertical: 65),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(155, 232, 229, 229),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.image,
                        size: 50,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Upload Image'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                lable: 'name',
                lines: 1,
              ),
              MyTextField(
                lable: 'category',
                lines: 1,
              ),
              MyTextField(
                lable: 'price',
                lines: 1,
                suff_icon: Icon(
                  Icons.attach_money,
                  color: Colors.black,
                ),
              ),
              MyTextField(
                lable: 'description',
                lines: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        'ADD',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10, bottom: 40),
                      child: Text(
                        'DELETE',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
