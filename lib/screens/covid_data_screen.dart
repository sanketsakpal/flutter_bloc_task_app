import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/blocs/covid_bloc/covid_data_bloc.dart';
import 'package:flutter_bloc_task_app/models/covid_data_model.dart';
import 'package:flutter_bloc_task_app/repositories/posts_repository.dart';
import 'package:flutter_bloc_task_app/service/post_service.dart';

class CovidDataScreen extends StatelessWidget {
  const CovidDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CovidDataBloc(
          repository: PostsRepository(PostsService())..getCovidList())
        ..add(GetCovidList()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Api call"),
        ),
        body: Builder(builder: (context) {
          return buildListCovid(context);
        }),
      ),
    );
  }
}

Widget buildListCovid(BuildContext context) {
  return BlocListener<CovidDataBloc, CovidDataState>(
    listener: (context, state) {
      if (state is CovidError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message!)));
      }
    },
    child: BlocBuilder<CovidDataBloc, CovidDataState>(
      builder: (context, state) {
        if (state is CovidInitial) {
          return buildLoading();
        } else if (state is CovidLoading) {
          return buildLoading();
        } else if (state is CovidLoaded) {
          return buildCard(context, state.covidModel);
        } else if (state is CovidError) {
          return Container();
        }
        return Container();
      },
    ),
  );
}

Widget buildCard(BuildContext context, CovidModel model) {
  return ListView.builder(
    itemCount: model.countries?.length,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text("Country: ${model.countries?[index].country}"),
                Text(
                    "Total Confirmed: ${model.countries?[index].totalConfirmed}"),
                Text("Total Deaths: ${model.countries?[index].totalDeaths}"),
                Text(
                    "Total Recovered: ${model.countries?[index].totalRecovered}"),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildLoading() => const Center(child: CircularProgressIndicator());
