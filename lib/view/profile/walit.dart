import 'package:alnsher/core/app_colors.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  Widget build(BuildContext context) {

    List<BalanceModel> items = [
      BalanceModel("15000", "لاب توب ابل ماك برو1 ", "29-10-2022", false,),
      BalanceModel("600", "لاب توب ابل ماك برو2 ", "28-10-2022", true,),
      BalanceModel("51244", "لاب توب ابل ماك برو3 ", "27-10-2022", false,),
      BalanceModel("500", "لاب توب ابل ماك برو4 ", "26-10-2022", true,),
      BalanceModel("15000", "لاب توب ابل ماك برو5 ", "25-10-2022", false,),
      BalanceModel("50", "لاب توب ابل ماك برو6 ", "24-10-2022", true,),
      BalanceModel("7000", "لاب توب ابل ماك برو7 ", "23-10-2022", false,),
      BalanceModel("15000", "لاب توب ابل ماك برو8 ", "22-10-2022", true,),
      BalanceModel("8500", "لاب توب ابل ماك برو9 ", "21-10-2022", false,),
      BalanceModel("15000", "لاب توب ابل ماك برو10 ", "20-10-2022", true,),
    ];
    return   Directionality(
      textDirection: TextDirection.rtl ,
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 24),
            child: Column(
              children:  [
                //TODO: GET BALANCE FORM SERVER
                const Center(child: BalanceWidget(balance: "1500",)),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: (){
                    //TODO: RE BALANCE
                  },
                  child:
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.green)
                    ),
                    child:const Center(child:  Text("سحب الرصيد " , style: AppTextStyles.mediumGreen,)) ,
                  ),
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    //TODO: ADD BALANCE
                  },
                  child:
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.green)
                    ),
                    child:const Center(child:  Text("إضافة رصيد " , style: AppTextStyles.mediumGreen,)) ,
                  ),
                ),
                const SizedBox(height: 12,),
                Column(
                  children: List.generate(10, (index) =>  BalanceItemBuilder(balanceModel: items[index])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class BalanceItemBuilder extends StatefulWidget {
  final BalanceModel balanceModel ;
  const BalanceItemBuilder({Key? key, required this.balanceModel}) : super(key: key);

  @override
  State<BalanceItemBuilder> createState() => _BalanceItemBuilderState();
}

class _BalanceItemBuilderState extends State<BalanceItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.balanceModel.data),
              const Spacer()
            ],
          ),
          const SizedBox(height: 16,),
          Row(
              children:   [
                Icon(
                  widget.balanceModel.isAdd ?
                  Icons.add_circle : Icons.remove_circle,
                  color: widget.balanceModel.isAdd ? AppColors.green : Colors.red,
                  size:  30,
                ) ,
                const SizedBox(width:8,),
                Text(widget.balanceModel.name , style: AppTextStyles.mediumBlackBold,),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const  Text("KW", style: AppTextStyles.currencyGreen,),
                    Text(widget.balanceModel.isAdd ?widget.balanceModel.balance + " + "  : widget.balanceModel.balance + " - "  , style: AppTextStyles.titleGreen,),
                  ],),
              ]
          ),
        ],
      ),
    );
  }
}

class BalanceModel {
  final String data ;
  final String name ;
  final String balance ;
  final bool isAdd ;
  BalanceModel(this.balance , this.name , this.data , this.isAdd );
}


class BalanceWidget extends StatefulWidget {
  final String  balance ;
  const BalanceWidget({Key? key, required this.balance}) : super(key: key);
  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}
class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator BalanceWidget - GROUP
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: double.infinity ,
          height: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient : LinearGradient(
                begin: Alignment(0.0901101678609848,0.9605768322944641),
                end: Alignment(-0.9605768322944641,0.42025235295295715),
                colors: [Color.fromRGBO(93, 66, 198, 1),Color.fromRGBO(87, 113, 252, 1)]
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(" الرصيد المتوفر " , style: AppTextStyles.mediumWhite,) ,
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(" KW" , style: AppTextStyles.smallWhite,),
                    Text(widget.balance , style: AppTextStyles.titleWhite,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class AppTextStyles {
  // ---- small  ---------//
  static const TextStyle smallGrey = TextStyle(
    color: AppColors.grey,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle smallGrey_12 = TextStyle(
    color: AppColors.grey,
    fontSize: 11,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle smallGreyBold_12 = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.grey,
    fontSize: 11,
  );
  static const TextStyle smallGreyBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.grey,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle smallBlue = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle smallBlue_12 = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
    fontSize: 12,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle smallBlack = TextStyle(
    color: Colors.black,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle smallBlueBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle smallWhite = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle smallGreen = TextStyle(
    color: AppColors.green,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );

  // ---- medium ---------//
  static const TextStyle mediumGrey = TextStyle(

      color: AppColors.grey,
      fontSize: 18,
      height: 1.5);
  static const TextStyle mediumWhite = TextStyle(

      color: AppColors.white,
      fontSize: 18,
      height: 1.5);
  static const TextStyle mediumBlue = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle mediumBlack = TextStyle(
    color: Colors.black,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle mediumBlackBold_14 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle mediumBlackBold = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle mediumBlackBold_17 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle mediumGreen = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.green,
    fontSize: 18,
    overflow: TextOverflow.ellipsis,
  );

  //--------- Buttons ---------//
  static  TextStyle buttonTextStyle(bool isVisitor) =>  TextStyle(
    color: isVisitor ? AppColors.primaryColor :  AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 20 ,
    overflow: TextOverflow.ellipsis,
  );

  //--------- title ------------ //
  static const TextStyle titleBlack = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleBlue = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    fontSize: 20,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleGrey = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.grey,
    fontSize: 20,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleWhite = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontSize: 24,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleRed = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    fontSize: 20,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleGreen = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.green,
    fontSize: 20,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleGreen_30 = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.green,
    fontSize: 30,
    overflow: TextOverflow.ellipsis,
  );

  //small title
  static const TextStyle titleSmallBlue = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleSmallBlue_18 = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    fontSize: 18,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleSmallBlack = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 20,
    overflow: TextOverflow.ellipsis,
  );

  //product box
  static const TextStyle titleProductBlue = TextStyle(
    color:AppColors.primaryColor,
    fontSize: 18,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleSmallGreen = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.green,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titlePriceBlack = TextStyle(
    color: Colors.black,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle currencyRed = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    fontSize: 12,
    textBaseline: TextBaseline.alphabetic,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle currencyGreen = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.green,
    fontSize: 12,
    textBaseline: TextBaseline.alphabetic,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle titleBlue_24 = TextStyle(
    fontWeight: FontWeight.bold,
    color:AppColors.primaryColor,
    fontSize: 24,
    overflow: TextOverflow.ellipsis,
  );
}