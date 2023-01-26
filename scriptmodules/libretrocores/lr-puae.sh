#!/usr/bin/env bash

# This file is part of the ArchyPie project.
#
# Please see the LICENSE file at the top-level directory of this distribution.

rp_module_id="lr-puae"
rp_module_desc="Commodore Amiga 500, 500+, 600, 1200, 4000, CDTV & CD32 Libretro Core"
rp_module_help="ROM Extensions: .7z .adf .adz .ccd .chd .cue .dms .fdi .hdf .hdz .info .ipf .iso .lha .m3u .mds .nrg .slave .uae .zip\n\nCopy Amiga Games To: ${romdir}/amiga\n\nCopy BIOS Files:\n\nkick13.rom\nkick20.rom\nkick31.rom\n\nTo: ${biosdir}/amiga"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/PUAE/master/COPYING"
rp_module_repo="git https://github.com/libretro/libretro-uae master"
rp_module_section="opt"

function sources_lr-puae() {
    gitPullOrClone

    _sources_capsimg
}

function build_lr-puae() {
    _build_capsimg

    cd "${md_build}" || exit
    make clean
    make LDFLAGS="${LDFLAGS} -Wl,-rpath='${md_inst}'"
    md_ret_require="${md_build}/puae_libretro.so"
}

function install_lr-puae() {
    md_ret_files=(
        'puae_libretro.so'
        'README.md'
        'sources/uae_data'
    )
    if [[ ! -f "${biosdir}amiga/capsimg.so" ]]; then
        cp "${md_build}/capsimg/CAPSImg/capsimg.so" "${biosdir}/amiga"
    fi
}

function configure_lr-puae() {
    mkRomDir "amiga"

    defaultRAConfig "amiga" "system_directory" "${biosdir}/amiga"

    addEmulator 1 "${md_id}" "amiga" "${md_inst}/puae_libretro.so"

    addSystem "amiga"
    addSystem "cd32"
    addSystem "cdtv"
}
