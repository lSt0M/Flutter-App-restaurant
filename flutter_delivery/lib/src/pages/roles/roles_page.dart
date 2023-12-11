import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/models/rol.dart';
import 'package:flutter_delivery/src/pages/roles/roles_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

class RolesPages extends StatefulWidget {
  const RolesPages({Key key}) : super(key: key);

  @override
  State<RolesPages> createState() => _RolesPagesState();
}

class _RolesPagesState extends State<RolesPages> {

  RolesController _con = new RolesController();

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
        backgroundColor: MyColors.primaryColor,
        title: Text('Selecciona un rol'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        child: ListView(
          children: _con.user != null ? _con.user.roles.map((Rol rol) {
            return _carRol(rol);
          }).toList() : []
        ),
      ),
    );
  }

  Widget _carRol(Rol rol){
    return GestureDetector(
      onTap: (){
        _con.goToPage(rol.route);
      },
      child: Column(
        children: [
          Container(
            height: 100,
            child: FadeInImage(
              image: rol.image != null
                  ? NetworkImage(rol.image)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          SizedBox(height: 15,),
          Text(
              rol.name ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
          ),
          SizedBox(height: 25,),
        ],
      ),
    );
  }

  void refresh(){
    setState(() {});
  }

}
