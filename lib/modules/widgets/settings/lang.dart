import 'package:daily_wash/layout/app_layout.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';

class LangDialog extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20)),
      child: Padding(
        padding:const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LangItem(
              image: Images.ar,
              lang: 'ar',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: LangItem(
                image: Images.en,
                lang: 'en',
              ),
            ),
            LangItem(
              image: Images.ur,
              lang: 'ur',
            )
          ],
        ),
      ),
    );
  }
}



class LangItem extends StatelessWidget {
  LangItem({
    required this.lang,
    required this.image,
});

  String lang;
  String image;

  void submit(String lang,BuildContext context){
    myLocale = lang;
    context.setLocale(Locale(myLocale));
    CacheHelper.saveData(key: 'locale', value: myLocale);
    AppCubit.get(context).changeIndex(1);
    navigateAndFinish(context, AppLayout());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>submit(lang,context),
      child: Container(
        height: 56,width: double.infinity,
        decoration: BoxDecoration(
            color: myLocale == lang?defaultColor:Colors.white,
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(color: defaultColor)
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.center,
        child: Row(
          children: [
            //Image.asset(image,width: 27,),
            Expanded(
              child: Text(
                tr(lang),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: myLocale == lang?Colors.white:defaultColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

