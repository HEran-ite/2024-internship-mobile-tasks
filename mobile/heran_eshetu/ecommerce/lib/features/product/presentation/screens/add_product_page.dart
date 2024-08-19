import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../injection_container.dart';
import '../../domain/entitity/product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../widgets/app_bar.dart';
import '../widgets/text_field.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? file;
  Future<void> pickImage() async {
    var status = await Permission.photos.status;

    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          file = image.path;
        });
      }
    } else if (status.isPermanentlyDenied) {
      // Handle the case where permission is permanently denied and user can't grant it anymore.
      openAppSettings();
    } else {
      print('Permission denied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Add Product',
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final Map arguments =
        (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final Product? product = arguments['product'];

    TextEditingController nameController =
        TextEditingController(text: product?.name ?? '');
    TextEditingController priceController =
        TextEditingController(text: product?.price.toString() ?? '');
    TextEditingController descriptionController =
        TextEditingController(text: product?.description ?? '');
    String? file = product?.imageUrl;

    return BlocProvider(
      create: (_) => sl<ProductBloc>(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                await pickImage();
              },
              child: file != null
                  ? AspectRatio(
                      aspectRatio: 16 / 7,
                      child: file!.startsWith('http')
                          ? Image.network(
                              file!,
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              File(file!),
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
              lable: 'Name',
              lines: 1,
            ),
            MyTextField(
              controller: nameController,
              lable: 'Category',
              lines: 1,
            ),
            MyTextField(
              controller: priceController,
              lable: 'Price',
              lines: 1,
              suffIcon: const Icon(
                Icons.attach_money,
                color: Colors.black,
              ),
            ),
            MyTextField(
              controller: descriptionController,
              lable: 'Description',
              lines: 5,
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final newProduct = Product(
                      id: product?.id ?? '',
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      description: descriptionController.text,
                      imageUrl: file ?? '',
                    );

                    if (product == null) {
                      BlocProvider.of<ProductBloc>(context)
                          .add(InsertProductEvent(product: newProduct));
                      Navigator.pushNamed(context, '/homepage');
                    } else {
                      BlocProvider.of<ProductBloc>(context)
                          .add(UpdateProductEvent(product: newProduct));
                      Navigator.pushNamed(context, '/homepage');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 32, 77, 202),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: const Text(
                      'ADD',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.red,
                    ),
                    side: WidgetStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.red, width: 1),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
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
      ),
    );
  }
}
