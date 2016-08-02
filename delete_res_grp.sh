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
     -H "Content-Type:application/json" \
     -H "x-ms-version: 2013-08-01" \
     -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ik1uQ19WWmNBVGZNNXBPWWlKSE1iYTlnb0VLWSIsImtpZCI6Ik1uQ19WWmNBVGZNNXBPWWlKSE1iYTlnb0VLWSJ9.eyJhdWQiOiJodHRwczovL21hbmFnZW1lbnQuY29yZS53aW5kb3dzLm5ldC8iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC84NWM5OTdiOS1mNDk0LTQ2YjMtYTExZC03NzI5ODNjZjZmMTEvIiwiaWF0IjoxNDcwMTQxNTQ3LCJuYmYiOjE0NzAxNDE1NDcsImV4cCI6MTQ3MDE0NTQ0NywiYWNyIjoiMSIsImFtciI6WyJwd2QiXSwiYXBwaWQiOiJlMjY2Nzk0Zi05NjQ3LTQzNTQtODI4NC0wZTU4MDZkMDBhMzkiLCJhcHBpZGFjciI6IjAiLCJmYW1pbHlfbmFtZSI6IkJhcmRoYW4iLCJnaXZlbl9uYW1lIjoiQXJpaml0IiwiZ3JvdXBzIjpbImEwZDdkOGI0LTQxM2UtNGU3Ni1iYmUyLTU1MDVlOGFjZGEyNCIsIjUxN2YzZjQyLTYyOWYtNDZjZC04MGE3LTgzNzlmY2YyODE2OCIsImQ3Y2EyNjUwLWIzNTctNDNkNi1hMzg2LWU4YjZkMWExYWViMiIsIjMxYTZlYWJlLTNhOTctNGQ2OS05M2ZjLWJhYjgwYjY4MzQyYyIsIjMzZTVlZTllLTYzYzYtNGVmNC1iMDdjLTI3OTNlZWFjN2QyNSIsIjMxMmY4ZmU2LWRlNjUtNDZhNC1iODIyLTA0YWE1Yzc4YTczZSIsImFmYjExODU3LWUzZDgtNDk2Yy04MjcyLTFhMGRiMGI2MTk3NSIsIjRiMTdhM2QzLWZiYzctNDU2My05NmY0LTQ0NWQ4YmU5ZDc4MSIsImVkNjM2MzBiLTM0ZjAtNDMxZi05N2U0LWRiMzA3NTQyNTc1ZCIsIjM4MGM4M2JhLTgxMjUtNDNhZS04NzM4LThlZjU0YzEzYmJiMCJdLCJpcGFkZHIiOiIxMy43Ni45My4yMiIsIm5hbWUiOiJBcmlqaXQgQmFyZGhhbiIsIm9pZCI6IjNlYzAxZWQzLTliODYtNGIwYi1iMWRlLTBkNDg4MjVmMTM5NCIsIm9ucHJlbV9zaWQiOiJTLTEtNS0yMS00NDg1Mzk3MjMtNzQ2MTM3MDY3LTE4MDE2NzQ1MzEtMjc2NzYxIiwicHVpZCI6IjEwMDNCRkZEOTI1NkExRTUiLCJzY3AiOiJ1c2VyX2ltcGVyc29uYXRpb24iLCJzdWIiOiJDcjBrUkJFeVBFUS1GMEZ2b3pHMmxMTFk1eU9DSzVNQ1hFMjg4VGEtQk1jIiwidGlkIjoiODVjOTk3YjktZjQ5NC00NmIzLWExMWQtNzcyOTgzY2Y2ZjExIiwidW5pcXVlX25hbWUiOiJNMTAzMjMzN0BtaW5kdHJlZS5jb20iLCJ1cG4iOiJNMTAzMjMzN0BtaW5kdHJlZS5jb20iLCJ2ZXIiOiIxLjAifQ.W6YOEgrGcLKD51qjeIh8A0--W76iyfqwN4YMk_MCwcXDW10qHaKtrxGGcvoa5EsYG6_V8k8aY-GzAaB6k4TkmNniMGKXVIGEl4xo9GkY2pRqxHBoq7ziTjyZyAFW7AVGDknNZG8IXQ-SqXxQ-fIi81YOxNDYYUQt-A2QsH7Wc5fFCyyISFRKyetJMkFTiZJeFLOn9rf737J4gYa1s-Q8H4w1I635_dCV8Am0F88iv1kFNNby7Y71ESeF-YOEK-GexpahEOPU9mZJVkGcaLF5izBPZtqEuQp-YxLYenlcrFZ09_bERduGe-u9MxNLUqdQHFv8wBMGUydtRYbYZYvg-Q" > rgNames.json
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
