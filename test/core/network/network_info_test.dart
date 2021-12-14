import 'package:bloc_clean_architecture/core/network/network_info.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  late NetworkInfoImpl? networkInfo;
  late MockDataConnectionChecker? mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker!);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
          () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker!.hasConnection)
            .thenAnswer((_) async => tHasConnectionFuture);
        // act
        final result = networkInfo!.isConnected;
        // assert
        verify(mockDataConnectionChecker!.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}