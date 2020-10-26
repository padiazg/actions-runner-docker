
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

You can set labels for the runner as stated in the [docs](https://docs.github.com/es/free-pro-team@latest/actions/hosting-your-own-runners/using-labels-with-self-hosted-runners) passing the `RUNNER_LABELS` variable the the container

```bash
$ docker run -it --rm \
-e GITHUB_OWNER=... \
-e GITHUB_REPOSITORY=... \
-e GITHUB_PAT=... \
-e RUNNER_LABELS=prod,linux,x64 \
-v /var/run/docker.sock:/var/run/docker.sock \
--name github-actions-runner \
padiazg/github-actions-runner:v2.273.5-docker
```


References
https://sanderknape.com/2020/03/self-hosted-github-actions-runner-kubernetes/

