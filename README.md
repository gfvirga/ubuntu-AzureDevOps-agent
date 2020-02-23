# Microsoft Official documentation
This is a example of dockerfile that will work with Selenium and .NET - modifcation based off the documention:
https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#linux

# Build the container
```bash
docker build -t ubuntu-ado-agent .
```

# Using the agent in a docker container
```bash
$ docker run \
    -e AZP_URL="https://dev.azure.com/<ENTER_project>" \
    -e AZP_TOKEN="<ENTER_TOKEN>" \
    -e AZP_AGENT_NAME="<ENTER_AGENT_NAME>" \
    -e AZP_POOL="<ENTER_POOL_NAME>" \
    ubuntu-ado-agent
```

# Running the container in Kubernetes
- Create a namespace 
`kubectl create namespace ado-agent`
- Modify de deployment file with the enviroment variables necessary.
- Deploy 
`kubectl apply -f ./deployment.yaml`