import 'package:go_router/go_router.dart';

import '../views/airport_detail_view.dart';
import '../views/airport_list_view.dart';
import '../views/dashboard_view.dart';
import '../views/department_detail_view.dart';
import '../views/department_list_view.dart';
import '../views/president_detail_view.dart';
import '../views/president_list_view.dart';
import '../views/touristic_attraction_detail_view.dart';
import '../views/touristic_attraction_list_view.dart';
import '../views/typical_dish_detail_view.dart';
import '../views/typical_dish_list_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/departments',
      name: 'departments',
      builder: (context, state) => const DepartmentListView(),
    ),
    GoRoute(
      path: '/departments/:id',
      name: 'departmentDetail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return DepartmentDetailView(id: id);
      },
    ),
    GoRoute(
      path: '/presidents',
      name: 'presidents',
      builder: (context, state) => const PresidentListView(),
    ),
    GoRoute(
      path: '/presidents/:id',
      name: 'presidentDetail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PresidentDetailView(id: id);
      },
    ),
    GoRoute(
      path: '/touristic-attractions',
      name: 'touristicAttractions',
      builder: (context, state) => const TouristicAttractionListView(),
    ),
    GoRoute(
      path: '/touristic-attractions/:id',
      name: 'touristicAttractionDetail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return TouristicAttractionDetailView(id: id);
      },
    ),
    GoRoute(
      path: '/typical-dishes',
      name: 'typicalDishes',
      builder: (context, state) => const TypicalDishListView(),
    ),
    GoRoute(
      path: '/typical-dishes/:id',
      name: 'typicalDishDetail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return TypicalDishDetailView(id: id);
      },
    ),
    GoRoute(
      path: '/airports',
      name: 'airports',
      builder: (context, state) => const AirportListView(),
    ),
    GoRoute(
      path: '/airports/:id',
      name: 'airportDetail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return AirportDetailView(id: id);
      },
    ),
  ],
);
