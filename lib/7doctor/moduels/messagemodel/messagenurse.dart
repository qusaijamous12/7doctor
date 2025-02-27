import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/usermodel.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../chatModel/chatScreen.dart';

class MessageNurseScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorState>(
      listener: (context,DoctorState){
      },
      builder: (context,DoctorState){
        DoctorCubit cubit=DoctorCubit.get(context);
        var modell=DoctorCubit.get(context).model;
        return   Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.blue[800],
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.blue[800]
              ),
            ),
            body: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.topStart,
                  padding: EdgeInsetsDirectional.only(
                      start: 20
                  ),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(20),
                          bottomStart:Radius.circular(20)
                      )
                  ),
                  child: Text(
                    'Chat And Communicate Now \n With The Best Doctor In The World..',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ConditionalBuilder(
                  condition:modell!.status=='user',
                  builder:(context)=>Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder:(context,index)=> buildChatItem(context,DoctorCubit.get(context).nurses[index]),
                        separatorBuilder: (context,index)=>Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 20
                          ),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                        ),
                        itemCount: DoctorCubit.get(context).nurses.length),
                  ),
                  fallback:(context)=>Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder:(context,index)=> buildChatItem(context,DoctorCubit.get(context).users[index]),
                        separatorBuilder: (context,index)=>Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 20
                          ),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                        ),
                        itemCount: DoctorCubit.get(context).users.length),
                  ),
                ),
              ],
            )


        );
      },

    );

  }
  Widget buildChatItem(context,userModel model)=>InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(usermodel: model,)));


    },
    child: Container(
      color: Colors.white,

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:NetworkImage(
                  '${model.image}'
              ),
              radius: 50,
            ),
            SizedBox(
              width:10 ,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Colors.blue[800],
              radius: 7,
            )
          ],
        ),
      ),
    ),
  );

}