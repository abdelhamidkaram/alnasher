part of 'single_cubit.dart';

@immutable
abstract class SingleState {}

class SingleInitial extends SingleState {}

class ChangeFavLoading extends SingleState{}
class ChangeFavFinishCall extends SingleState{}
class ChangeFavError extends SingleState{}
