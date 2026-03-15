# Enable APIs
gcloud services enable cloudkms.googleapis.com compute.googleapis.com \
  confidentialcomputing.googleapis.com iamcredentials.googleapis.com \
  artifactregistry.googleapis.com

# KMS Key (HSM)
gcloud kms keyrings create mpc-keys --location=global
gcloud kms keys create mpc-key --location=global \
  --keyring=mpc-keys --purpose=encryption --protection-level=hsm

# Encrypt key shares
gcloud kms encrypt --key mpc-key --keyring mpc-keys --location global \
  --plaintext-file alice-key-share --ciphertext-file alice-encrypted-key-share
gcloud kms encrypt --key mpc-key --keyring mpc-keys --location global \
  --plaintext-file bob-key-share --ciphertext-file bob-encrypted-key-share

# GCS Buckets
gcloud storage buckets create gs://$MPC_PROJECT_ID-mpc-encrypted-keys --location=europe-west4
gcloud storage buckets create gs://$MPC_PROJECT_ID-mpc-results-storage --location=europe-west4

# Service Accounts
gcloud iam service-accounts create trusted-mpc-account
gcloud iam service-accounts create run-confidential-vm

# Workload Identity Pool
gcloud iam workload-identity-pools create trusted-workload-pool --location="global"

# Ethereum Node
gcloud compute instances create-with-container mpc-lab-ethereum-node \
  --zone=europe-west4-a --container-image=docker.io/trufflesuite/ganache:v7.7.3 \
  --container-arg=--port=80 --machine-type=e2-medium

# Docker Build & Push
gcloud artifacts repositories create mpc-workloads \
  --repository-format=docker --location=europe-west4
docker build -t europe-west4-docker.pkg.dev/$MPC_PROJECT_ID/mpc-workloads/initial-workload-container:latest mpc-ethereum-demo
docker push europe-west4-docker.pkg.dev/$MPC_PROJECT_ID/mpc-workloads/initial-workload-container:latest
