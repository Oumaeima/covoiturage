import 'package:flutter/material.dart';

class NavBarPassenger extends StatelessWidget {
  const NavBarPassenger({Key? key}) : super(key: key);

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
                    onPressed: (){},
                    backgroundColor: const Color(0xFF4BE3B0),
                    child: Image.asset("lib/assets/utilisateur.png", width: 60, height: 30, alignment: Alignment.topCenter),
                    elevation: 0.1,
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
                            Navigator.pushNamed(context, "groupsClient");
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
