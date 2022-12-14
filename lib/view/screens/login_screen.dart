import 'package:dialog_loader/dialog_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/api_helper.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/screens/feed_screen.dart';
import 'package:social_media/view/screens/forget_screen.dart';
import 'package:social_media/view/screens/register_Screen.dart';
import 'package:social_media/view/widgets/constans.dart';
import 'package:social_media/view/widgets/custem_appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvaider>(
      builder: (context,provider,x) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: provider.loginKey,
                child: Stack(
                  children: [

                    Column(
                      children: [
                        Stack(
                          children: [
                            CustemAppBar(),
                            SizedBox(
                              height: 200.h,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child:Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26.withOpacity(.1),
                                            offset: Offset(7,15),
                                            blurRadius: 10,
                                          )
                                        ]
                                    ),

                                    child: SvgPicture.asset('assets/images/logo.svg')),

                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30.h,),
                        Text(
                          'Hello again.\nWelcome back.',
                          style: TextStyle(
                            fontFamily: 'Montserrat-Medium',
                            fontSize: 18.sp,
                            color: const Color(0xb2161f3d),
                            height: 1.5.h,
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.h,),

                        Padding(

                          padding:  EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: provider.emailController,
                            validator: (x) => provider.emailvaliation(x!),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

                                labelText: 'EMAIL ADDRESS',
                              labelStyle: TextStyle(
                                fontFamily: 'Montserrat-Regular',
                                fontSize: 17.sp,
                                color:  Colors.blueGrey,
                                letterSpacing: 1,
                                height: 1,
                              ),
                              hintText: "Enter your email",
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat-Regular',
                                fontSize: 12.sp,
                                color: const Color(0x80161f3d),
                                letterSpacing: 1,
                                height: 1,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: Icon(Icons.email_outlined,size: 30.sp,),
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(color: Colors.black),
                                gapPadding: 3,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(color: Colors.black),
                                gapPadding: 3,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(color: Colors.grey),
                                gapPadding: 3,
                              ),
                              suffixIconColor: Colors.grey

                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(


                          padding:  EdgeInsets.only(left: 20,right: 20),
                          child: TextFormField(
                            controller: provider.passwordController,
                            validator: (x) => provider.passwrdvaliation(x!),
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat-Regular',
                                  fontSize: 17.sp,
                                  color:  Colors.blueGrey,
                                  letterSpacing: 1,
                                  height: 1,
                                ),
                                hintText: "Enter your Password",
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat-Regular',
                                  fontSize: 12.sp,
                                  color: const Color(0x80161f3d),
                                  letterSpacing: 1,
                                  height: 1,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                suffixIcon: Icon(Icons.password_outlined,size: 25.sp,),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(color: Colors.black),
                                  gapPadding: 3,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(color: Colors.black),
                                  gapPadding: 3,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(color: Colors.grey),
                                  gapPadding: 3,
                                ),
                                suffixIconColor: Colors.grey

                            ),
                          ),
                        ),
                        SizedBox(height: 13.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              onTap: (){
                                AppRouter.NavigateToWidget(ForgetScreen());
                              } ,
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(

                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h,),
                        InkWell(
                          onTap: ()async{
                            await provider.signIn();
                            await Provider.of<PostProvider>(AppRouter.navKey.currentContext!,listen: false).getAllPosts();
                            // AppRouter.NavigateWithReplacemtnToWidget(FeedScreen());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 315.w,
                            height: 52.h,
                            decoration: BoxDecoration(
                              color: Color(0xffE9446A),
                              borderRadius: BorderRadius.circular(5)

                            ),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontFamily: 'Montserrat-Medium',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffffffff),
                                letterSpacing: 0.5333333129882812,
                                height: 1.25,
                              ),
                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New to Friendly Desi?',
                              style: TextStyle(
                                fontFamily: 'Montserrat-Regular',
                                fontSize: 15.sp,
                                color: const Color(0x801d1d26),
                                letterSpacing: 0.4000000133514404,
                              ),
                              softWrap: false,
                            ),
                            InkWell(
                              onTap:(){
                                AppRouter.NavigateToWidget(RegisterScreen());
                                provider.passwordController.clear();
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-Regular',
                                  fontSize: 14.sp,
                                  color: const Color(0xffe9446a),
                                  letterSpacing: 0.4000000133514404,
                                ),
                                softWrap: false,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 139.h,
                          child: Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/Scroll Group 1.png")),
                        )






                      ],
                    ),
                    // (provider.isLoad)?SizedBox(
                    //   height: MediaQuery.of(context).size.height,
                    //   child: Center(
                    //     child: CircularProgressIndicator(
                    //       color: MainColor,
                    //     ),
                    //   ),
                    // ):SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

