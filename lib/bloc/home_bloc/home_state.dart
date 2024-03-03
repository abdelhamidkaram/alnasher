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

class GetMyAdsLoading extends HomeState{}
class GetMyAdsFinishCall extends HomeState{}
class GetMyAdsError extends HomeState{}

class GetMyFavLoading extends HomeState{}
class GetMyFavFinishCall extends HomeState{}
class GetMyFavError extends HomeState{}

class GetPrivacyLoading extends HomeState{}
class GetPrivacyFinishCall extends HomeState{}
class GetPrivacyError extends HomeState{}

class GetAboutLoading extends HomeState{}
class GetAboutFinishCall extends HomeState{}
class GetAboutError extends HomeState{}