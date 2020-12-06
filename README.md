# Wine and dotnet

## Create wine base image

```shell
docker build --rm -t quay.io/raffaelespazzoli/wine:latest -f wine.dockerfile
docker build --rm -t quay.io/raffaelespazzoli/dotnet:5.0.100 -f dotnet.dockerfile
```
