

import 'package:cached_network_image/cached_network_image.dart';
import 'package:faysal/pages/account/widget/edit_textfield.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/utils/constants.dart';

import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController numberController;
  late ProfileProvider provider;
  bool isLoading = false;


  @override
  void initState() {
    provider = Provider.of<ProfileProvider>(context,listen: false);
    
    idController = TextEditingController(text: provider.userProfile.id.toString());
    nameController = TextEditingController(text: provider.userProfile.name);
    emailController = TextEditingController(text: provider.userProfile.email);
    numberController = TextEditingController(text: provider.userProfile.phone);

    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    emailController.dispose();
    numberController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Scaffold(
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: WidgetBackgorund(
            home: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24),
              child:Column(
                children: [
                  const CustomNavBar(header: "Edit Profile"),
                  Expanded(child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: ()async{
                              setState(() {
                                isLoading = true;
                              });
                              await provider.updatePics(context);
                              setState(() {
                                isLoading = false;
                              });
                             
                            },
                            child: ClipPath(
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Container(
                                                        width: size.width * 0.26 < 76
                                    ? 76
                                    : size.width * 0.26 > 99
                                        ? 99
                                        : size.width * 0.26,
                                                        height: size.width * 0.26,
                                                        margin: EdgeInsets.only(top: size.height * 0.03),
                                                        decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: provider.userProfile.avatar.isEmpty? DecorationImage(
                                        image: AssetImage("assets/avatar/avatar${generateAvatar(provider.userProfile.id.toString())}.png")):DecorationImage(
                                        image: CachedNetworkImageProvider("$imageUrl/${provider.userProfile.avatar}",cacheKey: provider.cacheKey),fit: BoxFit.cover)),
                                        child: isLoading?ConstrainedBox(constraints: const BoxConstraints(maxHeight: 23,maxWidth: 23),child: CircularProgressIndicator(color: MyFaysalTheme.of(context).accentColor),):Container(
                                                        height: 20,
                                                        alignment: Alignment.center,
                                                        width: 100,
                                                        decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Color.fromARGB(62, 0, 0, 0),
                                                        ),
                                                        child: Icon(Icons.camera_alt,color: Colors.white.withOpacity(0.5),),
                                                        
                                                      ),
                                                      ),
                                                      
                                ],
                              
                              ),
                            ),
                          ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.05),
                        child: Wrap(
                          runSpacing: 20,
                          children: [
                            // EditProfileTextField(controller: idController, label: "Faysal ID", isVerified: true),
                        EditProfileTextField(controller: nameController, label: "Name", isVerified: false),
                        EditProfileTextField(controller: emailController, label: "Email", isVerified: false),
                        EditProfileTextField(controller: numberController, label: "Phone Number", isVerified: false),
                          ],
                        ),
                      ),
          
                      Padding(
                        padding: const EdgeInsets.only(top:6.0),
                        child: Row(
                          children: [
                            Icon(Icons.info_outlined,color: MyFaysalTheme.of(context).primaryColor.withOpacity(0.2),size: size.width * 0.04,),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text("To change these details, please contact support@fasyal.website", style: MyFaysalTheme.of(context).promtHeaderText.override(color: MyFaysalTheme.of(context).primaryColor.withOpacity(0.2),fontSize: size.width * 0.025),),
                            )
                          ],
                        ),
                      ),
          
          
                      // Padding(
                      //   padding: EdgeInsets.only(top: size.height * 0.15),
                      //   child: SavingsButton(text: "Update", call: (){}),
                      // )
          
          
                      
                      
          
          
          
                        ],
                      ),
                    ),
                  ))
                ],
              )
            ),
          
          ),
        ),
      ),
    );
  }
}