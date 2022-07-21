#!/usr/bin/env bash

#operatingSystems=("aix" "android" "darwin" "dragonfly" "freebsd" "illumos" "ios" "js" "linux" "netbsd" "openbsd" "plan9" "solaris" "windows")
operatingSystems=("android" "freebsd" "ios" "linux" "netbsd" "openbsd" "windows")
#archs=("386" "amd64" "arm" "arm64" "mips" "mips64" "mips64le" "mipsle" "ppc64" "ppc64le" "riscv64" "s390x" "wasm")
archs=("386" "amd64" "arm" "arm64")

for i in "${!operatingSystems[@]}"
do
  for j in "${!archs[@]}"
  do
    env GOOS=${operatingSystems[i]} GOARCH=${archs[j]} go build -o "dist/lut_apply.${operatingSystems[i]}_${archs[j]}"
    printf '%s_%s\n' "${operatingSystems[i]}" "${archs[j]}"
  done
done
# Properly formatting the total computed number of combinations that is:
# number of elements in array1 times number of elements in array2
printf 'Total number of combinations: %d\n' "$((${#operatingSystems[@]} * ${#archs[@]}))"
