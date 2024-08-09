import 'dart:io';
import 'package:ecommerce/entitity/product.dart';
import 'package:ecommerce/widgets/app_bar.dart';
import 'package:ecommerce/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments =
        (ModalRoute.of(context)?.settings?.arguments as Map?) ?? {};
    final Product? product = arguments['product'];
    final List<Product>? products = arguments['products'];

    TextEditingController nameController =
        TextEditingController(text: product?.name ?? '');
    TextEditingController categoryController =
        TextEditingController(text: product?.category ?? '');
    TextEditingController priceController =
        TextEditingController(text: product?.price.toString() ?? '');
    TextEditingController descriptionController =
        TextEditingController(text: product?.description ?? '');

    if (product != null) {
      File image = File(product.imageUrl);
    }

    return Scaffold(
        appBar: MyAppBar(
          title: 'Add Product',
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    File file = File(image.path);
                  }
                },
                child: product?.imageUrl != null
                    ? AspectRatio(
                        aspectRatio: 16 / 7,
                        child: Image.asset(
                          product?.imageUrl ?? '',
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(
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
              ),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: nameController,
                lable: 'name',
                lines: 1,
              ),
              MyTextField(
                controller: categoryController,
                lable: 'category',
                lines: 1,
              ),
              MyTextField(
                controller: priceController,
                lable: 'price',
                lines: 1,
                suff_icon: Icon(
                  Icons.attach_money,
                  color: Colors.black,
                ),
              ),
              MyTextField(
                controller: descriptionController,
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
                    onTap: () {
                      Navigator.pop(context);
                    },
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
