import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/images/images.dart';
import '../../item_shared/default_button.dart';


class ChoosePhoto extends StatefulWidget {



  @override
  State<ChoosePhoto> createState() => _ChoosePhotoState();
}

class _ChoosePhotoState extends State<ChoosePhoto> {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(tr('select_image'), style:const TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              Row(
                children: [
                  ImageButtom(
                      onTap: () {
                        cubit.pick(ImageSource.gallery);
                      },
                      title: tr('browse'),
                      image: Images.browse
                  ),
                  const Spacer(),
                  ImageButtom(
                      onTap: () {
                        cubit.pick(ImageSource.camera);
                      },
                      title: tr('camera'),
                      image: Images.camera
                  ),
                ],
              ),
              if(cubit.profileImage!=null)
                Expanded(child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.file(File(cubit.profileImage!.path),fit: BoxFit.cover,width: 200,height: 200,),
                    InkWell(
                        onTap: (){
                          cubit.profileImage=null;
                          cubit.emitState();
                        },
                        child: Icon(Icons.delete,color: Colors.red,size: 100,))
                  ],
                ),),
              if(cubit.profileImage!=null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:ConditionalBuilder(
                    condition: state is! UpdatePhotoLoadingState,
                    fallback: (context)=>CupertinoActivityIndicator(),
                    builder: (context)=> DefaultButton(
                        text: tr('send'),
                        onTap: (){
                          cubit.updateProfileImage(context);
                        }
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}


class ImageButtom extends StatelessWidget {
  ImageButtom({
    this.onTap,
    required this.title,
    required this.image
  });

  VoidCallback? onTap;
  String image;
  String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(3),
            color: Colors.white
        ),
        alignment: AlignmentDirectional.center,
        padding:const  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Row(
          children: [
            Image.asset(image,color: HexColor('#5791BC'),width: 20,),
            const SizedBox(width: 5,),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,fontSize: 12,color: HexColor('#5791BC')
              ),
            ),
          ],
        ),
      ),
    );
  }
}

