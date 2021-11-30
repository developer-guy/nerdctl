module github.com/containerd/nerdctl

go 1.16

require (
	github.com/Microsoft/go-winio v0.5.1
	github.com/compose-spec/compose-go v1.0.6
	github.com/containerd/cgroups v1.0.2
	github.com/containerd/console v1.0.3
	github.com/containerd/containerd v1.6.0-beta.3
	github.com/containerd/containerd/api v1.6.0-beta.3
	github.com/containerd/continuity v0.2.1
	github.com/containerd/go-cni v1.1.1-0.20211026134925-aa8bf14323a5
	github.com/containerd/imgcrypt v1.1.2
	github.com/containerd/stargz-snapshotter v0.10.1
	github.com/containerd/stargz-snapshotter/estargz v0.10.1
	github.com/containerd/stargz-snapshotter/ipfs v0.10.1
	github.com/containerd/typeurl v1.0.2
	github.com/containernetworking/cni v1.0.1
	github.com/containernetworking/plugins v1.0.1
	github.com/cyphar/filepath-securejoin v0.2.3
	github.com/docker/cli v20.10.11+incompatible
	github.com/docker/docker v20.10.11+incompatible
	github.com/docker/go-connections v0.4.0
	github.com/docker/go-units v0.4.0
	github.com/fatih/color v1.13.0
	github.com/gogo/protobuf v1.3.2
	github.com/google/go-containerregistry v0.6.1-0.20210922191434-34b7f00d7a60
	github.com/hashicorp/go-multierror v1.1.1
	github.com/ipfs/go-cid v0.1.0
	github.com/ipfs/go-ipfs-files v0.0.9
	github.com/ipfs/go-ipfs-http-client v0.1.0
	github.com/ipfs/interface-go-ipfs-core v0.5.2
	github.com/jaytaylor/go-hostsfile v0.0.0-20211120191712-f53f85d8b98f
	github.com/mattn/go-isatty v0.0.14
	github.com/moby/sys/mount v0.3.0
	github.com/multiformats/go-multiaddr v0.3.1
	github.com/opencontainers/go-digest v1.0.0
	github.com/opencontainers/image-spec v1.0.2-0.20211102003311-9a7a9876500e
	github.com/opencontainers/runtime-spec v1.0.3-0.20211101234015-a3c33d663ebc
	github.com/rootless-containers/rootlesskit v0.14.6
	github.com/sigstore/cosign v1.3.1
	github.com/sirupsen/logrus v1.8.1
	github.com/spf13/cobra v1.2.1
	github.com/spf13/pflag v1.0.5
	github.com/tidwall/gjson v1.11.0
	golang.org/x/crypto v0.0.0-20211117183948-ae814b36b871
	golang.org/x/sync v0.0.0-20210220032951-036812b2e83c
	golang.org/x/sys v0.0.0-20211117180635-dee7805ff2e1
	golang.org/x/term v0.0.0-20210927222741-03fcf44c2211
	gotest.tools/v3 v3.0.3
)

// Temporary fork for avoiding importing patent-protected code: https://github.com/hashicorp/golang-lru/issues/73
replace github.com/hashicorp/golang-lru => github.com/ktock/golang-lru v0.5.5-0.20211029085301-ec551be6f75c
