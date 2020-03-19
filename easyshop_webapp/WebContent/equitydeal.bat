@echo off
rmdir /S /Q publish
dir .\ & timeout /t 2 & dir .\
mkdir publish
cd .\publish

SET SERIVCE_PATH=D:\STSWORKSPACE\easyshop_service\build\classes
set DOMAIN_JAR_NAME=easyshop_service_domain.jar

xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\pojo\* 					cn\finedo\easyshop\pojo\



xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopconsult\domain\* 					cn\finedo\easyshop\service\easyshopconsult\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopexpress\domain\* 					cn\finedo\easyshop\service\easyshopexpress\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopgoods\domain\* 					cn\finedo\easyshop\service\easyshopgoods\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopgoodstype\domain\* 					cn\finedo\easyshop\service\easyshopgoodstype\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopnews\domain\* 					cn\finedo\easyshop\service\easyshopnews\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshoporder\domain\* 					cn\finedo\easyshop\service\easyshoporder\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopordergoods\domain\* 					cn\finedo\easyshop\service\easyshopordergoods\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopuser\domain\* 					cn\finedo\easyshop\service\easyshopuser\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\ordertrace\domain\* 					cn\finedo\easyshop\service\ordertrace\domain\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopaddress\domain\* 					cn\finedo\easyshop\service\easyshopaddress\domain\


xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopconsult\*Proxy*.class 			cn\finedo\easyshop\service\easyshopconsult\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopexpress\*Proxy*.class 			cn\finedo\easyshop\service\easyshopexpress\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopgoods\*Proxy*.class 			cn\finedo\easyshop\service\easyshopgoods\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopgoodstype\*Proxy*.class 			cn\finedo\easyshop\service\easyshopgoodstype\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopnews\*Proxy*.class 			cn\finedo\easyshop\service\easyshopnews\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshoporder\*Proxy*.class 			cn\finedo\easyshop\service\easyshoporder\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopordergoods\*Proxy*.class 			cn\finedo\easyshop\service\easyshopordergoods\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopuser\*Proxy*.class 			cn\finedo\easyshop\service\easyshopuser\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\ordertrace\*Proxy*.class 			cn\finedo\easyshop\service\ordertrace\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\wxpay\*Proxy*.class 			cn\finedo\easyshop\service\wxpay\
xcopy /Y /S %SERIVCE_PATH%\cn\finedo\easyshop\service\easyshopaddress\*Proxy*.class 			cn\finedo\easyshop\service\easyshopaddress\

jar cvf %DOMAIN_JAR_NAME% cn

set TARGET_PATH=D:\STSWORKSPACE\easyshop_webapp\WebContent\WEB-INF\lib
xcopy /Y %DOMAIN_JAR_NAME% %TARGET_PATH%
cd ..
rmdir /S /Q publish
