#!/usr/bin/env bash

# This file is part of the ArchyPie project.
#
# Please see the LICENSE file at the top-level directory of this distribution.

rp_module_id="lr-atari800"
rp_module_desc="Atari 5200, 400, 800, XL & XE Libretro Core"
rp_module_help="ROM Extensions: .a52 .atr .bas .bin .car .cas .cdm .com .dcm .xex .xfd .zip\n\nCopy Atari800 Games To: ${romdir}/atari800\n\nCopy Atari 5200 ROMs To: ${romdir}/atari5200Copy Atari800 Games To: ${romdir}/atari800\n\nCopy Atari 5200 ROMs To: ${romdir}/atari5200\n\nCopy BIOS Files:\n\n5200.ROM\nATARIBAS.ROM\nATARIOSB.ROM\nATARIXL.ROM\n\nTo: ${biosdir}\atari800"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/libretro-atari800/master/atari800/COPYING"
rp_module_repo="git https://github.com/libretro/libretro-atari800 master"
rp_module_section="main"

function sources_lr-atari800() {
    gitPullOrClone

    # Set Default Config Path(s)
    applyPatch "${md_data}/01_set_default_config_path.patch"
}

function build_lr-atari800() {
    make clean
    make
    md_ret_require="${md_build}/atari800_libretro.so"
}

function install_lr-atari800() {
    md_ret_files=(
        'atari800_libretro.so'
        'atari800/COPYING'
    )
}

function configure_lr-atari800() {
    moveConfigDir "${arpdir}/${md_id}" "${md_conf_root}/atari800/${md_id}"

    if [[ "${md_mode}" == "install" ]]; then
        mkRomDir "atari800"
        mkRomDir "atari5200"

        mkUserDir "${biosdir}/atari800"
    fi

    defaultRAConfig "atari800" "system_directory" "${biosdir}/atari800"
    defaultRAConfig "atari5200" "system_directory" "${biosdir}/atari800"

    addEmulator 1 "lr-atari800" "atari800" "${md_inst}/atari800_libretro.so"
    addEmulator 1 "lr-atari800" "atari5200" "${md_inst}/atari800_libretro.so"

    addSystem "atari800"
    addSystem "atari5200"
}
