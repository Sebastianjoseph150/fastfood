part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class HomeScreenState extends NavigationState {}

class ProfileScreenState extends NavigationState {}

class SettingsScreenState extends NavigationState {}

 class CartScreenState extends NavigationState{}