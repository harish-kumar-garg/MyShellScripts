#!bin/sh
curl -X POST https://login.windows.net/85c997b9-f494-46b3-a11d-772983cf6f11/oauth2/token  \
  -F redirect_uri=http://localhost \
  -F grant_type=authorization_code \
  -F resource=https://management.core.windows.net/ \
  -F client_id=1f7ba90d-f0d3-4a3e-954d-4817448d93ed \
  -F code=AAABAAAA0TWEUN3YUUq5vuCvmnaQiZRgyIoV6glw7JCEsi_gvx2OTmjDN1ZJ7xr8ab8efNjpoWNwKh1gH_cRcENEScZKq-pb2rooYaIjAQ9b2A04zS2TLpQi9x3Y3-BFQc2M1Ajr-EfNUnTn6bRvZUAnH60ZF37BaN3XJZFT5TkEshNMJxwvAx9opPOJKap0gKrWP5D5Qc_F54kIA1AUa6jZaYEfpcmqDK9znVwsSoSz1Gkz9Ay0t3Y8sN8Cr06gBKS9aExaxLuKDbsM-xBoV7l4zWypYyzXt-2psynqKIg-BBkZ8qjypHFaPTz7s_ReIgbdgIEhmVCOGZN5Iw84_HvHybRsZ5CNi8vKb-QpPS7VUkL4DEbQLZN-4eAcw-jlSU4QCmEF2uc-lRGt11HerRcuZhhKbWGXrhOO_OmNidZiPr8ADqQp2q271uSEr9W2MLvaQfR3CwJOr6dYwaMj-iAMquJaMg76BkWUgddEkoWhRmquyhcOfgMAJx5qJNLJ8oZiTsZxNXvIPkFt5kOunO86l8AibC33BdxEhahMgoVGwxyJHZRRWXhYLPy6Qh-potQ0zYPqVeTxVye5svYmYVfeNgTmzdrM7goJwinTuCg1uOWk58iHLaMDnbBCQwQsHD5eeSaeV70yN8Qwhbba89QWLXczlR2g_nZrQfalImremCwqOqdCHn25CJ2mg_R709KEPmk2WUKe9jwWnPgHWfeHqNHHM0b7dRwS_4VVMBX5JQ8czzn5hdsmzRvDeDFg4msQ5iDGgZe1Rmegx5WK-QspU_UNr9ssc0qpt3sK5R8dJVMBdOggAA > tokens.json
TOKEN="$(cat tokens.json | jq '.access_token')"
token1="$({TOKEN:1:-1})"
curl -v https://management.azure.com/subscriptions/c8947205-1040-4fc4-b494-c3b3136166c0/resourceGroups?api-version=2014-04-01 \
  -H "x-ms-version: 2013-08-01" \
  -H "Content-Type:application/json" \
  -H "Authorization: Bearer ${token1}" > rgNames.json
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
