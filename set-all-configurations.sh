#/bin/bash
configDirectory=$PWD
if [ -z "$1" ]
  then
	echo "No config directory supplied. Assuming '" $configDirectory "' as config directory."
  else
    configDirectory=$1
fi

# Update all instances of local dir with docker image directories for all config/contrib entries
sed -i -e 's|TKW_ROOT/|/home/service/TKW/|g' ${configDirectory}/tkw-x_mth_server.properties

# Update all output directories with docker image volume directories
sed -i -e "/^tks.evidencemetadata.location/c\tks.evidencemetadata.location /home/service/data/logs" ${configDirectory}/tkw-x_mth_server.properties
sed -i -e "/^tks.validator.reports/c\tks.validator.reports /home/service/data/validator_reports" ${configDirectory}/tkw-x_mth_server.properties
sed -i -e "/^tks.logdir/c\tks.logdir /home/service/data/logs" ${configDirectory}/tkw-x_mth_server.properties
sed -i -e "/^tks.savedmessages/c\tks.savedmessages /home/service/data/simulator_saved_messages" ${configDirectory}/tkw-x_mth_server.properties
sed -i -e "/^tks.sender.destination/c\tks.sender.destination /home/service/data/transmitter_sent_messages" ${configDirectory}/tkw-x_mth_server.properties
sed -i -e "/^tks.spine.sds.reference/c\tks.spine.sds.reference /home/service/external_configuration/siab-test-sds-ref_AutoTester.xml" ${configDirectory}/tkw-x_mth_server.properties

# Update Simulator ruleset with docker image directories
#sed -i -e 's|TKW_ROOT/config/SPINE_MTH_EPS_Dispenser_Simulator/external_configuration/EPSMessageTemplates/|/home/service/external_configuration/EPSMessageTemplates/|g' ${configDirectory}/simulator_config/EPS_Dispenser_AutoTest_interceptor_Ruleset.txt
sed -i -e 's|TKW_ROOT/|/home/service/TKW/|g' ${configDirectory}/simulator_config/SCR_Ruleset.txt
# Update Validator ruleset with docker image directories
sed -i -e 's|TKW_ROOT/|/home/service/TKW/|g' ${configDirectory}/validator_config/Config_SCR.conf
