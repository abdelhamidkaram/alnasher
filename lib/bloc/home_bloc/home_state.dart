part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetHomeAdsSuccess extends HomeState {}
class GetHomeAdsLoading extends HomeState {}
class GetHomeAdsError extends HomeState {}

class GetHomeSuccess extends HomeState {}
class GetHomeLoading extends HomeState {}
class GetHomeError extends HomeState {}

class ChangNavBareSuccess extends HomeState {}
class ChangNavBareLoading extends HomeState {}
class ChangNavBareError extends HomeState {}

class ChangeFavLoading extends HomeState{}
class ChangeFavFinishCall extends HomeState{}
class ChangeFavError extends HomeState{}