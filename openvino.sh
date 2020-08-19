#!/bin/bash
cd /home/
# Check if parterns have locally the .tar. In that case, make the copy on the dockerfile
# check for versions too
wget -c http://registrationcenter-download.intel.com/akdlm/irc_nas/16670/l_openvino_toolkit_p_2020.3.194.tgz
tar -xvzf l_openvino_toolkit_p_2020.3.194.tgz
cd l_openvino_toolkit_p_2020.3.194

./install.sh

# Install external software dependencies
cd /opt/intel/openvino/install_dependencies
sudo -E ./install_openvino_dependencies.sh

# Set the enviroment variables
source /opt/intel/openvino/bin/setupvars.sh

# Model optimizer configuration steps
cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites
./install_prerequisites.sh

