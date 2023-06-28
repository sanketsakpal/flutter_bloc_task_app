part of 'bottom_nav_cubit.dart';

class BottomNavState extends Equatable {
  // final IntIndex intIndex;
  //  int index;
  final int selectedIndex;
  const BottomNavState({
    required this.selectedIndex,
  }
      // this.index,this.intIndex,

      );

  @override
  List<Object> get props => [
        selectedIndex
        // intIndex,intIndex
      ];
}

class BottomNavInitial extends BottomNavState {
  const BottomNavInitial({required super.selectedIndex});
}
