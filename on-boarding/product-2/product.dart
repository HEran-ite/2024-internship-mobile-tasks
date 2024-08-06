import 'dart:io';

class Product {
  String name;
  String description;
  int price;

  Product get getProduct {
    return this;
  }

  setProduct(Product product) {
    this.name = product.name;
    this.description = product.description;
    this.price = product.price;
  }

  Product(this.name, this.description, this.price);

  @override
  String toString() {
    return 'Name: $name, Description: $description, Price: $price';
  }
}

class Products {
  List<Product> products = [
    Product('dress', 'summer dress', 100),
    Product('bag', 'gucci bag', 200),
    Product('shoe', 'sandals', 300),
  ];
}

class ProductManager {
  final Products productLists;
  ProductManager(this.productLists);

  void addProduct(Product product) {
    productLists.products.add(product);
    print('Product added: ${product}');
  }

  void deleteProduct(String name) {
    bool isDeleted = false;

    for (int i = 0; i < productLists.products.length; i++) {
      if (name == productLists.products[i].name) {
        productLists.products.remove(productLists.products[i]);
        print('Product deleted: ${productLists.products[i].name}');
        isDeleted = true;
      }
      if (!isDeleted) {
        print('Product not found');
      }
    }
  }

  void updateProduct(Product product) {
    for (var i = 0; i < productLists.products.length; i++) {
      if (productLists.products[i].name == product.name) {
        Product(
                productLists.products[i].name,
                productLists.products[i].description,
                productLists.products[i].price)
            .setProduct(product);
        print('Product updated: ${product}');
      }
    }
  }

  void viewAllProducts() {
    for (var product in productLists.products) {
      print(product.getProduct);
    }
  }

  void viewOneProduct(String name) {
    for (var product in productLists.products) {
      if (product.name == name) {
        print(product.getProduct);
        return;
      }
    }
    print('Product not found');
  }
}

void main() {
  var products = Products();

  var productManager = ProductManager(products);

  while (true) {
    print('''Hello Product Manager 
                  Enter :
                  1  to add product
                  2  to delete 
                  3  to update
                  4  to view one product
                  5  to view all products 
                  6  to exit''');
    print('Enter number:');
    var service = stdin.readLineSync();
    if (service == "1") {
      print('Enter product name to add:\n');
      var name = stdin.readLineSync()?.toLowerCase();

      print('Enter product description to add:\n');
      var description = stdin.readLineSync()?.toLowerCase();

      print('Enter product price to add:\n');
      var price = int.tryParse(stdin.readLineSync()!);

      if (name != null && description != null && price != null) {
        productManager.addProduct(Product(name, description, price));
      } else {
        print('Invalid input');
      }
    } else if (service == "2") {
      print('Enter product name to delete:\n');
      var name = stdin.readLineSync()?.toLowerCase();

      if (name != null) {
        productManager.deleteProduct(name);
      } else {
        print('Invalid input');
      }
    } else if (service == "3") {
      print('Enter product name to be updated:\n');
      var name = stdin.readLineSync()?.toLowerCase();

      print('Enter product description to be updated:\n');
      var description = stdin.readLineSync()?.toLowerCase();

      print('Enter product price to be updated:\n');
      var price = int.tryParse(stdin.readLineSync()!);

      if (name != null && description != null && price != null) {
        productManager.updateProduct(Product(name, description, price));
      } else {
        print('Invalid input');
      }
    } else if (service == '4') {
      print('Enter product name to view:\n');
      var name = stdin.readLineSync()?.toLowerCase();

      if (name != null) {
        productManager.viewOneProduct(name);
      } else {
        print('Invalid input');
      }
    } else if (service == '5') {
      print('List of Products:\n');
      productManager.viewAllProducts();
    } else if (service == '6') {
      break;
    } else {
      print('Invalid option. Please try again.');
    }
  }
}
