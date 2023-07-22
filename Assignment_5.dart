import 'dart:io';

List<Map<String, dynamic>> Product_Detail = [];

var product_id = 0,
    product_name,
    product_quantity,
    product_sellprice,
    product_purchaseprice;

List<Map<String, dynamic>> SelectedProducts = [];

var Selected_product_id = 0,
    Selected_product_name,
    Selected_product_quantity,
    Selected_product_price;

dynamic Total_Sale = 0;
dynamic EachCustomer_Bill = 0;

void main() {
  print("\n\t\t\tWelcome Our Store Management System Application");
  Login();
}

Login() {
  int login_choice;
  print("\n\tPress 1 for Admin login");
  print("\tPress 2 for Point Of Sale (Customer Side) -Only Cash Customer");
  print("\tPress any for exit");
  print("");
  stdout.write("\tEnter Your Choice: ");
  login_choice = int.parse(stdin.readLineSync()!);
  var admin_choice;
  if (login_choice == 1) {
    var valid_username = "admin", valid_password = "admin123";
    var username, password;
    stdout.write("\n\tEnter UserName: ");
    username = stdin.readLineSync();
    stdout.write("\tEnter Password: ");
    password = stdin.readLineSync();
    while (username != valid_username || password != valid_password) {
      print("\n\tPlease Enter a correct Username or Password");
      stdout.write("\n\tEnter UserName: ");
      username = stdin.readLineSync();
      stdout.write("\tEnter Password: ");
      password = stdin.readLineSync();
    }
    var admin = true;
    while (admin) {
      print("\n\tPress 1 for Adding a Product");
      print("\tPress 2 to View all Product and Total Saless");
      print("\tPress 3 to Update a Product");
      print("\tPress 4 to Delete a Product");
      print("\tPress 5 for logout");
      print("\tPress any key for exit");
      print("");
      stdout.write("\tEnter Your Choice: ");
      admin_choice = int.parse(stdin.readLineSync()!);
      if (admin_choice == 1) {
        AddProduct_Admin();
      } else if (admin_choice == 2) {
        ViewProduct_Admin();
      } else if (admin_choice == 3) {
        UpdateProduct_Admin();
      } else if (admin_choice == 4) {
        RemoveProduct_Admin();
      } else if (admin_choice == 5) {
        admin = false;
      } else {
        exit(0);
      }
    }
    Login();
  } else if (login_choice == 2) {
    EachCustomer_Bill = 0;
    SelectedProducts.clear();
    var user_choice;
    var customer = true;
    while (customer) {
      print("\n\tPress 1 for Product View to Select");
      print("\tPrint 2 for logout");
      print("\tPress any key for exit");
      stdout.write("\n\tEnter Your Chice: ");
      user_choice = int.parse(stdin.readLineSync()!);
      if (user_choice == 1) {
        SelectProduct_User();
      } else if (user_choice == 2) {
        customer = false;
      } else {
        exit(0);
      }
    }
    Login();
  } else {
    exit(0);
  }
}

AddProduct_Admin() {
  product_id++;
  stdout.write("\n\tEnter Product Name: ");
  product_name = stdin.readLineSync();
  stdout.write("\tEnter Product Quantity: ");
  product_quantity = int.parse(stdin.readLineSync()!);
  stdout.write("\tEnter Product Sell Price: ");
  product_sellprice = int.parse(stdin.readLineSync()!);
  stdout.write("\tEnter Product Purchase Price: ");
  product_purchaseprice = int.parse(stdin.readLineSync()!);

  Product_Detail.add({
    'pid': product_id,
    'pname': product_name,
    'pquantity': product_quantity,
    'ppurchaseprice': product_purchaseprice,
    'psellprice': product_sellprice
  });
  print("\n\tProduct Added Successfully\n");
}

ViewProduct_Admin() {
  print(
      "\n\tProduct_ID\tProduct_Name\tProduct_Quantity\tProduct_Sell_Price\tProduct_Purchase_Price");
  for (var i = 0; i < Product_Detail.length; i++) {
    print("\t${Product_Detail[i]['pid']}\t\t${Product_Detail[i]['pname']}\t${Product_Detail[i]['pquantity']}\t\t\t${Product_Detail[i]['psellprice']}\t\t\t${Product_Detail[i]['ppurchaseprice']}");
  }
  print("\n\t\t\t\t\tTotal Sales: $Total_Sale");
}

UpdateProduct_Admin() {
  var product_id_update,
      product_name_update,
      product_quantity_update,
      product_sellprice_update,
      product_purchaseprice_update;
  stdout.write("\n\tEnter Product ID: ");
  product_id_update = int.parse(stdin.readLineSync()!);

  for (var i = 0; i < Product_Detail.length; i++) {
    if (Product_Detail[i]['pid'] == product_id_update) {
      stdout.write("\tEnter Product Name: ");
      product_name_update = stdin.readLineSync();
      stdout.write("\tEnter Product Quantity: ");
      product_quantity_update = int.parse(stdin.readLineSync()!);
      stdout.write("\tEnter Product Sell Price: ");
      product_sellprice_update = int.parse(stdin.readLineSync()!);
      stdout.write("\tEnter Product Purchase Price: ");
      product_purchaseprice_update = int.parse(stdin.readLineSync()!);
      Product_Detail[i]['pname'] = product_name_update;
      Product_Detail[i]['pquantity'] = product_quantity_update;
      Product_Detail[i]['ppurchaseprice'] = product_purchaseprice_update;
      Product_Detail[i]['psellprice'] = product_sellprice_update;
    } else {
      print("\n\tYou Entered Invalid Product ID. Please Enter A Valid Product ID");
      UpdateProduct_Admin();
    }
  }
}

RemoveProduct_Admin() {
  var product_id_remove;
  stdout.write("\n\tEnter Product ID: ");
  product_id_remove = int.parse(stdin.readLineSync()!);
  for (var i = 0; i < Product_Detail.length; i++) {
    if (Product_Detail[i]['pid'] == product_id_remove) {
      Product_Detail.removeAt(i);
      print("\n\tRemove Product Successfully!");
    } else {
      print("\n\tYou Entered Invalid Product ID. Please Enter A Valid Product ID");
      RemoveProduct_Admin();
    }
  }
}

ViewProduct_User() {
  print("\n\t\t\tAvaliable Products");
  print("\n\tProduct_ID\tProduct_Name\tProduct_Quantity\tProduct_Price");
  for (var i = 0; i < Product_Detail.length; i++) {
    print("\t${Product_Detail[i]['pid']}\t\t${Product_Detail[i]['pname']}\t${Product_Detail[i]['pquantity']}\t\t\t${Product_Detail[i]['psellprice']}");
  }
}

SelectProduct_User() {
  ViewProduct_User();
  var pname, pquantity, Total_quantity;
  var product_get = false;

  stdout.write("\n\tEnter Product Name: ");
  pname = stdin.readLineSync();
  stdout.write("\tEnter Product Quanity: ");
  pquantity = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < Product_Detail.length; i++) {
    if (Product_Detail[i]['pname'] == pname) {
      Selected_product_name = Product_Detail[i]['pname'];
      Selected_product_price = Product_Detail[i]['psellprice'];
      Total_quantity = Product_Detail[i]['pquantity'];
      if (pquantity <= Total_quantity) {
        product_get = true;
        Total_quantity -= pquantity;
        Selected_product_quantity = pquantity;
        Product_Detail[i]['pquantity'] = Total_quantity;
      }
    }
  }
  if (!product_get) {
    print("\n\tEnter Correct Product Name and Valid Product Quantity\n");
    SelectProduct_User();
  }

  Selected_product_id++;
  SelectedProducts.add({
    'pid': Selected_product_id,
    'pname': Selected_product_name,
    'pquantity': Selected_product_quantity,
    'unit_price': Selected_product_price,
  });
  EachCustomer_Bill += Selected_product_price * Selected_product_quantity;
  SelectMoreProduct_User();
}

SelectMoreProduct_User() {
  ViewSelectedProduct_User();
  var choice;
  print("\n\tPress 1 to Add More Product");
  print("\tPress 2 to proceed");
  print("\tPress any key to exit");
  stdout.write("\n\tEnter Your Choice: ");
  choice = stdin.readLineSync();
  if (choice == 1) {
    SelectProduct_User();
  } else if (choice == 2) {
    Show_Bill();
  } else {
    exit(0);
  }
}

ViewSelectedProduct_User() {
  print("\n\t\t\tSelected Products");
  print("\n\tProduct_ID\tProduct_Name\tProduct_Quantity\tProduct_Price");
  for (var i = 0; i < SelectedProducts.length; i++) {
    print("\t${SelectedProducts[i]['pid']}\t\t${SelectedProducts[i]['pname']}\t${SelectedProducts[i]['pquantity']}\t\t\t${SelectedProducts[i]['unit_price']}");
  }
}

Show_Bill() {
  var choice;
  print("\n\t\tYour Total Bill: $EachCustomer_Bill");
  Total_Sale += EachCustomer_Bill;
  print("\n\tPress 1 for Logout as Customer");
  print("\tPress any key for quit");
  stdout.write("\n\tEnter Your Choice: ");
  choice = int.parse(stdin.readLineSync()!);
  if (choice == 1) {
    Login();
  } else {
    exit(0);
  }
}