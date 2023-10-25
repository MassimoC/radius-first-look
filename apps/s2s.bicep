import radius as radius
@description('Specifies the environment for resources.')
param environment string

resource app 'Applications.Core/applications@2023-10-01-preview' = {
  name: 's2s'
  properties: {
    environment: environment
    extensions: [
      {
        kind: 'kubernetesNamespace'
        namespace: 's2s'
      }]
  }
}

resource frontend 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'frontenddemo'
  properties: {
    application: app.id
    container: {
      image: 'radius.azurecr.io/samples/demo:latest'
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    connections: {
      backend: {
        // connection via cluster IP service
        source: 'http://${backend.name}:80'
      }
    }
  }
}
resource backend 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'backenddemo'
  properties: {
    application: app.id
    container: {
      image: 'nginx:latest'
      ports: {
        web: {
          containerPort: 80
        }
      }
    }
  }
}
resource gateway 'Applications.Core/gateways@2023-10-01-preview' = {
  name: 'gatewaydemo'
  properties: {
    application: app.id
    routes: [
      {
        path: '/'
        destination: 'http://${frontend.name}:3000'
      }
    ]
  }
}
