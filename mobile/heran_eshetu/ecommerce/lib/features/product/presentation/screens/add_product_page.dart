import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entitity/product.dart';
import '../widgets/app_bar.dart';
import '../widgets/text_field.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments =
        (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final Product? product = arguments['product'];

    TextEditingController nameController =
        TextEditingController(text: product?.name ?? '');
    TextEditingController categoryController =
        TextEditingController(text: product?.category ?? '');
    TextEditingController priceController =
        TextEditingController(text: product?.price.toString() ?? '');
    TextEditingController descriptionController =
        TextEditingController(text: product?.description ?? '');
    String? file = product?.imageUrl;

    return Scaffold(
        appBar: const MyAppBar(
          title: 'Add Product',
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  // ignore: no_leading_underscores_for_local_identifiers
                  final ImagePicker _picker = ImagePicker();
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    file = image.path;
                  }
                },
                child: product?.imageUrl != null
                    ? AspectRatio(
                        aspectRatio: 16 / 7,
                        child: Image.asset(
                          file ?? '',
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 65),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(155, 232, 229, 229),
                        ),
                        child: const Center(
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
              const SizedBox(
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
                suffIcon: const Icon(
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
                        color: const Color.fromARGB(255, 32, 77, 202),
                      ),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 40, bottom: 10),
                      child: const Text(
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
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10, bottom: 40),
                      child: const Text(
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
