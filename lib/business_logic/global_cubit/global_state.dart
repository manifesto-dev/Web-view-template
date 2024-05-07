part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class LanguageChangedState extends GlobalState {}

class ThemeChangedState extends GlobalState {}

class MoveInScreenState extends GlobalState {}

class LoadingState extends GlobalState {}

class NoDataState extends GlobalState {}

class SuccesfullState extends GlobalState {}
