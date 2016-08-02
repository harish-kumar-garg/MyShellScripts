#!bin/sh
curl -X POST https://login.windows.net/85c997b9-f494-46b3-a11d-772983cf6f11/oauth2/token  \
  -F redirect_uri=http://localhost \
  -F grant_type=authorization_code \
  -F resource=https://management.core.windows.net/ \
  -F client_id=e266794f-9647-4354-8284-0e5806d00a39 \
  -F code=AAABAAAA0TWEUN3YUUq5vuCvmnaQiYDgxBdrKBt0isHfXZobrPLWtUTn1dCLCDivLot5q8NSDb_7-M2n1WFA1ZhUMLu-57e0sG-xP6nxdpzXis7hVGyObmINXRg8FhF9RPN5kw6YV8j0MTtqhjIQ8S69rXQ0xLozt_xVB4DFJsDsi4hKYr16IWE6JTLQ_O8_U3Wov6QzvR6xtRjWiJu5ZLMoakohffG95pL1bq9BUkomNBSY_YiGad4lyR82Hv5x2zms48_XMIt7laqDwkMn3A28do1gvr1U7L9TVoWcZRVIgbCdBzmsy_EtRKr4PKiMj16cqOMlflwQnA2Bg-LaxnUw_TeuoSaosQHDSfkFU2cp6QKK8t70f25V-zsHSApyOh9Sj6BjOjPUU-qL8ILKNKELErewCBBwqngVY1327KlZYPwu_h6MgqW5o7KD9p2zwLbmv3eM1qkmbSkQa5Xe3ltLOFDydvpqVs0z7hr7z9nE3ZohMtAVIR6tmzRNepXDZdil3pikrwRzJvUwBCY3sLa40BH1v51k0vrC03eNlwCW9V0dD7QObfLnSYOeqqeTyh4KNAYniB9ZiNEnMI1ojjjc6mR9axnCJ54o2iv0JSsx6dkgjxX8MrX8QDsf6pMmAMZcUVO4rltybO4smCG1i7qvB7hTlfrP4ppXNgbCHldJxCcoY_TOMEf3e7yoECCCw5sA8iG0_vW8whI_OSV23vVoDuj-AMGXfYDEMtwdXIS4ZEc6Gw2H4zVkGhLmOS9D7KMvYQi0ghAsVTKrwVNp5vGOvCIn6R6xBa87RiRWuvU4ifNyuOUgAA > tokens.json
TOKEN="$(cat tokens.json | jq '.access_token')"
token1="${TOKEN:1:-1}"
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
