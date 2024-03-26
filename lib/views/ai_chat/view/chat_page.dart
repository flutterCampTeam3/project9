import 'dart:ui';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/views/ai_chat/bloc/chat_gpt_bloc.dart';
import 'package:medicine_reminder_app/widgets/appBar_arrow_back.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatGptBloc>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [green, greenLight, white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: const [AppBarArrowBack()],
            automaticallyImplyLeading: false),
        body: BlocBuilder<ChatGptBloc, ChatGptState>(
          builder: (context, state) {
            return DashChat(
              messageOptions: MessageOptions(
                
                showCurrentUserAvatar: true,
                avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
                  return Padding(
                      padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      p0.profileImage ?? 'assets/images/avatar.PNG',
                      height: 50,
                      width: 50,
                    ),
                  );
                },
              messageTextBuilder: (message, previousMessage, nextMessage) {
                return
                Text(
                  message.text,
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600), 
                );
              },
                
                currentUserContainerColor: const Color(0xffF8F8F6),
                currentUserTextColor: Colors.black54,
                
                borderRadius: 18,
                containerColor: const Color(0xffF8F8F6),
                textColor: Colors.black54,
                
                showTime: true,
               
               
                 
              ),
              
              typingUsers: bloc.typingList,
              currentUser: bloc.user,
              inputOptions: InputOptions(
                  inputTextStyle:const TextStyle(fontWeight: FontWeight.w600,) ,
                    inputTextDirection: TextDirection.rtl,
                inputDecoration: InputDecoration(
                  
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)
                      )
                      ),
                  fillColor: Colors.white,
                  hintTextDirection: TextDirection.rtl,
                  hintText: "اكتب هنا",
                  border: OutlineInputBorder(
                    
                      borderSide: BorderSide(color: grayLight),
                      
                        borderRadius: const BorderRadius.all(Radius.circular(10)
                      )
                      ),
                      
                ),
                
              ),
             
              onSend: (ChatMessage chatMessage) async {
                
                bloc.add(SendMessageEvent(chatMessage: chatMessage));
              },
              messages: bloc.messages,
            );
          },
        ),
      ),
    );
  }
}
