import radius as radius
@description('Specifies the environment for resources.')
param environment string

resource app 'Applications.Core/applications@2023-10-01-preview' = {
  name: 'empty'
  properties: {
    environment: environment
  }
}
