import 'package:flutter/material.dart';

import 'allcateforyresp.dart';
import 'sign_in_api.dart';

class MyInheritedWidget extends InheritedWidget {
final int counter;
  final AppStateWidgetState state;
  MyInheritedWidget({required super.child, required this.state,required this.counter});

static AppStateWidgetState? of(BuildContext context) =>
context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()?.state;

@override
bool updateShouldNotify(InheritedWidget oldWidget) => true;
}


class AppStateWidget extends StatefulWidget {
  final int counter;
  final Widget child;
  const AppStateWidget({Key? key, required this.child,required this.counter}) : super(key: key);

  @override
  AppStateWidgetState createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  var counter=5;
  // UserData? userData;
  SignUpUserData? userSignUpData;
  String? productTitle = "";
  List<AllCategoryData>? categories;
  // List<AllProductData>? products;
  // List<AllProductData>? productByCategory;
  List<bool>? addToCartOrNot;
  List<bool>? addLikeOrNot;
  List<int>? productCount;
  // List<AllProductData>? cartProducts;
  double subTotal = 0;

  // updateUserData(UserData userUpdateData) => setState((){
  //   userData = userUpdateData;
  // });
  updateUserSignUpData(SignUpUserData userUpdateData) => setState((){
    userSignUpData = userUpdateData;
  });
  updateCategory(List<AllCategoryData> category) => setState((){
    categories = category;
  });
  // updateProducts(List<AllProductData> product) => setState((){
  //   products = product;
  // });
  // updateProductByCategory(List<AllProductData> productCat) => setState((){
  //   productByCategory = productCat;
  // });
  updateProductTitle(String title) => setState((){
    productTitle = title;
  });
  updateAddCart(List<bool> addCartOption)=> setState((){
    addToCartOrNot = addCartOption;
  });
  updateLikeOrNot(List<bool> addLike)=> setState((){
    addLikeOrNot = addLike;
  });
  updateProductCount(List<int> productCountList)=> setState((){
    productCount = productCountList;
  });
  // updateCartProduct(List<AllProductData> cartProduct)=> setState((){
  //   cartProducts = cartProduct;
  // });
  updateSubTotal(double subAmount)=>setState((){
    subTotal += subAmount;
  });
  deleteCartItem(int index)=> setState((){
    addToCartOrNot![index] = true;
    productCount![index] = 1;
  });

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(child: widget.child, state: this, counter: widget.counter,);
  }
}