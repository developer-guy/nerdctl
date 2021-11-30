# Container Image Sign and Verify with cosign tool

[cosign](https://github.com/sigstore/cosign) is tool that allows you to sign and verify container images with the
public/private key pairs or without them by providing
a [Keyless support](https://github.com/sigstore/cosign/blob/main/KEYLESS.md).

Keyless uses ephemeral keys and certificates, which are signed automatically by
the [fulcio](https://github.com/sigstore/fulcio) root CA. Signatures are stored in
the [rekor](https://github.com/sigstore/rekor) transparency log, which automatically provides an attestation as to when
the signature was created.

You can enable container signing and verifying features with `push` and `pull` commands of `nerdctl` by using `cosign`
under the hood with make use of flags `--sign` while pushing the container image, and `--verify` while pulling the
container image.

> * Ensure cosign executable in your `$PATH`.
> * You can install cosign by following this page: https://docs.sigstore.dev/cosign/installation

Prepare your environment:

```shell
# Create a sample Dockerfile
$ cat <<EOF | tee Dockerfile.dummy
FROM alpine:latest
CMD [ "echo", "Hello World" ]
EOF

# Build the image
$ nerdctl build -t devopps/hello-world -f Dockerfile.dummy .

# Generate a key-pair: cosign.key and cosign.pub
$ cosign generate-key-pair

# Export your COSIGN_PASSWORD to prevent CLI prompting
$ export COSIGN_PASSWORD=$COSIGN_PASSWORD
```

Sign the container image while pushing:

```
# Sign the image with Keyless mode
$ nerdctl push --sign devopps/hello-world

# Sign the image and store the signature in the registry
$ nerdctl push --sign --cosign-key cosign.key devopps/hello-world
```

Verify the container image while pulling:

> REMINDER: Image won't be pulled if there are no matching signatures in case you passed `--verify` flag.

```shell
# Verify the image with Keyless mode
$ nerdctl pull --verify devopps/hello-world

# Verify the image against a public key
$ nerdctl pull --verify --cosign-key cosign.key devopps/hello-world

# You can not verify the image with different private key
$ nerdctl pull --verify --cosign-key bad.key devopps/hello-world

# You can not verify the image if not signed
$ nerdctl pull --verify --cosign-key cosign.key devopps/hello-world-bad
```