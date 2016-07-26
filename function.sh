#function definition
delete_resource_group() {
	echo 'Initializing...'
	I=
	NAME1=
	TOTAL_NUMBER_OF_RG=
	while [ $I -gt 0 ]
	do
		NAME1='$(cat rgName.json | jq .value['$I'].name)'
		if [ $NAME1 = 'null' ]; then
			break;
		else
			I=`expr $I + 1`;
		fi	
	done
	TOTAL_NUMBER_OF_RG=$I
	echo $TOTAL_NUMBER_OF_RG
	I=0
	#date is in format ddmmyyyy
	while [ $I -lt $TOTAL_NUMBER_OF_RG ]
	do
		NAME1='$(cat rgName.json | jq .value['$I'].name)'
		if [ $NAME1 = *DND* ]; then
				echo $NAME1' is not deleted'
				I=`expr $I + 1`
			else
				echo $NAME1'will be deleted'
				I=`expr $I + 1`
		fi
	done
}  
#calling function
delete_resource_group
