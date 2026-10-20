import 'package:example_dart/UI/User/ViewModels/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class Loginviewwidget  extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //1. Khai báo FormKey để truy xuất vào form
    var _formKey=GlobalKey<FormState>();
    var _userName=TextEditingController();
    var _passWord=TextEditingController();
    var userViewModel=ref.read(userViewModelProvider.notifier);
    return Form(
      key: _formKey, //Gán Global key cho form
      child:
    Column(
      children: [
        TextFormField(
          validator: (value){
            var v=value??'';
            if (v.isEmpty)
               return 'User is required';
            else return null;},

          controller: _userName,
          decoration: InputDecoration(
            label: Text("Enter user name")),),
        SizedBox( height: 12,),
        TextFormField(
          controller: _passWord,
          validator: (value){
            var v=value??'';
            if (v.isEmpty)
              return 'Password is required';
            else return null;},
          decoration: InputDecoration(
              label: Text("Enter pass word")),),
        Row(
          children: [
            ElevatedButton(onPressed:(){}, 
                child: Text("Cancel")),
            ElevatedButton(onPressed: ()
            {
              if (_formKey.currentState!.validate())
                {
                 // _userName.text
                  //Login
                 var user=  userViewModel.Login(_userName.text, _passWord.text);
                 if (user!=null) //Login thành công
                   {

                 }
                 else
                   {

                   }//Thông báo lỗi
                }
            },
                child: Text("Login")
            )
          ],
        )
      ],
    ),
    );
  }
}
