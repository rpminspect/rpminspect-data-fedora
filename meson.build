project('rpminspect-data-fedora',
        version : '1.15',
        license : 'CC-BY-SA-4.0',
        meson_version : '>=0.47.0')

# Install data files
install_subdir(
    'abi',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'capabilities',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'politics',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'fileinfo',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'icons',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'profiles',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'rebaseable',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'remedy',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'security',
    install_dir : get_option('datadir') + '/rpminspect'
)

# Install the configuration file
install_data(
    sources : 'fedora.yaml',
    install_dir : get_option('datadir') + '/rpminspect'
)

# Install scripts
install_data(
    sources : 'rpminspect-fedora',
    install_dir : get_option('bindir'),
    install_mode : 'rwxr-xr-x'
)
