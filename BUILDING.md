# Building a new Docker image

To build and push a new Docker image, of the release x.y.z, first create the correct directory and suitable Dockerfile. Then execute the following commands:
```
mkdir -p x.y.z/alpine

cd x.y.z
docker build -t rqlite/rqlite:x.y.z .
docker push rqlite/rqlite:x.y.z

cd alpine
docker build -t rqlite/rqlite:x.y.z-alpine .
docker push rqlite/rqlite:x.y.z-alpine
```
To update the `latest` tag, execute the same instructions but pass `latest` instead `x.y.z`.
