#!/usr/bin/env bash

# This file is part of the ArchyPie project.
#
# Please see the LICENSE file at the top-level directory of this distribution.

rp_module_id="lr-smsplus-gx"
rp_module_desc="Sega Master System & Game Gear Libretro Core"
rp_module_help="ROM Extensions: .bin .col .gg .rom .sg .sms .zip\nCopy Game Gear ROMs To: ${romdir}/gamegear\nCopy MasterSystem ROMs To: ${romdir}/mastersystem"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/smsplus-gx/master/docs/license"
rp_module_repo="git https://github.com/libretro/smsplus-gx master"
rp_module_section="exp"

function sources_lr-smsplus-gx() {
    gitPullOrClone
}

function build_lr-smsplus-gx() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro
    md_ret_require="${md_build}/smsplus_libretro.so"
}

function install_lr-smsplus-gx() {
    md_ret_files=('smsplus_libretro.so')
}

function configure_lr-smsplus-gx() {
    local system
    for system in gamegear mastersystem; do
        mkRomDir "${system}"
        defaultRAConfig "${system}"
        addEmulator 0 "${md_id}" "${system}" "${md_inst}/smsplus_libretro.so"
        addSystem "${system}"
    done
}
