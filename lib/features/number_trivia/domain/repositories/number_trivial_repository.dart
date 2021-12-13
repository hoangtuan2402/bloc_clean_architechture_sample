import 'package:bloc_clean_architecture/core/error/failuers.dart';
import 'package:bloc_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcertNumberTrivia(int number);

  Future<Either<Failure, NumberTrivia>> getRandomConcertNumberTrivia();


}
