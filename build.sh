#!/usr/local/bin/bash

#operatingSystems=("aix" "android" "darwin" "dragonfly" "freebsd" "illumos" "ios" "js" "linux" "netbsd" "openbsd" "plan9" "solaris" "windows")
#archs=("386" "amd64" "arm" "arm64" "mips" "mips64" "mips64le" "mipsle" "ppc64" "ppc64le" "riscv64" "s390x" "wasm")

declare -A arch_os_pairs=( ["android"]="arm64" ["windows"]="386;amd64;arm;arm64" ["darwin"]="amd64;arm64" ["dragonfly"]="amd64" ["freebsd"]="386;amd64;arm;arm64" ["illumos"]="amd64" ["ios"]="amd64" ["linux"]="386;amd64;arm;arm64;mips;mips64;mips64le;riscv64;s390x" ["netbsd"]="386;amd64;arm;arm64" ["openbsd"]="386;amd64;arm;arm64;mips64" ["solaris"]="amd64" )

for os in "${!arch_os_pairs[@]}"
do
  IFS=";" read -r -a archs <<< "${arch_os_pairs[$os]}"
  for arch in "${archs[@]}"
  do
    printf 'building %s %s -> ' "${os}" "${arch}"
    if env GOOS=$os GOARCH=$arch go build -o "dist/lut_apply.${os}_${arch}" > /dev/null 2>&1 ; then
      printf 'built\n' "$os" "$arch"
    else
      printf 'failed\n' "$os" "$arch"
    fi
  done
done
