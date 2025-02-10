import 'package:daily_wash/modules/widgets/home/order/receipt_widget.dart';
import 'package:daily_wash/modules/widgets/item_shared/screenshot_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../models/order_model.dart';
import '../../../../shared/images/images.dart';
import '../../item_shared/image_net.dart';

class ReceiptImageZoom extends StatefulWidget {
  ReceiptImageZoom(this.data,this.receipt);
  OrderData data;

  List<Receipt> receipt;

  @override
  State<ReceiptImageZoom> createState() => _ReceiptImageZoomState();
}

class _ReceiptImageZoomState extends State<ReceiptImageZoom> {
  bool showScreenShot = true;

  ScreenshotController screenshotController = ScreenshotController();

  void screenShot()async{
    showScreenShot = false;
    setState(() {});
    final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    await screenshotController.captureAndSave(
        '$directory',
    fileName:fileName
    ).then((value) {
      if(value!=null){
        showScreenShot = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(Images.receipt,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.data.providerName!.isNotEmpty?widget.data.providerName!:'no_name'.tr(),
                    style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.w600,
                      fontSize: 30
                    ),
                  ),
                  const Gap(30),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 30.0,bottom: 25),
                  //   child: Text(
                  //     'Cash receipt',
                  //     style: TextStyle(
                  //         color: Colors.black,fontSize: 20
                  //     ),
                  //   ),
                  // ),
                  // Text(
                  //   '3256222',
                  //   style: TextStyle(
                  //       color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset(Images.line,width: double.infinity),
                  ),
                  Row(
                    children: [
                      Text(
                        'description'.tr(),
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w600,fontSize: 25
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'price'.tr(),
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w600,fontSize: 25
                        ),
                      ),
                    ],
                  ),
                  ListView.separated(
                      itemBuilder:(c,i)=>itemBuilder(receipt: widget.receipt[i]),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                      itemCount: 3
                  ),
                  Row(
                    children: [
                      Text(
                        'total'.tr(),
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w600,fontSize: 25
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.data.totalPrice} AED',
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w600,fontSize: 25
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset(Images.line,width: double.infinity,),
                  ),
                  Row(
                    children: [
                      Text(
                        'payment_method'.tr(),
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w600,fontSize: 25
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.data.paymentMethod == 'online'?'Online':'cash'.tr(),
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w600,fontSize: 25
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  // if(showScreenShot)
                  // InkWell(
                  //   onTap: ()=>screenShot(),
                  //     child:ScreenShotWidget()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemBuilder({
    required Receipt receipt,
  }){
    return Row(
      children: [
        Expanded(
          child: Text(
            receipt.title.tr(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18
            ),
          ),
        ),
        const Gap(10),
        Text(
          '${receipt.value} AED',
          style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18
          ),
        ),
      ],
    );
  }
}
