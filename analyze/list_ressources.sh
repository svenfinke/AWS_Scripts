
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
