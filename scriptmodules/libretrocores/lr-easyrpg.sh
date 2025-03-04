#!/usr/bin/env bash

# This file is part of the ArchyPie project.
#
# Please see the LICENSE file at the top-level directory of this distribution.

rp_module_id="lr-easyrpg"
rp_module_desc="EasyRPG Libretro Core"
rp_module_help="ROM Extensions: .easyrpg .squashfs .zip\n\nCopy RPG Maker Games To: ${romdir}/easyrpg"
rp_module_licence="GPL3 https://raw.githubusercontent.com/EasyRPG/Player/master/COPYING"
rp_module_repo="git https://github.com/EasyRPG/Player master"
rp_module_section="opt"

function depends_lr-easyrpg() {
    local depends=(
        'cmake'
        'ninja'
        'wildmidi'
    )
    getDepends "${depends[@]}"
}

function sources_lr-easyrpg() {
    gitPullOrClone
}

function build_lr-easyrpg() {
    cmake . \
        -B"build" \
        -G"Ninja" \
        -DCMAKE_BUILD_RPATH_USE_ORIGIN="ON" \
        -DCMAKE_BUILD_TYPE="Release" \
        -DCMAKE_INSTALL_PREFIX="${md_inst}" \
        -DBUILD_SHARED_LIBS="ON" \
        -DPLAYER_BUILD_LIBLCF="ON" \
        -DPLAYER_TARGET_PLATFORM="libretro" \
        -Wno-dev
    ninja -C build clean
    ninja -C build
    md_ret_require="${md_build}/build/easyrpg_libretro.so"
}

function install_lr-easyrpg() {
    md_ret_files=('build/easyrpg_libretro.so')
}

function configure_lr-easyrpg() {
    mkRomDir "easyrpg"

    defaultRAConfig "easyrpg"

    addEmulator 1 "${md_id}" "easyrpg" "${md_inst}/easyrpg_libretro.so"

    addSystem "easyrpg"
}
