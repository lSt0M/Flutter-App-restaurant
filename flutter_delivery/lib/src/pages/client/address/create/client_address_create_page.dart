import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';


class ClientAddressCreatetPage extends StatefulWidget {
  const ClientAddressCreatetPage({Key key}) : super(key: key);

  @override
  State<ClientAddressCreatetPage> createState() => _ClientAddressCreatetPageState();
}

class _ClientAddressCreatetPageState extends State<ClientAddressCreatetPage> {

  ClientAddressCreateController _con = new ClientAddressCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva direccion'),
        backgroundColor: MyColors.primaryColor,
      ),
      bottomNavigationBar: _buttonAccept(),
      body: Column(
        children: [
          _textCompleteData(),
          _textFieldAddress(),
          _textFieldNeighborhood(),
          _textFieldRefPoint()
        ],
      ),
    );
  }

  Widget _textCompleteData() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Completa estos datos',
        style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _textFieldAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.addressController,
        decoration: InputDecoration(
          labelText: 'Barrio',
          suffixIcon: Icon(
            Icons.location_on,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }

  Widget _textFieldRefPoint() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.refPointController,
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
            labelText: 'Punto de referencia',
            suffixIcon: Icon(
              Icons.map,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldNeighborhood() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.neighborhoodController,
        decoration: InputDecoration(
            labelText: 'Avenida',
            suffixIcon: Icon(
              Icons.location_city,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }


  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        onPressed: _con.createAddress,
        child: Text(
            'CREAR DIRECCIÓN'
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            primary: MyColors.primaryColor
        ),
      ),
    );
  }

  void refresh(){
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}



//1
//AIzaSyB5QIOsaQUaCBBwqiwroYKh27aYG9ivOiI
//2
//AIzaSyCa6O7EQB0ka5MgfpmIvgUOzAswMCOtXKw