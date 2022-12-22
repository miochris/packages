{ pkgs ? import <nixpkgs> {} }: 
with pkgs;
buildGoModule rec {
  pname = "pritunl-client-service";
  version = "1.3.3373.6";

  src = fetchFromGitHub {
    owner = "pritunl";
    repo = "pritunl-client-electron";
    rev = version;
    sha256 = "sha256-Ttg6SNDcNIQlbNnKQY32hmsrgLhzHkeQfwlmCHe0bI0=";
  };

  patches = [
    (writeText "fix.patch" ''
      From 4ebbe166e43e0f19e3e4cb6594987b62a26f0c12 Mon Sep 17 00:00:00 2001
      From: Matej Kollar <matej.kollar@smarkets.com>
      Date: Tue, 20 Dec 2022 19:58:41 +0000
      Subject: [PATCH] lol

      ---
       service/profile/profile.go | 10 ++++++++--
       service/profile/scripts.go | 11 +++++++----
       2 files changed, 15 insertions(+), 6 deletions(-)

      diff --git a/service/profile/profile.go b/service/profile/profile.go
      index e905e36c..651ce420 100644
      --- a/service/profile/profile.go
      +++ b/service/profile/profile.go
      @@ -1411,8 +1411,10 @@ func (p *Profile) startOvpn(timeout bool) (err error) {
       		p.remPaths = append(p.remPaths, downPath)
       
       		args = append(args, "--script-security", "2",
      -			"--up", upPath,
      -			"--down", downPath,
      +			// "--up", upPath,
      +			"--up", "${update-resolv-conf}/libexec/openvpn/update-resolv-conf",
      +			// "--down", downPath,
      +			"--down", "${update-resolv-conf}/libexec/openvpn/update-resolv-conf",
       			"--route-pre-down", blockPath,
       			"--tls-verify", blockPath,
       			"--ipchange", blockPath,
      @@ -1500,6 +1502,7 @@ func (p *Profile) startOvpn(timeout bool) (err error) {
       			lineStr := string(line)
       			if lineStr != "" {
       				output <- lineStr
      +                                fmt.Println("out", lineStr)
       			}
       		}
       	}()
      @@ -1540,6 +1543,7 @@ func (p *Profile) startOvpn(timeout bool) (err error) {
       			lineStr := string(line)
       			if lineStr != "" {
       				output <- lineStr
      +                                fmt.Println("err", lineStr)
       			}
       		}
       	}()
      @@ -2140,7 +2144,9 @@ func (p *Profile) reqOvpn(remote, ssoToken string, ssoStart time.Time) (
       		return
       	}
       
      +
       	if ovpnResp.SsoUrl != "" && ovpnResp.SsoToken != "" && ssoToken == "" {
      +		fmt.Printf("SsoUrl: %s\n", ovpnResp.SsoUrl)
       		evt := event.Event{
       			Type: "sso_auth",
       			Data: &SsoEventData{
      diff --git a/service/profile/scripts.go b/service/profile/scripts.go
      index e811107f..c30cae2d 100644
      --- a/service/profile/scripts.go
      +++ b/service/profile/scripts.go
      @@ -1,9 +1,11 @@
       package profile
       
       const (
      -	blockScript        = "#!/bin/bash\n"
      +	blockScript        = "#!/usr/bin/env bash\n"
       	blockScriptWindows = "@echo off\n"
      -	upScriptDarwin     = `#!/bin/bash -e
      +	upScriptDarwin     = `#!/usr/bin/env bash
      +
      +set -e
       
       CONN_ID="$(echo $${config} | /sbin/md5)"
       
      @@ -116,7 +118,8 @@ killall -HUP mDNSResponder | true
       
       exit 0
       `
      -	downScriptDarwin = `#!/bin/bash -e
      +	downScriptDarwin = `#!/usr/bin/env bash
      +set -e
       
       CONN_ID="$(echo $${config} | /sbin/md5)"
       
      @@ -129,7 +132,7 @@ EOF
       
       exit 0
       `
      -	resolvScript = `#!/bin/bash
      +	resolvScript = `#!/usr/bin/env bash
       #
       # Parses DHCP options from openvpn to update resolv.conf
       # To use set as 'up' and 'down' script in your openvpn *.conf:
      -- 
      2.31.1
    '')
  ];

  modRoot = "service";
  vendorSha256 = "sha256-aQ51c45T0fnoEsOvWaNJJRp37Bk2BX2VtdNP9XkAYKk=";

  postInstall = ''
    mv $out/bin/service $out/bin/pritunl-client-service
  '';

  meta = with lib; {
    description = "Pritunl OpenVPN client CLI";
    homepage =
      "https://github.com/pritunl/pritunl-client-electron/tree/master/service";
    license = licenses.unfree;
    maintainers = with maintainers; [ bigzilla ];
  };
}

