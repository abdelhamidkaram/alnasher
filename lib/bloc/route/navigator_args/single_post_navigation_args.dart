import 'package:listingapp/bloc/route/navigator_args/base_navegator_args.dart';
import 'package:listingapp/model/home_model.dart';

class SinglePostNavigationArgs extends BaseNavigatorArgs{
  final Ad ad ;
  SinglePostNavigationArgs({required this.ad});
}