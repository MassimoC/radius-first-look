# Radius on AKS

Install radius

```

wget -q "https://raw.githubusercontent.com/radius-project/radius/main/deploy/install.sh" -O - | /bin/bash

```

## Create an AKS

```
cd scripts/

sh deploy.sh

```


## Environment

```
mkdir apps

cd apps/

rad init

```

## PodInfo

```

rad run podinfo.bicep --application podinfo-app --environment default

```


## Service to Service with external LB

```

rad deploy s2s.bicep --environment default

```
