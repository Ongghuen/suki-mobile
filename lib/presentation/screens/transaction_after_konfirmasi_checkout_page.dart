import 'package:flutter/material.dart';
import 'package:mobile/presentation/screens/dashboard_screen/main_page.dart';
import 'package:mobile/presentation/screens/transaction_page.dart';

class TransactionAfterConfirmedCheckoutPage extends StatefulWidget {
  final int transactionId;

  TransactionAfterConfirmedCheckoutPage({Key? key, required this.transactionId})
      : super(key: key);

  @override
  State<TransactionAfterConfirmedCheckoutPage> createState() =>
      _TransactionAfterConfirmedCheckoutPageState();
}

class _TransactionAfterConfirmedCheckoutPageState
    extends State<TransactionAfterConfirmedCheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage()
            ),
            ModalRoute.withName("/main")
        );
    },
      child: Scaffold(
          body: SafeArea(
            child: Container(child: Text("${widget.transactionId}")),
          )),
    );
  }
}
