import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vendor_app/model/bank_model.dart';
import 'package:vendor_app/widgets/add_bank.dart';

import '../constant.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  List<BankModel> banks = [];
  bool isLoaded = false;
  getBanks() async {
    setState(() {
      isLoaded = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('vendors')
        .doc(user!.uid)
        .collection('Banks')
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      banks.clear();
      for (var element in event.docs) {
        var prods = BankModel.fromMap(element, element.id);
        setState(() {
          banks.add(prods);
        });
      }
    });
  }

  @override
  void initState() {
    getBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banks').tr(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddBank();
          }));
        },
        child: const Icon(Icons.add),
      ),
      body: banks.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.account_balance,
                    color: appColor,
                    size: MediaQuery.of(context).size.width >= 1100
                        ? MediaQuery.of(context).size.width / 5
                        : MediaQuery.of(context).size.width / 1.5,
                  ),
                ),
                const Gap(20),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: banks.length,
              itemBuilder: (context, index) {
                BankModel bankModel = banks[index];
                return ListTile(
                  trailing: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete Bank?'),
                                content: const Text(
                                        'Are you sure you want to delete this bank?')
                                    .tr(),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No').tr()),
                                  TextButton(
                                      onPressed: () {
                                        final FirebaseAuth auth =
                                            FirebaseAuth.instance;
                                        User? user = auth.currentUser;
                                        FirebaseFirestore.instance
                                            .collection('vendors')
                                            .doc(user!.uid)
                                            .collection('Banks')
                                            .doc(bankModel.uid)
                                            .delete()
                                            .then((value) {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        });
                                      },
                                      child: const Text('Yes').tr())
                                ],
                              );
                            });
                      },
                      child: const Icon(Icons.delete)),
                  title: Text(bankModel.bankName),
                  subtitle: Text(bankModel.accountNumber),
                );
              }),
    );
  }
}
