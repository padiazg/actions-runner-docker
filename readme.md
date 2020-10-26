
## Build
```bash
$ docker build -t padiazg/github-actions-runner:v2.273.5-docker .
```

## Run
```bash
$ docker run -it --rm \
-e GITHUB_OWNER=... \
-e GITHUB_REPOSITORY=... \
-e GITHUB_PAT=... \
-v /var/run/docker.sock:/var/run/docker.sock \
--name github-actions-runner \
padiazg/github-actions-runner:v2.273.5-docker
```


References
https://sanderknape.com/2020/03/self-hosted-github-actions-runner-kubernetes/

