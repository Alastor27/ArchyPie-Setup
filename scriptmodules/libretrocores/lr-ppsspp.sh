#!/usr/bin/env bash

# This file is part of the ArchyPie project.
#
# Please see the LICENSE file at the top-level directory of this distribution.

rp_module_id="lr-ppsspp"
rp_module_desc="Sony PlayStation Portable Libretro Core"
rp_module_help="ROM Extensions: .cso .elf .iso .pbp .prx\n\nCopy PlayStation Portable ROMs To: ${romdir}/psp"
rp_module_licence="GPL2 https://raw.githubusercontent.com/hrydgard/ppsspp/master/LICENSE.TXT"
rp_module_repo="git https://github.com/hrydgard/ppsspp :_get_branch_lr-ppsspp"
rp_module_section="opt"
rp_module_flags=""

function _get_branch_lr-ppsspp() {
    _get_branch_ppsspp
}

function depends_lr-ppsspp() {
    depends_ppsspp
}

function sources_lr-ppsspp() {
    sources_ppsspp

    # Set BIOS Directory
    sed -e "s|retro_base_dir /= \"PPSSPP\";|retro_base_dir /= \"psp\";|g" -i "${md_build}/libretro/libretro.cpp"
}

function build_lr-ppsspp() {
    build_ppsspp
}

function install_lr-ppsspp() {
    md_ret_files=(
        'build/assets'
        'build/lib/ppsspp_libretro.so'
    )
}

function configure_lr-ppsspp() {
    if [[ "${md_mode}" == "install" ]]; then
        mkRomDir "psp"

        mkUserDir "${biosdir}/psp"

        # Copy Assets
        cp -Rv "${md_inst}/assets/"* "${biosdir}/psp/"
        chown -R "${user}:${user}" "${biosdir}/psp"
    fi

    defaultRAConfig "psp"

    addEmulator 1 "${md_id}" "psp" "${md_inst}/ppsspp_libretro.so"

    addSystem "psp"
}
