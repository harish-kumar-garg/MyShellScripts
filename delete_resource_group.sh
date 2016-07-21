sudo su
wget http://stedolan.github.io/jq/download/linux64/jq
chmod +x ./jq
cp jq /usr/bin
#curl -X POST https://login.windows.net/85c997b9-f494-46b3-a11d-772983cf6f11/oauth2/token  \
 # -F redirect_uri=http://localhost \
  #-F grant_type=authorization_code \
  #-F resource=https://management.core.windows.net/ \
  #-F client_id=1f7ba90d-f0d3-4a3e-954d-4817448d93ed \
  #-F code=AAABAAAA0TWEUN3YUUq5vuCvmnaQiXFIqQ1ZFbTQUGtmRois6jyQkRm8NC8NVXZGGA_4McWR1tPIuAnUGvXTDE-0w3CxtlnpCC1NBQ10Ovu_wY1ypXIejxou0bAftGxPiQ-xVxOLCN-XeIcv32yBShp_B9THIO3l-_bcAyVlOCj90HuW6roBEf8vbLwhmeFfW9XT04wBwwoBTUG1poeQH2j2DL1W4hEyy9uyDiOnrLwlyiAtG65tZNlNtGC_ZV5QhHzsaPWmNVtPyC1-DbU1QnBWNRygectbEwEhilHRfm-hTx4MewO1IR0lVOeA9KamYTt6hitYt6WoTJRiAJPeRWh9-RokY-b1wEgHkcsXPZ45cXd8ehefjQOYOXDG8qJxFlIKnJsvbNU0tPruXFVT_3Uw-75tfOCrB-u3tGe52wIO61w8yznk_9WYnhA5N9gVm3G1bM7hv82ASKOb9VtqRVKF-2TTw03Pedk96WPImkk8unOfaGd4x9O1nrosjwjNffHhgiy0UFnK02uaVezCmac-1jS0oqlB6GpHv_TKlqfjBL7aQAmvpAFd6b-3my5Vw-BU57P6eCTkHOHy7gvJ1124HygjszM6_FnfNmP52c7GftmbwtlEZ5F8xebf6-vT5UnLUWA7vxKR9GHGGbSS-ZHb1nRw7OUP5rPiWGvuExQT-tPkhkjpe1u8MEdUrouXHZqdI5Lz8ZZy-ZsZlCbghQD5x028hXlTqsE2RkDl2g22GCLm6IBw_ostV1CRf1EzIFbpagbA8oyRwzaJ4L_k7vJ0keNe_iB5MbHbi2YQIXbG0eyIcbQgAA > tokens.json
#TOKEN="$(cat tokens.json | jq '.access_token')"
#curl -v https://management.azure.com/subscriptions/c8947205-1040-4fc4-b494-c3b3136166c0/resourceGroups?api-version=2014-04-01 \
 # -H "x-ms-version: 2013-08-01" \
 # -H "Content-Type:application/json" \
 # -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ik1uQ19WWmNBVGZNNXBPWWlKSE1iYTlnb0VLWSIsImtpZCI6Ik1uQ19WWmNBVGZNNXBPWWlKSE1iYTlnb0VLWSJ9.eyJhdWQiOiJodHRwczovL21hbmFnZW1lbnQuY29yZS53aW5kb3dzLm5ldC8iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC84NWM5OTdiOS1mNDk0LTQ2YjMtYTExZC03NzI5ODNjZjZmMTEvIiwiaWF0IjoxNDY3ODY4NjEwLCJuYmYiOjE0Njc4Njg2MTAsImV4cCI6MTQ2Nzg3MjUxMCwiYWNyIjoiMSIsImFtciI6WyJwd2QiXSwiYXBwaWQiOiIxZjdiYTkwZC1mMGQzLTRhM2UtOTU0ZC00ODE3NDQ4ZDkzZWQiLCJhcHBpZGFjciI6IjAiLCJmYW1pbHlfbmFtZSI6IkJhcmRoYW4iLCJnaXZlbl9uYW1lIjoiQXJpaml0IiwiZ3JvdXBzIjpbImEwZDdkOGI0LTQxM2UtNGU3Ni1iYmUyLTU1MDVlOGFjZGEyNCIsIjUxN2YzZjQyLTYyOWYtNDZjZC04MGE3LTgzNzlmY2YyODE2OCIsImQ3Y2EyNjUwLWIzNTctNDNkNi1hMzg2LWU4YjZkMWExYWViMiIsIjMxYTZlYWJlLTNhOTctNGQ2OS05M2ZjLWJhYjgwYjY4MzQyYyIsIjMzZTVlZTllLTYzYzYtNGVmNC1iMDdjLTI3OTNlZWFjN2QyNSIsIjMxMmY4ZmU2LWRlNjUtNDZhNC1iODIyLTA0YWE1Yzc4YTczZSIsImFmYjExODU3LWUzZDgtNDk2Yy04MjcyLTFhMGRiMGI2MTk3NSIsIjRiMTdhM2QzLWZiYzctNDU2My05NmY0LTQ0NWQ4YmU5ZDc4MSIsImVkNjM2MzBiLTM0ZjAtNDMxZi05N2U0LWRiMzA3NTQyNTc1ZCIsIjM4MGM4M2JhLTgxMjUtNDNhZS04NzM4LThlZjU0YzEzYmJiMCJdLCJpcGFkZHIiOiIxMTIuMTIxLjU1LjkiLCJuYW1lIjoiQXJpaml0IEJhcmRoYW4iLCJvaWQiOiIzZWMwMWVkMy05Yjg2LTRiMGItYjFkZS0wZDQ4ODI1ZjEzOTQiLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtNDQ4NTM5NzIzLTc0NjEzNzA2Ny0xODAxNjc0NTMxLTI3Njc2MSIsInB1aWQiOiIxMDAzQkZGRDkyNTZBMUU1Iiwic2NwIjoidXNlcl9pbXBlcnNvbmF0aW9uIiwic3ViIjoiQ3Iwa1JCRXlQRVEtRjBGdm96RzJsTExZNXlPQ0s1TUNYRTI4OFRhLUJNYyIsInRpZCI6Ijg1Yzk5N2I5LWY0OTQtNDZiMy1hMTFkLTc3Mjk4M2NmNmYxMSIsInVuaXF1ZV9uYW1lIjoiTTEwMzIzMzdAbWluZHRyZWUuY29tIiwidXBuIjoiTTEwMzIzMzdAbWluZHRyZWUuY29tIiwidmVyIjoiMS4wIn0.WZuPuk9L23Tn3EtH_0jORTncwIePLhv-56dD18vnQMJgZZ1hDUZVOiGwuvB4boHcb0W_GAN009zmhyZkBGtKfYr8V50KvqHFLgz3gZXAHIS-_3bwlBe-cZJG6cQzHIb-s6cSOtE4K_HX7_GgvPMotCmf2Oepx3quC7v7R5pbtegqbNDQo1YINiGfVkNlV8S862GQPq5-n0tP-c7PXsjWeqRqSi2PkL_yOwI3hO0g1hnsMRduqZ_WLqCeb_jtaTpj6f3O4nWx9A0H9NQYRRiDu11KBRjSeVMVFifD_fFNLBLU1s75k-1-7eSZK-a_EYEp7sGjjwcAdthw7PZZK62afw" > rgNames.json

#function definition
delete_resource_group()
{
	echo 'Initializing...'
	I=0
	NAME1='null'
	TOTAL_NUMBER_OF_RG=0
	while [ $I -gt 0 ]
	do
		NAME1="$(cat rgName.json | jq '.value'[$I]'.name')"
		if [ "$NAME1" = 'null' ]
		then
			break
		else
			I='expr $I + 1'
		fi	
	done
	TOTAL_NUMBER_OF_RG=$I
	echo $TOTAL_NUMBER_OF_RG
	I=0
	#date is in format ddmmyyyy
	while [ $I -lt $TOTAL_NUMBER_OF_RG ]
	do
		NAME1="$(cat rgName.json | jq '.value[$I].name')"
		if [ "$NAME1" = *DND* ]
			then
				echo "$NAME1"' is not deleted'
				I='expr $I + 1'
			else
				echo $NAME1'will be deleted'
				I=`expr $I + 1`
		fi
	done
}  
#calling function
delete_resource_group()
