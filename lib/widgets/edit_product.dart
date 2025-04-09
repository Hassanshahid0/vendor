// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print
import 'dart:convert';
import 'dart:io';
// import 'package:vendor_app/Pages/products.dart';
import 'package:vendor_app/constant.dart';
import 'package:vendor_app/providers/product_form_provider.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../model/products_model.dart';
import 'package:vendor_app/providers/products_datatable_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProduct extends ConsumerStatefulWidget {
  final ProductsModel productsModel;
  const EditProduct({
    super.key,
    required this.productsModel,
  });

  @override
  ConsumerState<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends ConsumerState<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  final QuillController _controller = QuillController.basic();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller.document =
        Document.fromJson(jsonDecode(widget.productsModel.description));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getCategoriesProvider);
    final collectionsProvider =
        ref.watch(productFormProviderProvider).category.isEmpty
            ? ref.watch(getCollectionsProvider(widget.productsModel.category))
            : ref.watch(getCollectionsProvider(
                ref.watch(productFormProviderProvider).category));
    final brandsProvider = ref.watch(getBrandsProvider);
    final subCollectionsProvider =
        ref.watch(productFormProviderProvider).category.isEmpty &&
                ref.watch(productFormProviderProvider).collection.isEmpty
            ? ref.watch(getSubCollectionsProvider(
                widget.productsModel.category, widget.productsModel.collection))
            : ref.watch(getSubCollectionsProvider(
                ref.watch(productFormProviderProvider).category,
                ref.watch(productFormProviderProvider).collection));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).size.width >= 1100
              ? const EdgeInsets.only(left: 100, right: 100)
              : const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(Icons.clear))
                ]),
                const SizedBox(height: 20),
                const Text('Edit Product',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    .tr(),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Product Name:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.productsModel.name,
                  onSaved: (value) {
                    ref
                        .watch(productFormProviderProvider.notifier)
                        .updateProduct(name: value!);
                  },
                  onChanged: (value) {
                    ref
                        .watch(productFormProviderProvider.notifier)
                        .updateProduct(name: value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Product name'.tr(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Product Description:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                QuillSimpleToolbar(
                  configurations: QuillSimpleToolbarConfigurations(
                    controller: _controller,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          controller: _controller,
                        ),
                      ),
                    ),
                  ),
                ),
                // TextFormField(
                //   maxLines: 5,
                //   onSaved: (value) {
                //     ref
                //         .watch(productFormProviderProvider.notifier)
                //         .updateProduct(description: value!);
                //   },
                //   onChanged: (value) {
                //     ref
                //         .watch(productFormProviderProvider.notifier)
                //         .updateProduct(description: value);
                //   },
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Required field'.tr();
                //     } else {
                //       return null;
                //     }
                //   },
                //   decoration: InputDecoration(
                //     hintText: 'Product Description'.tr(),
                //     focusColor: Colors.grey,
                //     filled: true,
                //     fillColor: Colors.white10,
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide:
                //           const BorderSide(color: Colors.grey, width: 1.0),
                //     ),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //       borderSide:
                //           const BorderSide(color: Colors.grey, width: 1.0),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //       borderSide:
                //           const BorderSide(color: Colors.grey, width: 1.0),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Return Duration In Days:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                TextFormField(
                  // maxLines: 5,
                  initialValue: widget.productsModel.returnDuration.toString(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,

                  onSaved: (value) {
                    ref
                        .watch(productFormProviderProvider.notifier)
                        .updateProduct(returnDuration: int.parse(value!));
                  },
                  onChanged: (value) {
                    ref
                        .watch(productFormProviderProvider.notifier)
                        .updateProduct(returnDuration: int.parse(value));
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Return Duration'.tr(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Product Category:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                categories.when(data: (v) {
                  return DropdownSearch<String>(
                    selectedItem: widget.productsModel.category,
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    items: (f, cs) => v,
                    // validator: (v) => v == null ? "Required field".tr() : null,
                    decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                      hintText: 'Select A Product Category'.tr(),
                      fillColor: Colors.white10,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    )),
                    onChanged: (value) {
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(category: value!);
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(collection: '');
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(brand: '');
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(subCollection: '');
                    },
                  );
                }, error: (ee, eee) {
                  return Text(eee.toString());
                }, loading: () {
                  return const CircularProgressIndicator();
                }),
                const SizedBox(height: 20),

                Row(children: [
                  const Text('Product Collection:').tr(),
                ]),
                const SizedBox(height: 10),

                collectionsProvider.when(data: (v) {
                  return DropdownSearch<String>(
                    selectedItem: widget.productsModel.collection,
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    items: (f, cs) => v,
                    // validator: (v) => v == null ? "Required field".tr() : null,
                    decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                      hintText: 'Select A Product Collection'.tr(),
                      fillColor: Colors.white10,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    )),
                    onChanged: (value) {
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(collection: value);
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(subCollection: '');

                      // getSubCollections(productsProviders.category, collection);
                    },
                  );
                }, error: (ss, dd) {
                  return Text(dd.toString());
                }, loading: () {
                  return const Text('Fetching data...');
                }),
                const SizedBox(height: 20),

                Row(children: [
                  const Text('Product Sub Collection:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),

                subCollectionsProvider.when(data: (v) {
                  return DropdownSearch<String>(
                    selectedItem: widget.productsModel.subCollection,
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    items: (f, cs) => v,
                    // validator: (v) => v == null ? "Required field".tr() : null,
                    decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                      hintText: 'Select A Product Sub Collection'.tr(),
                      fillColor: Colors.white10,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    )),
                    onChanged: (value) {
                      // getSubCollections(productsProviders.category, collection);

                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(subCollection: value);
                    },
                  );
                }, error: (v, s) {
                  return Text('$s');
                }, loading: () {
                  return const Text('Fetching data...');
                }),
                const SizedBox(height: 20),

                Row(children: [
                  const Text('Product Brand:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),

                brandsProvider.when(data: (v) {
                  return DropdownSearch<String>(
                    selectedItem: widget.productsModel.brand,
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    items: (f, cs) => v,
                    validator: (v) => v == null ? "Required field".tr() : null,
                    decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                      hintText: 'Select A Product Brand'.tr(),
                      fillColor: Colors.white10,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    )),
                    onChanged: (value) {
                      // getSubCollections(productsProviders.category, collection);

                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(brand: value!);
                    },
                  );
                }, error: (s, d) {
                  return Text('$d');
                }, loading: () {
                  return const Text('Fetching data...');
                }),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Product Price:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.productsModel.unitPrice1.toString(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    ref
                        .watch(productFormProviderProvider.notifier)
                        .updateProduct(unitPrice1: int.parse(value!));
                  },
                  onChanged: (value) {
                    ref
                        .watch(productFormProviderProvider.notifier)
                        .updateProduct(unitPrice1: int.parse(value));
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Product Price'.tr(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Product Initial Price:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    initialValue: widget.productsModel.unitOldPrice1.toString(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(unitOldPrice1: int.parse(value!));
                    },
                    onChanged: (value) {
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(unitOldPrice1: int.parse(value));
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required field'.tr();
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Product Initial Price'.tr(),
                      focusColor: Colors.grey,
                      filled: true,
                      fillColor: Colors.white10,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Quantity:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.productsModel.quantity.toString(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    ref
                        .watch(productFormProviderProvider.notifier)
                        .updateProduct(quantity: int.parse(value!));
                  },
                  onChanged: (value) {
                    ref
                        .watch(productFormProviderProvider.notifier)
                        .updateProduct(quantity: int.parse(value));
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Quantity'.tr(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Product Discount (%):',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    initialValue:
                        widget.productsModel.percantageDiscount.toString(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(percantageDiscount: int.parse(value!));
                    },
                    onChanged: (value) {
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(percantageDiscount: int.parse(value));
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required field'.tr();
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Product Discount'.tr(),
                      focusColor: Colors.grey,
                      filled: true,
                      fillColor: Colors.white10,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  const Text('Product Unit:',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr(),
                ]),
                const SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    initialValue: widget.productsModel.unitname1,
                    onSaved: (value) {
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(unitname1: value!);
                    },
                    onChanged: (value) {
                      ref
                          .watch(productFormProviderProvider.notifier)
                          .updateProduct(unitname1: value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required field'.tr();
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Kg/mil/gram/pkts',
                      focusColor: Colors.grey,
                      filled: true,
                      fillColor: Colors.white10,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(children: [
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Add on',
                            style: TextStyle(fontWeight: FontWeight.bold))
                        .tr()
                  ]),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(flex: 1, child: const Text('Unit').tr()),
                          Flexible(
                              flex: 1, child: const Text('Initial Price').tr()),
                          Flexible(flex: 1, child: const Text('Price').tr())
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue: widget.productsModel.unitname2,
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(unitname2: value);
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitPrice2.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitOldPrice2: int.parse(value));
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitPrice2.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitPrice2: int.parse(value));
                                },
                              ))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue: widget.productsModel.unitname3,
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(unitname3: value);
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue: widget.productsModel.unitOldPrice3
                                    .toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitOldPrice3: int.parse(value));
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitPrice3.toString(),
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitPrice3: int.parse(value));
                                },
                              ))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue: widget.productsModel.unitname4,
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(unitname4: value);
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue: widget.productsModel.unitOldPrice4
                                    .toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitOldPrice4: int.parse(value));
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitPrice4.toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitPrice4: int.parse(value));
                                },
                                keyboardType: TextInputType.number,
                              ))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitname5.toString(),
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(unitname5: value);
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue: widget.productsModel.unitOldPrice5
                                    .toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitOldPrice5: int.parse(value));
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitPrice5.toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitPrice5: int.parse(value));
                                },
                              ))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue: widget.productsModel.unitname6,
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(unitname6: value);
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitPrice6.toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitOldPrice6: int.parse(value));
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitPrice6.toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitPrice6: int.parse(value));
                                },
                              ))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue: widget.productsModel.unitname7,
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(unitname7: value);
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                initialValue: widget.productsModel.unitOldPrice7
                                    .toString(),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitOldPrice7: int.parse(value));
                                },
                              )),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: 1,
                              child: TextFormField(
                                initialValue:
                                    widget.productsModel.unitPrice7.toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref
                                      .watch(
                                          productFormProviderProvider.notifier)
                                      .updateProduct(
                                          unitPrice7: int.parse(value));
                                  //   });
                                },
                                keyboardType: TextInputType.number,
                              ))
                        ]),
                  ),
                  const SizedBox(height: 20),
                ]),
                const SizedBox(height: 20),
                ref.watch(productFormProviderProvider).imageFile1 == null
                    ? Image.network(widget.productsModel.image1,
                        width: 120, height: 120)
                    : Image.file(
                        File(
                            ref.watch(productFormProviderProvider).imageFile1!),
                        width: 120,
                        height: 120),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              appColor,
                            ),
                          ),
                          onPressed: () {
                            ref
                                .read(productFormProviderProvider.notifier)
                                .uploadImage1(context);
                          },
                          child: const Text('Add Image 1',
                                  style: TextStyle(color: Colors.white))
                              .tr()),
                    ],
                  ),
                ),
                ref.watch(productFormProviderProvider).imageFile2 == null
                    ? Image.network(widget.productsModel.image2,
                        width: 120, height: 120)
                    : Image.file(
                        File(
                            ref.watch(productFormProviderProvider).imageFile2!),
                        width: 120,
                        height: 120),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              appColor,
                            ),
                          ),
                          onPressed: () {
                            ref
                                .read(productFormProviderProvider.notifier)
                                .uploadImage2(context);
                          },
                          child: const Text('Add Image 2',
                                  style: TextStyle(color: Colors.white))
                              .tr()),
                    ],
                  ),
                ),
                ref.watch(productFormProviderProvider).imageFile3 == null
                    ? Image.network(widget.productsModel.image3,
                        width: 120, height: 120)
                    : Image.file(
                        File(
                            ref.watch(productFormProviderProvider).imageFile3!),
                        width: 120,
                        height: 120),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              appColor,
                            ),
                          ),
                          onPressed: () {
                            ref
                                .read(productFormProviderProvider.notifier)
                                .uploadImage3(context);
                          },
                          child: const Text('Add Image 3',
                                  style: TextStyle(color: Colors.white))
                              .tr()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                ref.watch(productFormProviderProvider).isLoading == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(0),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                appColor,
                              ),
                            ),
                            onPressed: null,
                            child: const Text('Uploading please wait...',
                                    style: TextStyle(color: Colors.white))
                                .tr()),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(0),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  appColor,
                                ),
                              ),
                              onPressed: () {
                                // if (_formKey.currentState!.validate() &&
                                //     ref
                                //             .watch(productFormProviderProvider)
                                //             .subCollection !=
                                //         '' &&
                                //     ref
                                //             .watch(productFormProviderProvider)
                                //             .collection !=
                                //         '' &&
                                //     ref
                                //             .watch(productFormProviderProvider)
                                //             .category !=
                                //         "" &&
                                //     ref
                                //             .watch(productFormProviderProvider)
                                //             .image1 !=
                                //         '') {
                                ref
                                    .read(productFormProviderProvider.notifier)
                                    .editProduct(
                                        ProductsModel(
                                            vendorName:
                                                widget.productsModel.vendorName,
                                            timeCreated: DateTime.now(),
                                            returnDuration:
                                                ref.watch(productFormProviderProvider).returnDuration == 0
                                                    ? widget.productsModel
                                                        .returnDuration
                                                    : ref
                                                        .watch(
                                                            productFormProviderProvider)
                                                        .returnDuration,
                                            quantity: ref.watch(productFormProviderProvider).quantity == 0
                                                ? widget.productsModel.quantity
                                                : ref
                                                    .watch(
                                                        productFormProviderProvider)
                                                    .quantity,
                                            totalRating: widget
                                                .productsModel.totalRating,
                                            totalNumberOfUserRating: widget
                                                .productsModel
                                                .totalNumberOfUserRating,
                                            productID: widget.productsModel.uid,
                                            description: _controller.document
                                                    .isEmpty()
                                                ? widget
                                                    .productsModel.description
                                                : jsonEncode(_controller.document
                                                    .toDelta()
                                                    .toJson()),
                                            // marketID: ref
                                            //     .watch(productFormProviderProvider)
                                            //     .marketID,
                                            // marketName: ref
                                            //     .watch(productFormProviderProvider)
                                            //     .marketName,
                                            uid: widget.productsModel.uid,
                                            name: ref.watch(productFormProviderProvider).name.isEmpty
                                                ? widget.productsModel.name
                                                : ref
                                                    .watch(
                                                        productFormProviderProvider)
                                                    .name,
                                            category: ref
                                                    .watch(productFormProviderProvider)
                                                    .category
                                                    .isEmpty
                                                ? widget.productsModel.category
                                                : ref.watch(productFormProviderProvider).category,
                                            subCollection: ref.watch(productFormProviderProvider).subCollection.isEmpty ? widget.productsModel.subCollection : ref.watch(productFormProviderProvider).subCollection,
                                            collection: ref.watch(productFormProviderProvider).collection.isEmpty ? widget.productsModel.collection : ref.watch(productFormProviderProvider).collection,
                                            image1: ref.watch(productFormProviderProvider).image1.isEmpty ? widget.productsModel.image1 : ref.watch(productFormProviderProvider).image1,
                                            image2: ref.watch(productFormProviderProvider).image2.isEmpty ? widget.productsModel.image2 : ref.watch(productFormProviderProvider).image2,
                                            image3: ref.watch(productFormProviderProvider).image3.isEmpty ? widget.productsModel.image3 : ref.watch(productFormProviderProvider).image3,
                                            unitname1: ref.watch(productFormProviderProvider).unitname1.isEmpty ? widget.productsModel.unitname1 : ref.watch(productFormProviderProvider).unitname1,
                                            unitname2: ref.watch(productFormProviderProvider).unitname2.isEmpty ? widget.productsModel.unitname2 : ref.watch(productFormProviderProvider).unitname2,
                                            unitname3: ref.watch(productFormProviderProvider).unitname3.isEmpty ? widget.productsModel.unitname3 : ref.watch(productFormProviderProvider).unitname3,
                                            unitname4: ref.watch(productFormProviderProvider).unitname4.isEmpty ? widget.productsModel.unitname4 : ref.watch(productFormProviderProvider).unitname4,
                                            unitname5: ref.watch(productFormProviderProvider).unitname5.isEmpty ? widget.productsModel.unitname5 : ref.watch(productFormProviderProvider).unitname5,
                                            unitname6: ref.watch(productFormProviderProvider).unitname6.isEmpty ? widget.productsModel.unitname6 : ref.watch(productFormProviderProvider).unitname6,
                                            unitname7: ref.watch(productFormProviderProvider).unitname7.isEmpty ? widget.productsModel.unitname7 : ref.watch(productFormProviderProvider).unitname7,
                                            unitPrice1: ref.watch(productFormProviderProvider).unitPrice1 == 0 ? widget.productsModel.unitPrice1 : ref.watch(productFormProviderProvider).unitPrice1,
                                            unitPrice2: ref.watch(productFormProviderProvider).unitPrice2 == 0 ? widget.productsModel.unitPrice2 : ref.watch(productFormProviderProvider).unitPrice2,
                                            unitPrice3: ref.watch(productFormProviderProvider).unitPrice3 == 0 ? widget.productsModel.unitPrice3 : ref.watch(productFormProviderProvider).unitPrice3,
                                            unitPrice4: ref.watch(productFormProviderProvider).unitPrice4 == 0 ? widget.productsModel.unitPrice4 : ref.watch(productFormProviderProvider).unitPrice4,
                                            unitPrice5: ref.watch(productFormProviderProvider).unitPrice5 == 0 ? widget.productsModel.unitPrice5 : ref.watch(productFormProviderProvider).unitPrice5,
                                            unitPrice6: ref.watch(productFormProviderProvider).unitPrice6 == 0 ? widget.productsModel.unitPrice6 : ref.watch(productFormProviderProvider).unitPrice6,
                                            unitPrice7: ref.watch(productFormProviderProvider).unitPrice7 == 0 ? widget.productsModel.unitPrice7 : ref.watch(productFormProviderProvider).unitPrice7,
                                            unitOldPrice1: ref.watch(productFormProviderProvider).unitOldPrice1 == 0 ? widget.productsModel.unitOldPrice1 : ref.watch(productFormProviderProvider).unitOldPrice1,
                                            unitOldPrice2: ref.watch(productFormProviderProvider).unitOldPrice2 == 0 ? widget.productsModel.unitOldPrice2 : ref.watch(productFormProviderProvider).unitOldPrice2,
                                            unitOldPrice3: ref.watch(productFormProviderProvider).unitOldPrice3 == 0 ? widget.productsModel.unitOldPrice3 : ref.watch(productFormProviderProvider).unitOldPrice3,
                                            unitOldPrice4: ref.watch(productFormProviderProvider).unitOldPrice4 == 0 ? widget.productsModel.unitOldPrice4 : ref.watch(productFormProviderProvider).unitOldPrice4,
                                            unitOldPrice5: ref.watch(productFormProviderProvider).unitOldPrice5 == 0 ? widget.productsModel.unitOldPrice5 : ref.watch(productFormProviderProvider).unitOldPrice5,
                                            unitOldPrice6: ref.watch(productFormProviderProvider).unitOldPrice6 == 0 ? widget.productsModel.unitOldPrice6 : ref.watch(productFormProviderProvider).unitOldPrice6,
                                            unitOldPrice7: ref.watch(productFormProviderProvider).unitOldPrice7 == 0 ? widget.productsModel.unitOldPrice7 : ref.watch(productFormProviderProvider).unitOldPrice7,
                                            percantageDiscount: ref.watch(productFormProviderProvider).percantageDiscount == 0 ? widget.productsModel.percantageDiscount : ref.watch(productFormProviderProvider).percantageDiscount,
                                            vendorId: widget.productsModel.vendorId,
                                            brand: ref.watch(productFormProviderProvider).brand.isEmpty ? widget.productsModel.brand : ref.watch(productFormProviderProvider).brand),
                                        widget.productsModel.uid,
                                        context);
                                // } else {
                                //   Fluttertoast.showToast(
                                //       msg: "Some Fields Are Required".tr(),
                                //       toastLength: Toast.LENGTH_SHORT,
                                //       gravity: ToastGravity.TOP,
                                //       timeInSecForIosWeb: 1,
                                //       backgroundColor:
                                //           Theme.of(context).primaryColor,
                                //       textColor: Colors.white,
                                //       fontSize: 14.0);
                                // }
                              },
                              child: const Text('Update Product',
                                      style: TextStyle(color: Colors.white))
                                  .tr()),
                        ),
                      ),
                const Gap(50)
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
