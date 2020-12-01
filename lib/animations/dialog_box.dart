import 'package:dakota/animations/sizeconfig.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String title, description, buttonText;
  final String image;
  final GestureTapCallback onPressed;
  DialogBox({this.title,this.description,this.buttonText,this.image, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),

    );
  }
  dialogContent(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(
                top: 100,
                bottom: 16,
                left: 16,
                right: 16
            ),
            margin: EdgeInsets.only(top:16),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0,10.0),
                  )
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height:24.0),
                Text(description, style: TextStyle(fontSize: 16)),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      onPressed();
                    },
                    child: Text(buttonText),
                  ),
                )

              ],
            )
        ),
        Container(
          child: Positioned(
              top: -20,
              left: 20,
              right: 20,
              child: ClipOval(
                child: Container(
                    width: SizeConfig.widthMultiplier * 35,
                    height: SizeConfig.widthMultiplier * 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth)
                    ),
                  ),
              ),
          ),
        )],
    );
  }
}
