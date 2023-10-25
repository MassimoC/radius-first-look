import radius as radius
@description('Specifies the environment for resources.')
param environment string

resource app 'Applications.Core/applications@2023-10-01-preview' = {
  name: 'podinfo-app'
  properties: {
    environment: environment
    extensions: [
      {
        kind: 'kubernetesNamespace'
        namespace: 'podinfo'
      }]
  }
}

resource podinfo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'podinfo'
  properties: {
    application: app.id
    container: {
      image: 'ghcr.io/stefanprodan/podinfo:latest'
      ports: {
        web: {
          containerPort: 9898
        }
      }
    }
  }
}
