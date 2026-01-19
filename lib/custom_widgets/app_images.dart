import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class CustomPngImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomPngImage({
    super.key,
    this.imageName,
    this.height,
    this.width,
    this.boxFit,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.png',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomJpgImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomJpgImage({
    super.key,
    this.imageName,
    this.height,
    this.width,
    this.boxFit,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.jpg',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomJpegImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomJpegImage({
    super.key,
    this.imageName,
    this.height,
    this.width,
    this.boxFit,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.jpeg',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomImageNetwork extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomImageNetwork({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.boxFit,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl ?? '',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

// ignore: must_be_immutable
class CustomSvgImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? boxFit;
  bool transform;
  CustomSvgImage({
    super.key,
    this.imageName,
    this.height,
    this.width,
    this.color,
    this.boxFit,
    this.transform = true,
  });
  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: (Directionality.of(context) == TextDirection.ltr)
          ? Matrix4.rotationY(0)
          : Matrix4.rotationY(0),
      // : Matrix4.rotationY(transform ? math.pi : 0),
      child: SvgPicture.asset(
        'assets/svg/$imageName.svg',
        height: height ?? 30,
        width: width ?? 30,
        fit: boxFit ?? BoxFit.contain,
        // ignore: deprecated_member_use
        color: color,
      ),
    );
  }
}
