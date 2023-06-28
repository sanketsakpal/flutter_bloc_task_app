
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/models/covid_data_model.dart';
import 'package:flutter_bloc_task_app/repositories/posts_repository.dart';

part 'covid_data_event.dart';
part 'covid_data_state.dart';

class CovidDataBloc extends Bloc<CovidDataEvent, CovidDataState> {
  final PostsRepository repository;
  CovidDataBloc({required this.repository}) : super(CovidInitial()) {
    on<GetCovidList>((event, emit) async {
      try {
        emit(CovidLoading());
        final covidList = await repository.getCovidList();
        emit(CovidLoaded(covidList));
        if (covidList.error != null) {
          emit(CovidError(covidList.error));
        }
      } catch (e) {
        emit(const CovidError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
