project('rpminspect-data-fedora',
        version : '1.5',
        license : 'CC-BY-SA-4.0',
        meson_version : '>=0.47.0')

# Perform any tests on data
license_keys_unique = find_program('license_keys_unique.sh')
test('license-keys-unique', license_keys_unique)

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
    'licenses',
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
    'rebaseable',
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
