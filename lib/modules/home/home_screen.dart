import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/widgets/home/app_bar_shimmer.dart';
import 'package:daily_wash/modules/widgets/item_shared/shimmer.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../layout/cubit/app_states.dart';
import '../../shared/styles/colors.dart';
import '../widgets/home/home_appbar.dart';
import '../widgets/home/home_dropdown.dart';
import '../widgets/home/order_list_shimmer.dart';
import '../widgets/home/order_widget.dart';
import '../widgets/item_shared/default_button.dart';
import '../widgets/item_shared/list_is_empty.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Wash"),
      ),
      body: BlocProvider(
        create: (context) => AppCubit()..getOrders(context: context),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, appStates) {
            var cubit = AppCubit.get(context);
            return BlocConsumer<SettingsCubit, SettingsStates>(
              listener: (context, state) {},
              builder: (context, settingsStates) {
                return RefreshIndicator(
                  onRefresh: () async {
                    cubit.getOrders(context: context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.background),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        ConditionalBuilder(
                          condition:
                              SettingsCubit.get(context).deliveryModel != null,
                          fallback: (context) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: HomeDropDown(),
                          ),
                          builder: (context) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeAppBar(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HomeDropDown(),
                                    // DefaultButton(
                                    //   width: 150,
                                    //   height:35,
                                    //   textSize: 13,
                                    //   radius: 10,
                                    //   text: 'Accept All',
                                    //   onTap: (){
                                    //     // // cubit.acceptAllOrder(context: context);
                                    //     // context.read<AppCubit>().acceptAllOrder(context: context);
                                    //     for (int i=0;i<cubit.orderModel2!.data!.data!.length;i++){
                                    //       cubit.bookOrder(context: context, data: cubit.orderModel2!.data!.data![i]);
                                    //     }
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: ConditionalBuilder(
                                  condition: cubit.orderModel2 !=
                                      null, //cubit.val == 'new_orders'?cubit.orderModel!=null: ,
                                  fallback: (context) => OrderListShimmer(),
                                  builder: (context) => ConditionalBuilder(
                                      condition:
                                          // cubit.val == 'new_orders'
                                          //     ?cubit.orderModel!.data!.isNotEmpty
                                          //     :
                                          cubit.orderModel2!.data!.data!
                                              .isNotEmpty,
                                      fallback: (context) => ConditionalBuilder(
                                            condition:
                                                appStates is! OrderLoadingState,
                                            fallback: (context) =>
                                                OrderListShimmer(),
                                            builder: (context) =>
                                                ListIsEmpty('no_orders_yet'),
                                          ),
                                      builder: (context) {
                                        return ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (c, i) => OrderWidget(
                                              // cubit.val == 'new_orders'
                                              //     ?cubit.orderModel!.data![i]
                                              //     :
                                              cubit.orderModel2!.data!.data![i],
                                              appStates),
                                          separatorBuilder: (c, i) =>
                                              const SizedBox(
                                            height: 30,
                                          ),
                                          itemCount:
                                              //   cubit.val == 'new_orders'
                                              // ?cubit.orderModel!.data!.length
                                              //     :
                                              cubit.orderModel2!.data!.data!
                                                  .length,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 30,
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
