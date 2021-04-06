3-tier architecture in AWS using Terraform
 
Overview:
Each tier will be represented by a subnet: a public subnet and two (2) private subnets. Private subnets will be used by application layer and database layer. In public subnet one EC2 instance will be launched which will have direct access to the internet and will act as a jumpbox to connect to an EC2 instance deployed in the application layer.
 
Pre-requisites:
Need to install Terraform and AWS CLI, also an active AWS account.
 
Requirements:
1.	VPC with IPv4 CIDR block.
2.	One public and two private subnets with non-overlapping CIDR blocks. (within the range of VPC)
3.	One EC2 instance in the public subnet.
4.	One EC2 instance in the private subnet.
5.	Ability to connect to our EC2 instance (the jump box) in the public subnet via SSH/RDP.
6.	Ability to connect to our EC2 instance in the private subnet only from the jump box.
 
To fulfil above requirements, we need:
1.	An Internet Gateway attached to the VPC, a Route Table and Route Table Association that routes traffic between the Internet Gateway and the public subnet, and a public IP address assigned to our EC2 instance.
2.	IGW helps us to connect to our VPC from internet.
3.	NAT (Network Address Translation) Gateway with EIP (Elastic IP) so that the EC2 instance in private subnet can communicate with internet indirectly if required.
4.	Two Security Groups to define the inbound and outbound rules for both EC2 instances.

For high availability and Scalability:
1.	Auto Scaling is the service that can be used for dynamically scaling the computational resource when the traffic is unpredictable. 
2.	Here, we can make use of Auto scaling group to increase or decrease the number of instances running based on the traffic load.
3.	Launch template is used to define the type of instance that will be created with ASG.
4.	Placement groups can be used to influence the placement of instances on the underlying hardware
5.	A spread placement group places instances on distinct hardware. 
6.	Load balancer automatically distributes incoming traffic across multiple targets.
7.	Application Load Balancer is best suited for load balancing of HTTP and HTTPS traffic.
8.	Network Load Balancer is best suited for load balancing of Transmission Control Protocol (TCP), User Datagram Protocol (UDP), and Transport Layer Security (TLS) traffic.
9.	In this code, ALB is deployed. However, to make the ALB function, we need to create Security group for it which should include egress and ingress rules to allow the incoming internet traffic and distribute is accordingly to the load balanced instances. (We should have atleast 2 instances to load balance the traffic. Here we have only one instance in the public subnet)
10.	Combination of ALB and ASG gives high availability to the infrastructure. 

Now time to bring up the infra and services using terraform.
Run below commands to deploy the infrastructure.
terraform --version : To verify the Terraform version
terraform init : Install provider plugins
terraform plan : Verify the Terraform execution plan and verify no errors
terraform apply : Setup the environment and services
