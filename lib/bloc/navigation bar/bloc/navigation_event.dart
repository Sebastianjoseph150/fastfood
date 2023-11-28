part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigateToHomeEvent extends NavigationEvent {}

class NavigateToProfileEvent extends NavigationEvent {}

class NavigateToSettingsEvent extends NavigationEvent {}

class NavigateToCartEvent extends NavigationEvent {}
