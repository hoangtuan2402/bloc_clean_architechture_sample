import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/core/error/failuers.dart';
import 'package:bloc_clean_architecture/core/usecases/usecases.dart';
import 'package:bloc_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_clean_architecture/features/number_trivia/domain/usecases/get_concert_number_trivia.dart';
import 'package:bloc_clean_architecture/util/input_converter.dart';
import 'package:bloc_clean_architecture/util/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

import '../../domain/usecases/get_random_number_trivia.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcertNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required GetConcertNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required this.inputConverter,
  })  : getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Empty()) {
    on<LoadHomeEvent>(
      (event, emit) => emit(
        Empty(),
      ),
    );
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      await inputEither.fold(
        (failure) async {
          emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        },
        (integer) async {
          emit(Loading());
          final failureOrTrivia =
              await getConcreteNumberTrivia.call(Params(number: integer));
          await failureOrTrivia.fold(
            (failure) async {
              emit(Error(message: _mapFailureToMessage(failure)));
            },
            (trivia) async {
              logi.i(trivia.toString());
              emit(Loaded(trivia: trivia));
            },
          );
        },
      );
    });
    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      await failureOrTrivia.fold(
        (failure) async {
          emit(Error(message: _mapFailureToMessage(failure)));
        },
        (trivia) async {
          logi.i(trivia.toString());
          emit(Loaded(trivia: trivia));
        },
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
