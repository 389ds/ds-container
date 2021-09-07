# 389ds-container

[![Nightly build](https://github.com/vashirov/ds-container/actions/workflows/build.yml/badge.svg)](https://github.com/vashirov/ds-container/actions/workflows/build.yml)

## Deployment in OpenShift

Create a new project
```
oc new-project dirsrv
```

Create a new app
```
oc new-app quay.io/389ds/dirsrv-demo
```

Create a service account
```
oc create serviceaccount dirsrv-sa
```

Add `anyuid` SCC to it
```
oc adm policy add-scc-to-user anyuid -n dirsrv -z dirsrv-sa
```

Use this service account for the deployment
```
oc set serviceaccount deployment dirsrv dirsrv-sa
```

