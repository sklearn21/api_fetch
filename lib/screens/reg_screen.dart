import 'package:api_fetch/model/txin.dart';
import 'package:api_fetch/services/http_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  late HttpServices http;
  TxinResponse? txinResponse;
  String? transToken;
  bool isLoading = false;

  Future getTxin() async {
    //Initiate beneficiary authentication using mobile and OTP

    Response response;

    try {
      isLoading = true;

      response = await http.getTxnId('81800799');
      isLoading = false;
      if (response.statusCode == 200) {
        setState(() {
          txinResponse = TxinResponse.fromJson(response.data);
          transToken = txinResponse!.txnId;
          print(transToken);
        });
      } else {
        print("There is some problem with status code");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpServices();
    getTxin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Center(
        child: Text('$transToken'),
      ),
    );
  }
}
