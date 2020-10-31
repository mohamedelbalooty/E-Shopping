import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raia_rgon/models/product.dart';
import 'package:raia_rgon/provider/cart_item.dart';
import 'package:raia_rgon/provider/favourite_product.dart';
import '../../consestsnt.dart';

class FavouriteScreen extends StatelessWidget {
  static String id = 'FavouriteScreen';

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    List<Product> favouriteProducts =
        Provider.of<FavouriteProduct>(context).favouriteProducts;
    return Scaffold(
      backgroundColor: KbodyColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: KmainColor,
        elevation: 10.0,
        iconTheme: IconThemeData(
          color: KwhiteColor,
        ),
        title: Text(
          'My Favourite Cart',
          style: TextStyle(
            color: KwhiteColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LayoutBuilder(builder: (context, constrains) {
                if (favouriteProducts.isNotEmpty) {
                  return Container(
                    height: height -
                        statusBarHeight -
                        appBarHeight -
                        (height * .08),
                    child: ListView.builder(
                      itemCount: favouriteProducts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: height > 360.0
                                  ? height * 0.04
                                  : height * 0.09,
                              bottom: height > 360.0
                                  ? height * 0.03
                                  : height * 0.08,
                              left:
                                  height > 360.0 ? width * 0.15 : width * 0.09,
                              right: height > 360.0
                                  ? width - (width * 0.8 + width * 0.15)
                                  : (width - (width * 0.8 + width * 0.15)) *
                                      0.5),
                          child: Container(
                            height:
                                height > 360.0 ? height * 0.45 : height * 0.6,
                            width: height > 360.0 ? width * 0.8 : width * 1,
                            decoration: BoxDecoration(
                              color: KbodyColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Card(
                              color: KbodyColor,
                              elevation: 7.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: height > 360.0
                                        ? height * 0.3
                                        : height * 0.6,
                                    width: height > 360.0
                                        ? width * 0.8
                                        : width * 1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                          favouriteProducts[index]
                                              .pImageLocation,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: height > 360.0
                                        ? height * 0.05
                                        : height * 0.15,
                                    width: height > 360.0
                                        ? width * 0.8
                                        : width * 1,
                                    decoration: BoxDecoration(
                                      color: KbodyColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            favouriteProducts[index].pName,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            '\$${favouriteProducts[index].pPrice},00',
                                            style: customTextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width: height > 360.0
                                        ? width * 0.8
                                        : width * 1,
                                    decoration: BoxDecoration(
                                      color: KbodyColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        customContainer(
                                          KmainColor,
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: KwhiteColor,
                                              size: 30.0,
                                            ),
                                            onPressed: () {
                                              Provider.of<CartItem>(context,
                                                      listen: false)
                                                  .removeFromCartList(index);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                      height: height -
                          (height * 0.08) -
                          appBarHeight -
                          statusBarHeight,
                      child: Image(
                        image: AssetImage('images/icons/emptycart.png'),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle customTextStyle() {
    return TextStyle(
      fontSize: 15.0,
      color: Colors.grey,
      fontWeight: FontWeight.bold,
    );
  }

  Widget customContainer(Color color, Widget child) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: child,
      ),
    );
  }
}
