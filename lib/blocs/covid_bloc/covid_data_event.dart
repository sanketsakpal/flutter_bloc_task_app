part of 'covid_data_bloc.dart';

abstract class CovidDataEvent extends Equatable {
  const CovidDataEvent();

  @override
  List<Object> get props => [];
}

class GetCovidList extends CovidDataEvent {}
