import 'package:flutter/material.dart';

<<<<<<< HEAD

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

=======
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
>>>>>>> add-features.raihan
    TextEditingController names = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Stack(children: <Widget>[
<<<<<<< HEAD
              Container(
                margin: EdgeInsets.only(top: 80.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
=======
            Container(
              margin: EdgeInsets.only(top: 80.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
>>>>>>> add-features.raihan
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
<<<<<<< HEAD
                child: Column(
                  children: <Widget>[
                  SizedBox(
                    height: 80.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 40.0,left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
=======
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
>>>>>>> add-features.raihan
                        TextField(
                          controller: names,
                          decoration: InputDecoration(
                            labelText: 'Names',
                            prefixIcon: Icon(Icons.person),
                            border: myInputBorder(),
                            enabledBorder: myInputBorder(),
                            focusedBorder: myFocusBorder(),
                          ),
                        ),
<<<<<<< HEAD
                        SizedBox(height: 20.0,),
=======
                        SizedBox(
                          height: 20.0,
                        ),
>>>>>>> add-features.raihan
                        TextField(
                          controller: username,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.people),
                            border: myInputBorder(),
                            enabledBorder: myInputBorder(),
                            focusedBorder: myFocusBorder(),
                          ),
                        ),
<<<<<<< HEAD
                        SizedBox(height: 20.0,),
=======
                        SizedBox(
                          height: 20.0,
                        ),
>>>>>>> add-features.raihan
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: myInputBorder(),
                            enabledBorder: myInputBorder(),
                            focusedBorder: myFocusBorder(),
                          ),
                        ),
<<<<<<< HEAD
                        SizedBox(height: 20.0,),
=======
                        SizedBox(
                          height: 20.0,
                        ),
>>>>>>> add-features.raihan
                        TextField(
                          controller: password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.password),
                            border: myInputBorder(),
                            enabledBorder: myInputBorder(),
                            focusedBorder: myFocusBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
<<<<<<< HEAD
                          onPressed: () {}, 
=======
                          onPressed: () {},
>>>>>>> add-features.raihan
                          child: Text('Update'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: EdgeInsets.symmetric(
<<<<<<< HEAD
                                  horizontal: 25.0,vertical: 20.0),
                              textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                      ],
                      ),
                    )
                ],),
              ), 
              Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      'images/polije.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 15.5,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,shape: BoxShape.circle
                      ),
                      child: Icon(Icons.edit,size: 30.0,)),
                  )
                  ],
                ),
=======
                                  horizontal: 25.0, vertical: 20.0),
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
>>>>>>> add-features.raihan
            ),
          ]),
        ),
      ),
    );
<<<<<<< HEAD
       
  }
  OutlineInputBorder myInputBorder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black,
        width: 3,
        ) );
  }
  OutlineInputBorder myFocusBorder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color(0xffcbf49),
        width: 3,
        ) );
  }
}
=======
  }

  OutlineInputBorder myInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        ));
  }

  OutlineInputBorder myFocusBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color(0xffcbf49),
          width: 3,
        ));
  }
}
>>>>>>> add-features.raihan
