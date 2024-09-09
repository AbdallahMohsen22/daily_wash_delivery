import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ImageNet extends StatelessWidget {
  ImageNet({
    required this.image,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
});

  String image;
  double height;
  double width;
  BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: image,
        // httpHeaders: {
        //   'Accept': 'image/*'
        // },
        height: height,width: width,
        fit: fit,
        errorWidget: (context, url, error) => Image.asset(Images.holder,fit:fit,width: width,height: height,),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(Images.holder,fit:fit,width: width,height: height,),
                  CupertinoActivityIndicator()
                ],
              ),
            )
    );
  }
}
