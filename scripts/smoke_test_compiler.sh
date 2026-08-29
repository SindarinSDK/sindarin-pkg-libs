#!/usr/bin/env bash

set -euo pipefail

: "${PLATFORM:?PLATFORM must identify the candidate bundle platform}"
: "${ARCH:?ARCH must identify the candidate bundle architecture}"

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
candidate_libs="${repo_root}/libs/${PLATFORM}"

if [[ ! -d "${candidate_libs}/lib" || ! -d "${candidate_libs}/include" ]]; then
  echo "Candidate libraries are incomplete: ${candidate_libs}" >&2
  exit 1
fi

smoke_root="$(mktemp -d "${TMPDIR:-/tmp}/sindarin-libs-consumer.XXXXXX")"
trap 'cmake -E rm -rf "${smoke_root}"' EXIT
consumer_dir="${smoke_root}/sindarin-compiler"

echo "Checking ${PLATFORM}-${ARCH} libraries against sindarin-compiler..."
git clone --depth 1 --branch "${CONSUMER_REF:-main}" \
  https://github.com/SindarinSDK/sindarin-compiler.git "${consumer_dir}"

(
  cd "${consumer_dir}"
  sn --install
)

consumer_libs="${consumer_dir}/.sn/sindarin-pkg-libs/libs/${PLATFORM}"
cmake -E rm -rf "${consumer_libs}"
cmake -E make_directory "${consumer_libs}"
cmake -E copy_directory "${candidate_libs}" "${consumer_libs}"

compiler="gcc"
cmake_extra=()
if [[ "${PLATFORM}" == "windows" || "${PLATFORM}" == "darwin" ]]; then
  compiler="clang"
fi
if [[ "${PLATFORM}" == "darwin" && "${ARCH}" == "x64" ]]; then
  cmake_extra+=("-DCMAKE_OSX_ARCHITECTURES=x86_64")
fi

cmake -S "${consumer_dir}" -B "${consumer_dir}/build-smoke" -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER="${compiler}" \
  "${cmake_extra[@]}"
cmake --build "${consumer_dir}/build-smoke" --target sn tests

echo "Compiler consumer smoke test passed for ${PLATFORM}-${ARCH}."
