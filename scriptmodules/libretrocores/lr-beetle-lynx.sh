#!/usr/bin/env bash

# This file is part of the ArchyPie project.
#
# Please see the LICENSE file at the top-level directory of this distribution.

rp_module_id="lr-beetle-lynx"
rp_module_desc="Atari Lynx Libretro Core"
rp_module_help="ROM Extensions: .lnx .zip\n\nCopy Atari Lynx ROMs To: ${romdir}/atarilynx\n\nCopy BIOS File (lynxboot.img) To: ${biosdir}/atarilynx"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-lynx-libretro/master/COPYING"
rp_module_repo="git https://github.com/libretro/beetle-lynx-libretro master"
rp_module_section="opt"

function sources_lr-beetle-lynx() {
    gitPullOrClone
}

function build_lr-beetle-lynx() {
    make clean
    make
    md_ret_require="${md_build}/mednafen_lynx_libretro.so"
}

function install_lr-beetle-lynx() {
    md_ret_files=('mednafen_lynx_libretro.so')
}

function configure_lr-beetle-lynx() {
    if [[ "${md_mode}" == "install" ]]; then
        mkRomDir "atarilynx"

        mkUserDir "${biosdir}/atarilynx"
    fi

    defaultRAConfig "atarilynx" "system_directory" "${biosdir}/atarilynx"

    addEmulator 0 "${md_id}" "atarilynx" "${md_inst}/mednafen_lynx_libretro.so"

    addSystem "atarilynx"
}
