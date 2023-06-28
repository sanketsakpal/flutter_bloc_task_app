// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final Filter filter;
  const FilterState({
    required this.filter,
  });

  factory FilterState.initial() {
    return const FilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  FilterState copyWith({
    Filter? filter,
  }) {
    return FilterState(
      filter: filter ?? this.filter,
    );
  }
}
