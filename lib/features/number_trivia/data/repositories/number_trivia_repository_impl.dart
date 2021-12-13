import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/core/error/failuers.dart';
import 'package:bloc_clean_architecture/core/network/network_info.dart';
import 'package:bloc_clean_architecture/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:bloc_clean_architecture/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:bloc_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:bloc_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_clean_architecture/features/number_trivia/domain/repositories/number_trivial_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcertNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomConcertNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  /// cho nay la truyen vao 1 function duoc dinh nghia bang typeDef
  /// viet day du trong ngoac: _getTrivia(Future<NumberTrivia> Function() getConcreteOrRandom; )
  /// 3:01:25 part full
  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
