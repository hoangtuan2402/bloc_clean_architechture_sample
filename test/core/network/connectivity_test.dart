import 'package:bloc_clean_architecture/core/network/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late ConnectivityImpl connectivityImpl;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    connectivityImpl = ConnectivityImpl(mockConnectivity);
  });

  group("Test Connection", (){
    test("Connection", (){
      dynamic connectMobile;
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) => connectMobile);

      final result = connectivityImpl.connection;


      verify(mockConnectivity.checkConnectivity());
      expect(result, connectMobile);
    });
  });
}
