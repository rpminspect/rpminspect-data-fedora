project('rpminspect-data-fedora',
        version : '1.1',
        license : 'GPLv3+',
        meson_version : '>=0.47.0')

# Install data files
install_subdir(
    'abi-checking-whitelist',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'capabilities',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'licenses',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'political-whitelist',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'fileinfo',
    install_dir : get_option('datadir') + '/rpminspect'
)
install_subdir(
    'version-whitelist',
    install_dir : get_option('datadir') + '/rpminspect'
)

# Install the configuration file
install_data(
    sources : 'fedora.yaml',
    install_dir : get_option('datadir') + '/rpminspect'
)

install_subdir(
    'profiles',
    install_dir : get_option('datadir') + '/rpminspect'
)

# Install scripts
install_data(
    sources : 'rpminspect-fedora',
    install_dir : get_option('bindir'),
    install_mode : 'rwxrwxrwx'
)
