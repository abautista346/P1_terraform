This infrastructure has the following components:

A Classic Load Balancer to expose the services (Deployed in public subnets)
A set of EC2 instances being managed by an AutoScaling group (running in private subnets) that exposes an Nginx server
An EFS volume mounted on the EC2 instances that contain a Web project
A Route 53 record for the DNS of your application


Terraform Project have the following modules:

VPC Module
Load Balancer Module
EFS Module
AutoScaling Group Module
Launch Template Module
Route 53 Module

![image](https://github.com/abautista346/P1_terraform/assets/34531690/105d63cd-f9fd-41cf-b34d-ced12ae3963e)

