import 'package:bloc_clean_architecture/core/error/failuers.dart';
import 'package:bloc_clean_architecture/core/usecases/usecases.dart';
import 'package:bloc_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_clean_architecture/features/number_trivia/domain/repositories/number_trivial_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetConcertNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcertNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcertNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
