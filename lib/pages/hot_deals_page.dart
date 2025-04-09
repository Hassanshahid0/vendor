import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendor_app/model/products_model.dart';
import 'package:vendor_app/widgets/add_deals.dart';

import '../constant.dart';
//import 'package:vendor_app/widgets/footer_widget.dart';

class HotSalesPage extends StatefulWidget {
  const HotSalesPage({super.key});

  @override
  State<HotSalesPage> createState() => _HotSalesPageState();
}

class _HotSalesPageState extends State<HotSalesPage> {
  List<ProductsModel> products = [];
  List<ProductsModel> productsFilter = [];
  bool isLoaded = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  final bool _sortAscending = true;

  getProducts() async {
    setState(() {
      isLoaded = true;
    });
    context.loaderOverlay.show();
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('Hot Deals')
        .where('vendorId', isEqualTo: user!.uid)
        // .limit(10)
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      if (mounted) {
        context.loaderOverlay.hide();
      }
      products.clear();
      for (var element in event.docs) {
        var prods = ProductsModel.fromMap(element, element.id);
        setState(() {
          products.add(prods);
        });
      }
    });
  }

  @override
  void initState() {
    getProducts();
    getCurrencySymbol();
    getStatus();
    super.initState();
  }

  bool approval = false;

  getStatus() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('vendors')
        .doc(user!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        approval = event['approval'];
      });
    });
  }

  Future<void> deleteAllDocumentsInCollection(String collectionPath) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionPath);

    QuerySnapshot querySnapshot = await collectionReference.get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await collectionReference.doc(documentSnapshot.id).delete();
    }
  }

  String displayName = '';
  String currencySymbol = '';
  getCurrencySymbol() {
    FirebaseFirestore.instance
        .collection('Currency Settings')
        .doc('Currency Settings')
        .get()
        .then((value) {
      setState(() {
        currencySymbol = value['Currency symbol'];
      });
    });
  }

  void onSearchTextChanged(String text) {
    setState(() {
      displayName = text;
      productsFilter = products
          .where((user) => user.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var vendorData = VendorDataSource(
        displayName == '' ? products : productsFilter, context, currencySymbol);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,
        onPressed: () {
          if (approval == false) {
            Fluttertoast.showToast(
                msg: "Account is under review".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 14.0);
          } else {
            showDialog(
                context: context,
                builder: (builder) {
                  return const Material(
                    child: AddDeals(),
                  );
                });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoaded == true
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue))
              : ListView(
                  shrinkWrap: true,
                  children: [
                    PaginatedDataTable(
                      columnSpacing: 30,
                      showFirstLastButtons: true,
                      header: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: TextField(
                              onChanged: onSearchTextChanged,
                              style: const TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                focusColor: Colors.grey,
                                hintText: 'Search for Products'.tr(),
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 25,
                                  color: Colors.blue.shade800,
                                ),
                                filled: true,
                                fillColor: Colors.white10,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                              )),
                        ),
                      ),
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (int? value) {
                        setState(() {
                          _rowsPerPage = value!;
                        });
                      },
                      source: vendorData,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: <DataColumn>[
                        DataColumn(
                          label: const Text(
                            'Index',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Product Picture',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Category',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Collection',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Sub Collection',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Brand',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'View Detail',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        const DataColumn(
                          label: Text(
                            'Manage',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
    );
  }
}

int numberOfdelivery = 0;

List<int> deliveryBoyAmount = [];

class VendorDataSource extends DataTableSource {
  final List<ProductsModel> vendor;
  final String currencySymbol;
  final BuildContext context;
  VendorDataSource(this.vendor, this.context, this.currencySymbol);

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= vendor.length) return null;
    final ProductsModel result = vendor[index];
    return DataRow.byIndex(
        index: index,
        //  selected: result.selected,
        cells: <DataCell>[
          DataCell(Text('${index + 1}')),
          DataCell(result.image1 == ''
              ? Container()
              : Image.network(result.image1, width: 50, height: 50)),
          DataCell(SizedBox(
            width: 100,
            child: Text(
              result.name,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          DataCell(Text(
            result.category,
          )),
          DataCell(Text(
            result.collection,
          )),
          DataCell(Text(
            result.subCollection,
          )),
          DataCell(Text(
            result.brand,
          )),
          DataCell(TextButton(
              // style: ButtonStyle(
              //   elevation: WidgetStateProperty.all(0),
              //   backgroundColor: WidgetStateProperty.all<Color>(
              //     Colors.blue.shade800,
              //   ),
              // ),
              onPressed: () {
                context.push('/product-detail/${result.uid}');
              },
              child: const Text('View Detail').tr())),
          DataCell(Row(
            children: [
              TextButton(
                  // style: ButtonStyle(
                  //   elevation: WidgetStateProperty.all(0),
                  //   backgroundColor: WidgetStateProperty.all<Color>(
                  //     Colors.blue.shade800,
                  //   ),
                  // ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            title: Text(result.name),
                            content: const Text(
                                    'Are you sure you want to delete this product?')
                                .tr(),
                            actions: [
                              InkWell(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('Hot Deals')
                                        .doc(result.uid)
                                        .delete()
                                        .then((value) {
                                      if (context.mounted) {
                                        context.pop();
                                        Flushbar(
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          title: "Notification".tr(),
                                          message:
                                              "Deleted successfully!!!".tr(),
                                          duration: const Duration(seconds: 3),
                                        ).show(context);
                                      }
                                    });
                                  },
                                  child: const Text('Yes').tr()),
                              const SizedBox(width: 50),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No').tr())
                            ],
                          );
                        });
                  },
                  child: const Text('Delete').tr())
            ],
          )),
        ]);
  }

  @override
  int get rowCount => vendor.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
