module github.com/containerd/nerdctl

go 1.16

require (
	cloud.google.com/go v0.97.0 // indirect
	github.com/Microsoft/go-winio v0.5.1
	github.com/cespare/xxhash/v2 v2.1.2 // indirect
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
	github.com/cpuguy83/go-md2man/v2 v2.0.1 // indirect
	github.com/cyphar/filepath-securejoin v0.2.3
	github.com/docker/cli v20.10.11+incompatible
	github.com/docker/docker v20.10.11+incompatible
	github.com/docker/go-connections v0.4.0
	github.com/docker/go-units v0.4.0
	github.com/fatih/color v1.13.0
	github.com/frankban/quicktest v1.13.0 // indirect
	github.com/fsnotify/fsnotify v1.5.1 // indirect
	github.com/gogo/protobuf v1.3.2
	github.com/hashicorp/errwrap v1.1.0 // indirect
	github.com/hashicorp/go-multierror v1.1.1
	github.com/ipfs/go-cid v0.1.0
	github.com/ipfs/go-ipfs-files v0.0.9
	github.com/ipfs/go-ipfs-http-client v0.1.0
	github.com/ipfs/interface-go-ipfs-core v0.5.2
	github.com/jaytaylor/go-hostsfile v0.0.0-20211120191712-f53f85d8b98f
	github.com/mattn/go-isatty v0.0.14
	github.com/moby/sys/mount v0.3.0
	github.com/multiformats/go-multiaddr v0.3.1
	github.com/onsi/gomega v1.16.0 // indirect
	github.com/opencontainers/go-digest v1.0.0
	github.com/opencontainers/image-spec v1.0.2-0.20211102003311-9a7a9876500e
	github.com/opencontainers/runtime-spec v1.0.3-0.20211101234015-a3c33d663ebc
	github.com/prometheus/common v0.31.1 // indirect
	github.com/prometheus/procfs v0.7.3 // indirect
	github.com/rootless-containers/rootlesskit v0.14.6
	github.com/rs/cors v1.8.0 // indirect
	github.com/sirupsen/logrus v1.8.1
	github.com/smartystreets/assertions v1.2.0 // indirect
	github.com/spf13/cobra v1.2.1
	github.com/spf13/pflag v1.0.5
	github.com/stretchr/objx v0.3.0 // indirect
	github.com/tidwall/gjson v1.11.0
	github.com/urfave/cli v1.22.5 // indirect
	github.com/xeipuuv/gojsonpointer v0.0.0-20190905194746-02993c407bfb // indirect
	go.opentelemetry.io/otel v1.2.0 // indirect
	go.uber.org/atomic v1.9.0 // indirect
	go.uber.org/zap v1.19.1 // indirect
	golang.org/x/crypto v0.0.0-20211117183948-ae814b36b871
	golang.org/x/oauth2 v0.0.0-20211028175245-ba495a64dcb5 // indirect
	golang.org/x/sync v0.0.0-20210220032951-036812b2e83c
	golang.org/x/sys v0.0.0-20211117180635-dee7805ff2e1
	golang.org/x/term v0.0.0-20210927222741-03fcf44c2211
	golang.org/x/text v0.3.7 // indirect
	google.golang.org/genproto v0.0.0-20211021150943-2b146023228c // indirect
	gopkg.in/square/go-jose.v2 v2.6.0 // indirect
	gotest.tools/v3 v3.0.3
)

// Temporary fork for avoiding importing patent-protected code: https://github.com/hashicorp/golang-lru/issues/73
replace github.com/hashicorp/golang-lru => github.com/ktock/golang-lru v0.5.5-0.20211029085301-ec551be6f75c
