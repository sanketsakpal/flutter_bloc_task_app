part of 'covid_data_bloc.dart';

abstract class CovidDataState extends Equatable {
  const CovidDataState();

  @override
  List<Object> get props => [];
}

class CovidInitial extends CovidDataState {}

class CovidLoading extends CovidDataState {}

class CovidLoaded extends CovidDataState {
  final CovidModel covidModel;
  const CovidLoaded(this.covidModel);
}

class CovidError extends CovidDataState {
  final String? message;
  const CovidError(this.message);
}
