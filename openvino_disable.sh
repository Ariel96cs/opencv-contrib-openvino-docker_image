#!/bin/bash

# Tomado de https://openvino.jp/tag/2020-3/
# Block1
wget -O GPG_KEY https://apt.repos.intel.com/openvino/2020/GPG-PUB-KEY-INTEL-OPENVINO-2020?elq_cid=6195740&erpm_id=9311153
apt-key add GPG_KEY
echo "deb https://apt.repos.intel.com/openvino/2020 all main" | tee /etc/apt/sources.list.d/intel-openvino-2020.list
apt update
apt-get install intel-openvino-dev-ubuntu18-2020.3.194
cd /opt/intel/openvino/deployment_tools/demo/ 

#Block2
cd /opt/intel/openvino/install_dependencies/
-E ./install_openvino_dependencies.sh 

#Block3
source /opt/intel/openvino/bin/setupvars.sh 

#Model Optimizer
cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites
./install_prerequisites.sh
