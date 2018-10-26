
echo "Doing some Recon stuff. Listing Ressources now:"
echo ""
echo " EC2 Instances"
echo "==============="
query="Reservations[].Instances[][InstanceId][][]"
instances=$(aws ec2 describe-instances --query "$query")
count=$(echo "$instances" | jq '. | length')

echo "We have $count instances:"
echo "$instances"

echo ""
echo " VPC's"
echo "======="
vpcs=$(aws ec2 describe-vpcs --query 'Vpcs[][VpcId][]')
count=$(echo "$vpcs" | jq '. | length')

echo "We have $count VPC's:"
echo "$vpcs"

echo ""
echo " RDS DB Instances"
echo "=================="
query="DBInstances[][DBInstanceIdentifier][]"
dbs=$(aws rds describe-db-instances --query "$query")
count=$(echo "$dbs" | jq '. | length')

echo "We have $count RDS DB Instances:"
echo "$dbs"



echo ""
echo " CloudFormation"
echo "================"
stacks=$(aws cloudformation describe-stacks --query "Stacks[][StackId][]")
count=$(echo "$stacks" | jq '. | length')

echo "We have $count Cloudformation Stacks"
echo "$stacks"

echo ""
echo " Lambda"
echo "========"
funcs=$(aws lambda list-functions  --query "Functions[][FunctionName][]")
count=$(echo "$funcs" | jq '. | length')

echo "We have $count Lambda Functions"
echo "$funcs"

echo ""
echo " API Gateway"
echo "============="
gateways=$(aws apigateway get-domain-names --query "items[][domainName][]")
count=$(echo "$gateways" | jq '. | length')

echo "We have $count API Gateways"
echo "$gateways"

echo ""
echo " Route 53"
echo "=========="
zones=$(aws route53 list-hosted-zones --query "HostedZones[][Id, Name]")
count=$(echo "$zones" | jq '. | length')

echo "We have $count Hosted Zones (Route 53)"
echo "$zones"

echo ""
echo " AMI Images"
echo "============"

images=$(aws ec2 describe-images --owner $(aws sts get-caller-identity --query "Account" --output text) --query "Images[][ImageId][]")
count=$(echo "$images" | jq '. | length')

echo "We have $count AMI images"
echo $images
