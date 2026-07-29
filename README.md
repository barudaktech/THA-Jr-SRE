# THA-Jr-SRE
## SRE Submission - Rafi

With this file, I want to documentation of my Take-Home Assignment.

Tools :
- Google Cloud Platform (GKE, GCS, Artifacts Registry, 
- Terraform
- Docker
- Sonatype Nexus Repo, nexus-blobstore-google-cloud

---
## 1. Build a custom container
I am create Dockerfile for custom the official image sonatype nexus 3. This base image from https://hub.docker.com/r/sonatype/nexus3/ and I download file nexus-blobstore-google-cloud.kar for installing plugin GCS inside image custom, after write the Dockerfile it's time to build the custom image with docker build and store to the artifacts registry google.
<img width="820" height="888" alt="image" src="https://github.com/user-attachments/assets/a5c810ab-2802-4e2f-aa98-0295d35dd948" />

<img width="1600" height="868" alt="image" src="https://github.com/user-attachments/assets/ae0f3e50-9bd2-4264-bf17-929faa42ad21" />


## 2. Kubernetes configs
In this configuration in folder/directory **k8s**, I am create configuration file deployment, pvc, and service.
Deployment for running the container sonatype nexus with custom image, securit context, spec of container, and volume
Persistent volume for store local data of nexus
Service use expose port nexus 8081 for access client

In this case, I using Kustomize for simple templating of yaml configuration because currently I don't understand yet of Helm templating
<img width="820" height="888" alt="image" src="https://github.com/user-attachments/assets/d15e4f9a-96f2-46a2-89fd-a04142d644af" />


## 3. GCP resource creation
For deploying the GKE, I using terraform for build/create infra GKE, GCS.
Insde file gke.tf, I implement cost efficiency with declaration node pool with 1 node, using n1-standard-1 machine and preemtible VMs.
First of all for running terraform is installing package, initialization, checking or validate the configuration file, checking plan and apply for create infrastructure.
<img width="820" height="888" alt="image" src="https://github.com/user-attachments/assets/72819e7e-475d-4063-9f80-b5dc7fe2ac24" />


## 4. Deploy
This is evidence of deployment of take home assignment.

### k8s
Cluster overview
<img width="1600" height="868" alt="Screenshot From 2026-07-30 00-32-53" src="https://github.com/user-attachments/assets/f7d23edc-04a5-425f-8c0c-d091561bf0ae" />

Nodes
<img width="1600" height="868" alt="Screenshot From 2026-07-30 00-34-03" src="https://github.com/user-attachments/assets/ce026e41-2bb4-4b14-a352-8ef77496d62c" />

PVC
<img width="1600" height="868" alt="Screenshot From 2026-07-30 00-34-16" src="https://github.com/user-attachments/assets/26ba2df0-c5c9-45d4-91fe-2739cb226a14" />

All services
<img width="820" height="888" alt="Screenshot From 2026-07-30 01-18-57" src="https://github.com/user-attachments/assets/524ebfd2-dd53-4762-a8c8-1fa255b61208" />

### Sonatype nexus
Blob stores
<img width="1600" height="868" alt="image" src="https://github.com/user-attachments/assets/8717cf80-04d5-4d66-a2a7-9d564219200f" />

Repository
<img width="1600" height="868" alt="image" src="https://github.com/user-attachments/assets/e2bb64bb-cc39-49c6-8842-9941221c172d" />
<img width="1600" height="868" alt="image" src="https://github.com/user-attachments/assets/39a0186c-84ce-4e6c-977b-c8857bc171a1" />


### GCS
Testing create Blob stores from Sonatype Nexus
<img width="1600" height="868" alt="image" src="https://github.com/user-attachments/assets/bac19e96-1cfd-4e4d-888e-35cffce9e48d" />

### Artifacts Registry
Store custom image in registry GCP
<img width="1600" height="868" alt="image" src="https://github.com/user-attachments/assets/f23c0a2d-d5f1-4bfa-bb39-bc8f53a1d91f" />
<img width="1600" height="868" alt="image" src="https://github.com/user-attachments/assets/3a81012f-bce7-4f07-b06e-97977b35b919" />


## 5. Continuous integration - a theoretical question
To achieve the automatically deployment if example of new nexus version like editing the Dockerfile and change the base image version of sonatype nexus, and than push to the repository git and already setup CI/CD pipelines.
Stage for automatically deployment is :
1. Preparation or versioning of custom image, it can be random tag or create tag manually from menu Gitlab repo then after that trigger the CI/CD Pipelines
2. Validate, this function for checking of configuration, the code is good or have bug, typo or otherelse
3. Build, after pass 2 stage before, this stage for build new or custom image, after success build image and storing in the registry
4. Deploy, this stage for implementation of changing the version, it can be to target environment with adjust or merge request to spesific branch like for dev/test, staging, main/master for production


