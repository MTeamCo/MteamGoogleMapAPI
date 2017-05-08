set adt="E:\AIRSDK_26\bin\adt.bat"

rem this is for debugging V
set adl="E:\AIRSDK_26\bin\adl.exe"
copy "AppIconsForPublishIOS\*" "AppIconsForPublish\*"
set name=googleMap


set contents=AppIconsForPublish Data
rem "AppIconsForPublish"
set ios_contents=Default-568h-Portrait@2x.png Default-Portrait.png
rem set ios_contents=Default-568h@2x.png Default-Landscape.png
set ios_certificate=D:\kheshti\project\Certificates\MTeam Certifications\MTeam IOS Certificate_dev.p12
set ios_mobprevision=CarAccessoriesDev.mobileprovision

rem TaghvimAriyaDist.mobileprovision
set ios_pass=NewPass123$
set ios_targ=ipa-debug -connect 192.168.0.21
set ios_useLegacy=
rem -useLegacyAOT yes   -useLegacyAOT no
rem ipa-ad-hoc    ipa-app-store   ipa-debug -connect 192.168.0.15

set native_folder=-extdir "extension"
set dAA3=1024x768:1024x768
rem debugger V
rem %adl% -profile mobileDevice -screensize %dAA3% "%name%-app.xml"


rem IOS export V
%adt% -package -target %ios_targ% -keystore "%ios_certificate%" -storetype pkcs12 -storepass %ios_pass%  -provisioning-profile  "%ios_mobprevision%"  "%name%-dev-debug.ipa" "%name%-app-ios-dev.xml"  "%name%.swf"  %contents% %ios_contents% %native_folder%
