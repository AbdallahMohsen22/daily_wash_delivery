import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:daily_wash/modules/auth/auth_cubit/auth_states.dart';
import 'package:daily_wash/modules/auth/verification_screen.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/styles/colors.dart';
import '../widgets/item_shared/default_button.dart';
import '../widgets/item_shared/default_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);


  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: InkWell(
        onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        child: Center(
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.splash,height: 116,width: 116,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '${tr('sign_as')} \n',
                        style: TextStyle(fontSize: 35.5,fontWeight: FontWeight.w600,color: signTextColor,height: 1.2),
                        children: [
                          TextSpan(
                            text: tr('delivery'),
                            style: TextStyle(fontSize: 35.5,fontWeight: FontWeight.w800,color: defaultColor)
                          )
                        ]
                      )
                    ),
                  ),
                  DefaultForm(
                    controller: AuthCubit.get(context).phoneController,
                    validator: (str){
                      if(str.isEmpty) return tr('phone_empty');
                    },
                    type: TextInputType.name,
                    autofocus: true,
                    hint: '+971 ********',
                    suffix: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(Images.phone,width: 20,height: 20,),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ConditionalBuilder(
                    condition: state is! LoginLoadingState,
                    fallback: (context)=>CupertinoActivityIndicator(),
                    builder: (context)=> DefaultButton(
                      text: tr('sign_in'),
                      onTap: (){
                        if(formKey.currentState!.validate()){
                          AuthCubit.get(context).login(context: context);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
