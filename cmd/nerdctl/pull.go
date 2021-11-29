/*
   Copyright The containerd Authors.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

package main

import (
	"bufio"
	"errors"
	"github.com/sirupsen/logrus"
	"os"
	"os/exec"

	"github.com/containerd/nerdctl/pkg/imgutil"
	"github.com/containerd/nerdctl/pkg/ipfs"
	"github.com/containerd/nerdctl/pkg/platformutil"
	"github.com/containerd/nerdctl/pkg/referenceutil"
	"github.com/containerd/nerdctl/pkg/strutil"
	httpapi "github.com/ipfs/go-ipfs-http-client"

	"github.com/spf13/cobra"
)

func newPullCommand() *cobra.Command {
	var pullCommand = &cobra.Command{
		Use:           "pull",
		Short:         "Pull an image from a registry. Optionally specify \"ipfs://\" or \"ipns://\" scheme to pull image from IPFS.",
		RunE:          pullAction,
		SilenceUsage:  true,
		SilenceErrors: true,
	}
	pullCommand.Flags().String("unpack", "auto", "Unpack the image for the current single platform (auto/true/false)")
	pullCommand.Flags().String("cosign-key", "",
		"path to the private key file, KMS URI or Kubernetes Secret")

	pullCommand.RegisterFlagCompletionFunc("unpack", func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		return []string{"auto", "true", "false"}, cobra.ShellCompDirectiveNoFileComp
	})

	// #region platform flags
	// platform is defined as StringSlice, not StringArray, to allow specifying "--platform=amd64,arm64"
	pullCommand.Flags().StringSlice("platform", nil, "Pull content for a specific platform")
	pullCommand.RegisterFlagCompletionFunc("platform", shellCompletePlatforms)
	pullCommand.Flags().Bool("all-platforms", false, "Pull content for all platforms")
	pullCommand.Flags().Bool("verify", false, "Verify the image with cosign")
	// #endregion

	return pullCommand
}

func pullAction(cmd *cobra.Command, args []string) error {
	if len(args) < 1 {
		return errors.New("image name needs to be specified")
	}
	rawRef := args[0]
	client, ctx, cancel, err := newClient(cmd)
	if err != nil {
		return err
	}
	defer cancel()
	insecure, err := cmd.Flags().GetBool("insecure-registry")
	if err != nil {
		return err
	}
	snapshotter, err := cmd.Flags().GetString("snapshotter")
	if err != nil {
		return err
	}
	allPlatforms, err := cmd.Flags().GetBool("all-platforms")
	if err != nil {
		return err
	}
	platform, err := cmd.Flags().GetStringSlice("platform")
	if err != nil {
		return err
	}
	ocispecPlatforms, err := platformutil.NewOCISpecPlatformSlice(allPlatforms, platform)
	if err != nil {
		return err
	}

	unpackStr, err := cmd.Flags().GetString("unpack")
	if err != nil {
		return err
	}
	unpack, err := strutil.ParseBoolOrAuto(unpackStr)
	if err != nil {
		return err
	}

	if isVerify, err := cmd.Flags().GetBool("verify"); err == nil && isVerify {
		cosignExecutable, err := exec.LookPath("cosign")
		if err != nil {
			logrus.WithError(err).Error("cosign executable not found in path $PATH")
			logrus.Info("you might consider installing cosign from: https://docs.sigstore.dev/cosign/installation")
			return err
		}

		cosignCmd := exec.Command(cosignExecutable, []string{"verify"}...)
		cosignCmd.Env = os.Environ()

		keyRef, err := cmd.Flags().GetString("cosign-key")
		if err != nil {
			return err
		}

		if keyRef != "" {
			cosignCmd.Args = append(cosignCmd.Args, "--key", keyRef)
		} else {
			cosignCmd.Env = append(cosignCmd.Env, "COSIGN_EXPERIMENTAL=true")
		}

		cosignCmd.Args = append(cosignCmd.Args, rawRef)

		logrus.Debugf("running %s %v", cosignExecutable, cosignCmd.Args)

		stdout, _ := cosignCmd.StdoutPipe()
		if err := cosignCmd.Start(); err != nil {
			return err
		}

		scanner := bufio.NewScanner(stdout)
		for scanner.Scan() {
			logrus.Info(scanner.Text())
		}
		if err := cosignCmd.Wait(); err != nil {
			return err
		}
	}

	if scheme, ref, err := referenceutil.ParseIPFSRefWithScheme(args[0]); err == nil {
		ipfsClient, err := httpapi.NewLocalApi()
		if err != nil {
			return err
		}
		_, err = ipfs.EnsureImage(ctx, client, ipfsClient, os.Stdout, snapshotter, scheme, ref,
			"always", ocispecPlatforms, unpack)
		return err
	}

	_, err = imgutil.EnsureImage(ctx, client, os.Stdout, snapshotter, args[0],
		"always", insecure, ocispecPlatforms, unpack)
	return err
}
