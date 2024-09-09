import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';

import '../../../shared/components/constants.dart';
import '../../widgets/item_shared/shimmer.dart';

class TermsScreen extends StatelessWidget {
  TermsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              SizedBox(height: 20,),
              DefaultAppBar(text: tr('terms')),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: ConditionalBuilder(
                        condition: cubit.staticPagesModel!=null,
                        fallback: (context)=>ListView.separated(
                          itemCount: 20,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (c,i)=>CustomShimmer(width: double.infinity, height: 20),
                          separatorBuilder: (c,i)=>const Gap(15),
                        ),
                        builder: (context)=> Html(
                          data:myLocale == 'en'
                              ?cubit.staticPagesModel!.data!.termsAndConditiondsEn
                              :myLocale == 'ar'
                              ?cubit.staticPagesModel!.data!.termsAndConditiondsAr
                              :cubit.staticPagesModel!.data!.termsAndConditiondsUr,

                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
