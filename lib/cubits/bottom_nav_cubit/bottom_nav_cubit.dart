import 'package:equatable/equatable.dart';

import '../../blocs/bloc_export.dart';

part 'bottom_nav_state.dart';

enum IntIndex { pendingTasks, completedTasks, favoriteTasks }
//  List pages = [
//     const PendingTaskScreen(),
//     const CompletedTask(),
//     const FavoriteTask(),
//   ];
class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super( const BottomNavInitial(selectedIndex: 0
  //   0
  
  // , IntIndex.pendingTasks, 
  ));

   void onDestinationSelected(int currentIndex) => emit(
        BottomNavState(
        selectedIndex:   currentIndex
        ),
      );

  // void getNavBarItem(IntIndex intIndex) {
  //   switch (intIndex) {
  //     case IntIndex.pendingTasks:
  //       emit( BottomNavState(0, IntIndex.pendingTasks));
  //       break;
  //     case IntIndex.completedTasks:
  //       emit( BottomNavState(1, IntIndex.completedTasks));
  //       break;
  //     case IntIndex.favoriteTasks:
  //       emit( BottomNavState(2, IntIndex.favoriteTasks));
  //       break;
  //   }
  // }
}
