import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:prism_medico/model/latestProduct.dart';

enum defaultaddress { yes, no }

class Add_Address extends StatefulWidget {
  final List<Latest_Product_model> cart;

  Add_Address({this.cart});
  _AddAddressState createState() => _AddAddressState(this.cart);
}

class _AddAddressState extends State<Add_Address> {
  _AddAddressState(this.cart);
  List<Latest_Product_model> cart;
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              "Add Address",
              style: TextStyle(
                  fontFamily: "Poppins-Semibold",
                  fontSize: 20,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            CustomBGWidget(),
            Form(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          border: Border.all(color: Colors.grey)),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4),
                      child: TextFormField(
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: "Enter Address",
                            // prefixIcon: icon,
                            labelStyle: new TextStyle(
                              color: Colors.grey,
                              fontFamily: "Poppins-Regular",
                              fontSize: 12,
                            ),
                            border: InputBorder.none),
                        // controller: controller,
                        keyboardType: TextInputType.multiline,
                        // validator: validator,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: CustomTextFieldWidget(
                            labelText: "City",
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: CustomTextFieldWidget(
                            labelText: "District",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: CustomTextFieldWidget(
                            labelText: "Pincode",
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: CustomTextFieldWidget(
                            labelText: "State",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _value = !_value;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                              child: _value
                                  ? Icon(
                                      Icons.circle,
                                      size: 20.0,
                                      color: Colors.blue.shade200,
                                    )
                                  : Icon(
                                      Icons.circle,
                                      size: 20.0,
                                      color: Colors.white,
                                    )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Make deafult address",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: "Poppins-Regular",
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    FlatButton(
                      // height: ,
                      minWidth: MediaQuery.of(context).size.width / 3,
                      padding: EdgeInsets.all(10),
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        //side: BorderSide(color: Colors.red)
                      )),
                      textColor: Colors.white,
                      color: MyColors.themecolor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homepage(
                                cart: cart,
                              ),
                            ));
                        setState(() {
                          // istapped = 'Button tapped';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins-Semibold",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
