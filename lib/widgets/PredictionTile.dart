import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:satco_app/brand_colors.dart';
import 'package:satco_app/datamodels/address.dart';
import 'package:satco_app/datamodels/prediction.dart';
import 'package:satco_app/dataprovider/appdata.dart';
import 'package:satco_app/globalvariable.dart';
import 'package:satco_app/helpers/requesthelper.dart';
import 'package:satco_app/widgets/ProgressDialog.dart';

class PredictionTile extends StatelessWidget {

  final Prediction prediction;
  PredictionTile({this.prediction});

  void getPlaceDetails(String placeID, context) async {
    

    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(status: 'Please Wait...',)
    );

    String url = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$mapKey';

    var response = await RequestHelper.getRequst(url);

    Navigator.pop(context);

    if(response == 'failed'){
      return;
    }

    if(response['status'] == 'OK'){

      Address thisPlace = Address();
      thisPlace.placeName = response ['result']['name'];
      thisPlace.placeId=placeID;
      thisPlace.latitude = response ['result']['geometry']['location']['lat'];
      thisPlace.longitude = response ['result']['geometry']['location']['lng'];
      
      Provider.of<AppData>(context, listen: false).updateDestinationAddress(thisPlace);
      print(thisPlace.placeName);

      Navigator.pop(context, 'getDirection');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
          getPlaceDetails(prediction.placeId, context);
      },
      padding: EdgeInsets.all(0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 8,),
            Row(
              children: <Widget>[
                Icon(OMIcons.locationOn, color: BrandColors.colorDimText,),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(prediction.mainText, overflow: TextOverflow.ellipsis,  style: TextStyle(fontSize: 16),),
                      SizedBox(height: 2,),
                      Text(prediction.secondaryText??'', style: TextStyle(fontSize: 12, color: BrandColors.colorDimText),),
                      // Text(prediction.secondaryText, style: TextStyle(fontSize: 12, color: BrandColors.colorDimText),),

                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}
