import 'package:daily_wash/modules/widgets/item_shared/default_appbar.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ComplimentsScreen extends StatelessWidget {
  ComplimentsScreen({Key? key}) : super(key: key);

  Text getText(String text)=>Text(text,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          DefaultAppBar(text: tr('add_compliments')),
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
                        getText(tr('full_name')),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
                          child: DefaultForm(
                              controller: nameController,
                              validator: (str){
                                if(str.isEmpty)return tr('name_empty');
                              },
                              hint: tr('enter_name')
                          ),
                        ),
                        getText(tr('email')),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
                          child: DefaultForm(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validator: (str){
                                if(str.isEmpty)return tr('email_empty');
                                if(!str.contains('.')||!str.contains('@'))return 'Email Invalid';
                              },
                              hint: tr('enter_email')
                          ),
                        ),
                        getText(tr('phone')),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
                          child: DefaultForm(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validator: (str){
                                if(str.isEmpty)return tr('phone_empty');
                              },
                              hint:'+971 xxxxxxxx'
                          ),
                        ),
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
                        getText(tr('compliments_details')),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
                          child: DefaultForm(
                              controller: messageController,
                              maxLines: 5,
                              validator: (str){
                                if(str.isEmpty)return tr('compliments_empty');
                              },
                              hint: tr('enter_compliments')
                          ),
                        ),
                        DefaultButton(
                            text: tr('send_compliments'),
                            width: double.infinity,
                            onTap: (){
                              if(formKey.currentState!.validate()){
                                Navigator.pop(context);
                              }
                            }
                        ),
                        const SizedBox(height: 30,),
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
  }
}
