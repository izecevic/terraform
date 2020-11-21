# Nutanix Provider
export TF_VAR_prism_username = "iz@emeagso.lab"
export TF_VAR_prism_password = "YOUR_PASSWORD"
export TF_VAR_prism_endpoint = "10.68.97.150"
# Call API pour recup UUID du subnet
SUBNET_NAME = "VLAN99"
ENTITY_TYPE = "subnets"
REQUEST_DATA ='{ "kind": "subnet","length": 100,"offset": 0 }'
ENTITY_NAME = $SUBNET_NAME
JQ_FILTER=".entities[] | select(.spec.name==\"$ENTITY_NAME\").metadata.uuid"
export TF_VAR_Subnet_UUID=`curl -s --insecure --user "$prism_username:$prism_password" --request POST "https://$prism_endpoint:9440/api/nutanix/v3/$ENTITY_TYPE/list" --header 'Content-Type: application/json' --data-raw "$REQUEST_DATA" | jq -r "$JQ_FILTER"`