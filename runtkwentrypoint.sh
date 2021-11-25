#Report the version numbers
if [[ -e /home/service/TKW/config/SPINE_MTH_SCR_Simulator/version_string.txt ]]
then
	cat /home/service/TKW/config/SPINE_MTH_SCR_Simulator/version_string.txt
fi
java -jar /home/service/TKW/TKW-x.jar -version | grep -v "starting on"

if [ "$1" == '--version' ]
then
	exit 0
fi

echo "Running as UID $UID"
echo "trustStore = " $trustStore
echo "trustStorePassword = " $trustStorePassword
echo "keyStore = " $keyStore
echo "keyStorePassword = " $keyStorePassword
echo "serverAsid = " $serverAsid
echo "serverCPAID = " $serverCPAID
echo "Making sure output structure is available"

cd /home/service/data
tar -xvf /home/service/TKW/config/SPINE_MTH_SCR_Simulator/tkwoutputstructure.tar
cd /home/service
# decide whether its TLSMA or not


if [ "$trustStore" == 'default' ]
then
	#ClearText
	java -version
	java -XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -Dtks.spine.my.asid=$serverAsid -Dtks.spine.my.ack.cpaid=$serverCPAID -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/SPINE_MTH_SCR_Simulator/tkw-x_mth_server.properties
else
	#TLSMA
	java -Djavax.net.ssl.trustStore=$trustStore -Djavax.net.ssl.trustStorePassword=$trustStorePassword -Djavax.net.ssl.keyStore=$keyStore -Djavax.net.ssl.keyStorePassword=$keyStorePassword -Dtks.spine.my.asid=$serverAsid -Dtks.spine.my.ack.cpaid=$serverCPAID -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/SPINE_MTH_SCR_Simulator/tkw-x_mth_server.properties
fi
