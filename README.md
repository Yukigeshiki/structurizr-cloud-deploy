# structurizr-cloud-deploy
A GitHub Actions deploy pipeline for Structurizr Cloud

1) Run these two commands from the root of the source code repository.
```
docker pull structurizr/lite
docker run -it --rm -p 8080:8080 -v ./dsl/test:/usr/local/structurizr structurizr/lite
```
2) Open your web browser and enter `localhost:8080` for the URL.
