import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: 60,
            //color: Colors.black.withOpacity(0.1),
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPaint(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                    onPressed: (){
                      //Navigator.pushNamed(context, "add-group");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialog(context),
                      );
                    },
                    backgroundColor: Color(0xFF4BE3B0),
                    child: Icon(Icons.group_add), elevation: 0.1,
                  ),
                ),
                Container(
                  width: size.width,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.home, color: Colors.white,)
                      ),
                      IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, "profileC");
                          },
                          icon: Icon(Icons.group_rounded, color: Colors.white,)
                      ),
                      Container(width: size.width * 0.20,),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.message, color: Colors.white,)
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.notifications, color: Colors.white,)
                      ),
                    ],
                  ),

                )
              ],
            ),
          ),

        )
      ],
    );
  }
}

class BNBCustomPaint extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black.withOpacity(0.5)..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    //canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Add Group'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  <Widget>[
        Icon(Icons.do_not_disturb_on_total_silence_sharp, color: Color(0xFF4BE3B0),),
        TextField(

          //controller: permisController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Starting",
              hintStyle: TextStyle(fontSize: 15)
          ),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ButtonStyle(

        ),
        child: const Text('Close'),
      ),
    ],
  );
}
