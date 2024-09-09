import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogDialog extends StatelessWidget {
  LogDialog({
    required this.onTap,
    required this.image,
    required this.hint,
    required this.buttonText,
  });

  String hint;
  String image;
  String buttonText;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(30),
                color: Colors.white
            ),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image, width: 80,),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  child: Text(
                    hint,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: ConditionalBuilder(
                    condition: state is! DeleteAccountLoadingState,
                    fallback: (context)=>CupertinoActivityIndicator(),
                    builder: (context)=> DefaultButton(
                        text: buttonText,
                        width: double.infinity,
                        onTap: onTap
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        tr('discard'),
                        style: TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: Colors.grey.shade800),
                      )
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
