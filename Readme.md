# Task:
Deploy to Kubernetes/Minikube
## Startup:
1. Start the minikube:
    - `minikube start`
2. Execute next command to allow using local docker images:
    - `eval $(minikube docker-env)`
3. Build the image locally:
    - `docker build -t app:v1.0.3 ./docker_image/`
You can also modify the name and tag of the image, but to do this you must also change them in the `./manifests/deployment.yml` file.<br>OR<br>If you are using Helm Chart: change it in `./helm_chart/application/values.yaml`
        ```
        image:
        repository: <place_for_name>
        pullPolicy: Never
        tag: <place_for_tag>
        ```

## For manifest files:
1. Apply the folder `./manifest` with yaml files:
    - `kubectl apply -f ./manifests`
2. Execute the command below for LoadBalancer test (needs for services with `type: LoadBalancer`):
    - `minikube tunnel`

## Own Helm chart:
1. Install the helm chart:
    - `helm install -f values.yaml <helm_chart_name> ../application`
2. Add addons of metrics-server to minikube:
    - `minikube addons enable metrics-server`

## Official Helm chart:
1. Install dependencies:
    - `helm repo update`
2. Install the helm chart:
    - `helm install -f values.yaml <helm_chart_name> ../application`
2. Add addons of metrics-server to minikube:
    - `minikube addons enable metrics-server`
