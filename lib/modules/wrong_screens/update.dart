import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/images/images.dart';
import '../../shared/styles/colors.dart';
import '../widgets/item_shared/ui.dart';

class Update extends StatelessWidget {
  Update({
    required this.releaseNote,
    required this.url,
  });
  String url;
  String releaseNote;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.update,width: double.infinity,height: 225,color:defaultColor),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                children: [
                  Text(
                    tr('update_title'),
                    style: TextStyle(
                        color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 22
                    ),
                  ),
                  Text(
                    releaseNote,
                    style: TextStyle(
                        color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 11
                    ),
                  ),
                ],
              ),
            ),
            DefaultButton(
                text: tr('update_now'),
                onTap: ()async{
                  if(await canLaunchUrl(Uri.parse(url))){
                  await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
                  }else{
                    UIAlert.showAlert(context,message:'This Url can\'t launch',type: MessageType.error);
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}
