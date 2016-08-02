#!bin/sh
curl -X POST https://login.windows.net/85c997b9-f494-46b3-a11d-772983cf6f11/oauth2/token  \
  -F redirect_uri=http://localhost \
  -F grant_type=authorization_code \
  -F resource=https://management.core.windows.net/ \
  -F client_id=1f7ba90d-f0d3-4a3e-954d-4817448d93ed \
  -F code=AAABAAAA0TWEUN3YUUq5vuCvmnaQiej4w57MNwPuc0SvVY6SbAN7_zbTeh0ciOQ5aUa9ZPogxuc-buG-O5JBReEPrkre7D_fo1G8nxFPj-lvkYq4nbCkCuUf-vsN3VCNnNp_JTMZy2gk_B8YioyCQ5j59QbzrEw3qHPfOnaNTGUSzhZx04EfUWyWEfhEZiNAT4p5U7-ECQXloUhksSW9WWEKlQCLOzdYF7uS6y2qdaeWzmQOsa7sJ9J9xlecBoRWaT0tAirSTaxQj_JLrQr0OsWyG8SsAa8rDL0rnLGNEUih4vvsuhrdSczFl-CPICHYbZgNMuaPbrbBPakGzxvRblm-znmT0YDJys5j8obkBEMkNorBalZWV8f9yXkybOEEwJ7Fa8ssz_w4Lm6pAsK6Oh_qZKAyIk38uE6sRBmA8ds0Fi57jXKvqKT7ZYstfeiGHzkuTpEmaf6zNgeTCi5xhZjaaOljKwb_HMQSJXcG18NTmB1T6lgv6gcdpW11nC_BCK0G1QlwDyXrb8RtoTfCtsdGGnF1o6Mj1xzTKzyy_JzQgvPmcmoT6R3ak-b-MM3h_RZ3XHcvdf_gQKNfjIPkpRM_bLSoacrVbRJ8lHQ8sCYwM1Zjz9V8FWmZCBbGty5102Bq_eJYz6N8YpuJr4BCqGP_WR8UAA-PevLugslfJaEyz3uwSmVGV-KWTspsMC_-DyqarLS34GeYV0OLG11CIsEacIh82tqWXr6haIKj_g1aZNHlCcfu10p_Wf-miJIdJmUxngWv4fhamDNRHP9wtFadHehYngtnIpPEReT6unNqgjX1PS0gAA > tokens.json
TOKEN="$(cat tokens.json | jq '.access_token')"
token1="$({TOKEN:1:-1})"
curl -v https://management.azure.com/subscriptions/c8947205-1040-4fc4-b494-c3b3136166c0/resourceGroups?api-version=2014-04-01 \
  -H "x-ms-version: 2013-08-01" \
  -H "Content-Type:application/json" \
  -H "Authorization: Bearer "${token1}"" > rgNames.json
#function definition
delete_resource_group() {
	echo 'Initializing...'
	I=0
	red=`tput setaf 1`
	green=`tput setaf 2`
	reset=`tput sgr0`
	NAME1='null'
	TOTAL_NUMBER_OF_RG=
	while [ "${I}" -ge 0 ]
	do
		NAME1="$(cat rgNames.json | jq .value[${I}].name)"
		if [ "${NAME1}" = 'null' ]; then
			break;
		else
			I=`expr $I + 1`;
		fi	
	done
	TOTAL_NUMBER_OF_RG=$I
	echo 'Total number of RG: '$TOTAL_NUMBER_OF_RG
	I=0
	#date is in format ddmmyyyy
	while [ "${I}" -lt "${TOTAL_NUMBER_OF_RG}" ]
	do
		NAME1="$(cat rgNames.json | jq .value[${I}].name)"
		if [ ${NAME1} = *"DND"* ]; then
				echo "${green}${NAME1}"' is not deleted'
				I=`expr $I + 1`
				echo $reset;
			else
				echo "${red}${NAME1}"' will be deleted'
				I=`expr $I + 1`
				echo $reset;
		fi
	done
}  
#calling function
delete_resource_group
