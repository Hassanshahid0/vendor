import 'package:flutter/material.dart';
import 'package:vendor_app/widgets/product_detail_mobile_view_widget.dart';

class ProductDetailPage extends StatefulWidget {
  final String productUID;
  const ProductDetailPage({super.key, required this.productUID});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductDetailMobileViewWidget(productID: widget.productUID),
    );
  }
}
