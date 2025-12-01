library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';







class ExampleConnector {
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-northeast1',
    'example',
    'flutter--hackathon-thema',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

