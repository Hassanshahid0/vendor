import 'package:flutter/material.dart';
import 'package:vendor_app/widgets/delivery_address_widget.dart';


class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({super.key});

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {


  @override
  void initState() {
   // getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DeliveryAddressWidget();
  }
}
