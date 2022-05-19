# This is a simple Bicep project that will implement a solution which provisions the following infrastructure:
#
#  1. Deploys a virtual Network carved up into multiple subnets : (Application Gateway, Web Tier, API Tier, Cache Tier and a Bastion)
#  2. Deploys a Bastion
#  3. Deploys four virtual machines (2 per subnet) spread across availability zones
#  4. Each tier has it's own Application Gateway
#  5. TBC