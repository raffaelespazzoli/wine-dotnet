# Wine and dotnet

## Create wine base image

```shell
docker build --rm -t quay.io/raffaelespazzoli/wine:latest -f wine.dockerfile
docker build --rm -t quay.io/raffaelespazzoli/dotnet:4.8 -f dotnet.dockerfile
```
