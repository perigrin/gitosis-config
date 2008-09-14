# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name 'Gitosis-Config';
all_from 'lib/Gitosis/Config.pm';

# Specific dependencies
requires 'Moose'       => '0.56';
requires 'Config::INI' => undef;

build_requires 'Test::More' => '0.42';

no_index 'directory' => 'ex';

auto_install;
WriteAll;
