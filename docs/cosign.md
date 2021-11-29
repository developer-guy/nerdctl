# Container Image Sign and Verify with cosign tool

[cosign](https://github.com/sigstore/cosign) is tool that allows you to sign and verify container images with the
public/private key pairs or without them by providing
a [Keyless support](https://github.com/sigstore/cosign/blob/main/KEYLESS.md).

You can enable container signing and verifying features with `push` and `pull` commands of `nerdctl` by using `cosign`
under the hood with make use of flags `--sign` while pushing the container image, and `--verify` while pulling the
container image.

For signing while pushing the container image:

> Don't forget to install cosign because nerdctl using cosign executable under the hood.
> You can install cosign by following this page: https://docs.sigstore.dev/cosign/installation

```shell
$ cat <<EOF | tee Dockerfile.dummy
FROM alpine:latest
CMD [ "echo", "Hello World" ]
EOF

$ nerdctl build -t devopps/hello-world -f Dockerfile.dummy .
...

$ nerdctl push --sign devopps/hello-world # this command will sign container image with Keyless mode
...

$ cosign generate-key-pair # this command will output two files: cosign.key and cosign.pub
$ COSIGN_PASSWORD=$COSIGN_PASSWORD nerdctl push --sign --cosign-key cosign.key devopps/hello-world # this command will sign container image with private key.
...
```