import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_appbar.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_form.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/components/components.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  Text getText(String text)=>Text(text,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),);

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();


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
          DefaultAppBar(text: tr('contact_us')),
          Expanded(
            child: SingleChildScrollView(
              child: InkWell(
                onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                final Uri params = Uri(
                                  scheme: 'mailto',
                                  path: cubit.settingsModel?.data?.projectEmailAddress??'',
                                );
                                final url = params.toString();
                                openUrl(url);
                              }, child: Image.asset(Images.gmail,width: 24,)),
                            InkWell(
                              onTap: (){
                                _shareViaTwitter();
                                //openUrl(cubit.settingsModel?.data?.projectTwitterLink??'');
                              }, child: Image.asset(Images.twitter,width: 24,)),
                            InkWell(
                              onTap: (){
                                AppCubit.get(context).whatAppContact(
                                    phone: cubit.settingsModel?.data?.projectWhatsAppNumber??''
                                );
                              }, child: Image.asset(Images.whatsapp,width: 24,)
                            ),
                            InkWell(
                              onTap: (){
                                _shareViaInstagram();
                                //openUrl(cubit.settingsModel?.data?.projectInstagramLink??'');
                              }, child: Image.asset(Images.insta,width: 24,)),
                            InkWell(
                              onTap: (){
                                _shareViaFacebook();
                                //openUrl(cubit.settingsModel?.data?.projectFacebookLink??'');
                              }, child: Image.asset(Images.fb,width: 24,)),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        getText(tr('subject')),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
                          child: DefaultForm(
                              controller: subjectController,
                              validator: (str){
                                if(str.isEmpty)return tr('subject_empty');
                              },
                              hint: tr('enter_subject')
                          ),
                        ),
                        getText(tr('message_details')),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
                          child: DefaultForm(
                              controller: messageController,
                              maxLines: 5,
                              validator: (str){
                                if(str.isEmpty)return tr('message_empty');
                              },
                              hint: tr('enter_message')
                          ),
                        ),
                        ConditionalBuilder(
                          condition: state is! ContactUsLoadingState,
                          fallback: (context)=>Center(child: CupertinoActivityIndicator()),
                          builder: (context)=> DefaultButton(
                              text: tr('send_message'),
                              width: double.infinity,
                              onTap: (){
                                if(formKey.currentState!.validate()){
                                  SettingsCubit.get(context).contactUs(
                                    context,
                                    message: messageController.text,
                                    subject: subjectController.text
                                  );
                                }
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }

  void _shareViaTwitter() async {
    // Replace with your Twitter sharing logic
    // Example: Launching a Twitter share URL
    String twitterUrl = 'https://twitter.com/intent/tweet?text=${Uri.parse('Hello, visit Daily Wash app')}';
    await canLaunch(twitterUrl)
        ? await launch(twitterUrl)
        : throw 'Could not launch $twitterUrl';
  }

  void _shareViaInstagram() async {
    // Replace with your Instagram sharing logic
    // Example: Launching an Instagram share URL
    String instagramUrl = 'https://www.instagram.com/dailywash.ae?url=${Uri.parse('Hello, This is our instagram page')}';
    await canLaunch(instagramUrl)
        ? await launch(instagramUrl)
        : throw 'Could not launch $instagramUrl';
  }

  void _shareViaFacebook() async {
    // Replace with your Facebook sharing logic
    // Example: Launching a Facebook share URL
    String facebookUrl = 'https://www.facebook.com/Dailywash.ae.?url?u=${Uri.parse('Hello, This is our facebook page')}';
    await canLaunch(facebookUrl)
        ? await launch(facebookUrl)
        : throw 'Could not launch $facebookUrl';
  }
}
