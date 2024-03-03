import 'package:alnsher/core/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImgView extends StatefulWidget {
  final url;
  final Widget? child;
  final BoxFit? boxFit;
  final double? parentHeight;
  final double? parentWidth;
  final BoxBorder? parentBorder;
  final BorderRadius? parentRadius;
  const ImgView({super.key , required this.url, this.parentRadius , this.child , this.boxFit , this.parentHeight , this.parentWidth , this.parentBorder});


  @override
  State<ImgView> createState() => _ImgViewState();
}

class _ImgViewState extends State<ImgView> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      imageBuilder: (context, imageProvider) => Container(
        height: widget.parentHeight,
        width: widget.parentWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: widget.boxFit,
             ),

          border: widget.parentBorder,
          borderRadius: widget.parentRadius

        ),

        child: widget.child,
      ),
      placeholder: (context, url) => LinearProgressIndicator(
        color: AppColors.primaryColor.withOpacity(0.2),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
