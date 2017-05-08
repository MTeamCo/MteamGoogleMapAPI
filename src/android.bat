set adt="E:\AIRSDK_26\bin\adt.bat"

rem this is for debugging V
set adl="E:\AIRSDK_26\bin\adl.exe"

copy "AppIconsForPublishAndroid\*" "AppIconsForPublish\*"


set name=googleMap


set contents=AppIconsForPublish Data
rem "AppIconsForPublish"
set ios_contents=Default-568h-Portrait@2x.png Default-Portrait.png
rem set ios_contents=Default-568h@2x.png Default-Landscape.png

set android_certificate=D:\kheshti\project\Certificates\MTeam Certifications\MTeam Certification File.p12
set android_pass=NewPass123$
rem set android_target=apk-captive-runtime
set android_target=apk-debug -connect 192.168.0.21




set native_folder=-extdir "extension"
set dAA3=1024x768:1024x768
rem debugger V
rem %adl% -profile mobileDevice -screensize %dAA3% "%name%-app.xml"



rem 

rem android export V
%adt% -package -target %android_target% %ios_useLegacy% -storetype pkcs12 -storepass %android_pass% -keystore "%android_certificate%" "%name%.apk" "%name%-app-Android.xml" "%name%.swf" %contents% %native_folder%
