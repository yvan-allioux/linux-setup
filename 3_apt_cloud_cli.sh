#!/bin/bash
#launch this script from github
#wget  -q -O - https://raw.githubusercontent.com/yvan-allioux/linux-setup/main/3_apt_cloud_cli.sh | bash

#oc command and kubectl
#update here : https://github.com/okd-project/okd/releases
wget https://github.com/okd-project/okd/releases/download/4.15.0-0.okd-2024-03-10-010116/openshift-client-linux-4.15.0-0.okd-2024-03-10-010116.tar.gz
tar -xvf openshift-client-linux-*.tar.gz
sudo mv oc kubectl /usr/local/bin/
rm openshift-client-linux-*.tar.gz README.md
oc version

#gcloud
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-468.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-cli-*.tar.gz
./google-cloud-sdk/install.sh
rm -rf google-cloud-cli-*.tar.gz
gcloud version

#aws
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
rm awscliv2.zip
rm -r aws
aws --version
