#!/usr/bin/env bash

# This file is part of the ArchyPie project.
#
# Please see the LICENSE file at the top-level directory of this distribution.

rp_module_id="lr-desmume"
rp_module_desc="Nintendo DS Libretro Core"
rp_module_help="ROM Extensions: .nds .zip\n\nCopy Nintendo DS ROMs To: ${romdir}/nds"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/desmume/master/desmume/COPYING"
rp_module_repo="git https://github.com/libretro/desmume master"
rp_module_section="exp"

function depends_lr-desmume() {
    local depends=(
        'libpcap'
        'mesa'
    )
    getDepends "${depends[@]}"
}

function sources_lr-desmume() {
    gitPullOrClone
}

function build_lr-desmume() {
    local params=()
    isPlatform "arm" && params+=("platform=unixarmvhardfloat")
    isPlatform "aarch64" && params+=("DESMUME_JIT=0")

    make -C desmume/src/frontend/libretro clean
    make -C desmume/src/frontend/libretro -f Makefile.libretro "${params[@]}"

    md_ret_require="${md_build}/desmume/src/frontend/libretro/desmume_libretro.so"
}

function install_lr-desmume() {
    md_ret_files=('desmume/src/frontend/libretro/desmume_libretro.so')
}

function configure_lr-desmume() {
    mkRomDir "nds"

    defaultRAConfig "nds"

    addEmulator 0 "${md_id}" "nds" "${md_inst}/desmume_libretro.so"

    addSystem "nds"
}
