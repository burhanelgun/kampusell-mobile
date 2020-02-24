import 'package:flutter/cupertino.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';

class ProductItem extends StatelessWidget{

  Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        new Container(
            width: 50.0,
            height: 50.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage(
                        product.photoPaths[0])
                )
            )
        ),
        Column(
          children: <Widget>[
            new Text(product.name,
                textScaleFactor: 1.0),
            new Text(product.category.name,
                textScaleFactor: 1.0),
            new Text(product.price.toString(),
                textScaleFactor: 1.0),
            new Text(product.description,
                textScaleFactor: 1.0),

          ],
        )


      ],
    );
  }

}