class people::netpro2k {
  include zsh
  include phantomjs

  include chrome
  include chrome::canary
  include firefox

  include sublime_text_3
  include sublime_text_3::package_control

  # Set global node version
  class { 'nodejs::global': version => 'v0.10.0' }

  # Install Global NPM Modules
  nodejs::module { 'bower': node_version => 'v0.10' }
  nodejs::module { 'browserify': node_version => 'v0.10' }
  nodejs::module { 'brunch': node_version => 'v0.10' }
  nodejs::module { 'coffee-script': node_version => 'v0.10' }
  nodejs::module { 'cordova': node_version => 'v0.10' }
  nodejs::module { 'grunt-cli': node_version => 'v0.10' }
  nodejs::module { 'heroku': node_version => 'v0.10' }
  nodejs::module { 'js2coffee': node_version => 'v0.10' }
  nodejs::module { 'karma': node_version => 'v0.10' }

  # Homebrew packages
  package {
    [
      "ant",
      "ffmpeg",
      "ios-sim",
      "tig",
      "wget",
      "z"
    ]:
  }

  # Install brew-cask apps
  include brewcask
  package { 
    [
      "alfred",
      "android-file-transfer",
      "charles",
      "cloudapp",
      "crashplan",
      "cyberduck",
      "harvest",
      "linein",
      "mplayerx",
      "mumble",
      "google-music-manager",
      "omnidisksweeper",
      "plex-home-theater",
      "skype",
      "slate",
      "steam",
      "the-unarchiver",
      "unity3d",
      "vlc",
      "iterm2"
    ]: provider => 'brewcask' 
  }

  # Dotfiles
  $home = "/Users/${::boxen_user}"
  $dotfiles_dir = "${boxen::config::srcdir}/dotfiles"
  $ohMyZsh = "robbyrussell/oh-my-zsh"
  $prefDir = "${home}/Library/Preferences"

  repository { $dotfiles_dir:
    source => "netpro2k/dotfiles"
  }
  repository { $ohMyZsh:
    source => 'robbyrussell/oh-my-zsh',
    path   => "${home}/.oh-my-zsh"
  }
  file { "${home}/.oh-my-zsh/themes/netpro2k.zsh-theme":
    ensure  => link,
    target  => "${dotfiles_dir}/netpro2k.zsh-theme",
    require => [Repository[$dotfiles_dir], Repository[$ohMyZsh]]
  }

  file { "${home}/.zshrc":
    ensure  => link,
    target  => "${dotfiles_dir}/zshrc",
    require => Repository[$dotfiles_dir]
  }
  file { "${home}/.gitconfig":
    ensure  => link,
    target  => "${dotfiles_dir}/gitconfig",
    require => Repository[$dotfiles_dir]
  }
  file { "${home}/.gvimrc":
    ensure  => link,
    target  => "${dotfiles_dir}/gvimrc",
    require => Repository[$dotfiles_dir]
  }
  file { "${home}/.tigrc":
    ensure  => link,
    target  => "${dotfiles_dir}/tigrc",
    require => Repository[$dotfiles_dir]
  }
  file { "${home}/.vim":
    ensure  => link,
    target  => "${dotfiles_dir}/vim",
    require => Repository[$dotfiles_dir]
  }
  file { "${home}/.vimrc":
    ensure  => link,
    target  => "${dotfiles_dir}/vimrc",
    require => Repository[$dotfiles_dir]
  }
  file { "${prefDir}/com.alfredapp.Alfred.plist":
    ensure  => link,
    target  => "${dotfiles_dir}/Preferences/com.alfredapp.Alfred.plist",
    require => Repository[$dotfiles_dir]
  }
  file { "${prefDir}/com.googlecode.iterm2.plist":
    ensure  => link,
    target  => "${dotfiles_dir}/Preferences/com.googlecode.iterm2.plist",
    require => Repository[$dotfiles_dir]
  }

  # osx prefs
  include osx::global::disable_key_press_and_hold
  include osx::global::enable_keyboard_control_access
  include osx::global::expand_print_dialog
  include osx::global::expand_save_dialog
  include osx::global::disable_remote_control_ir_receiver
  include osx::global::disable_autocorrect

  include osx::dock::autohide
  include osx::dock::clear_dock
  include osx::dock::dim_hidden_apps
  include osx::dock::hide_indicator_lights

  include osx::finder::show_external_hard_drives_on_desktop
  include osx::finder::show_mounted_servers_on_desktop
  include osx::finder::show_removable_media_on_desktop
  include osx::finder::empty_trash_securely
  include osx::finder::unhide_library
  include osx::finder::show_hidden_files
  include osx::finder::enable_quicklook_text_selection

  include osx::universal_access::ctrl_mod_zoom
  include osx::universal_access::enable_scrollwheel_zoom

  include osx::disable_app_quarantine
  include osx::no_network_dsstores
  include osx::software_update

  boxen::osx_defaults { 'Disable bar transparency':
    ensure => present,
    domain => 'NSGlobalDomain',
    key    => 'AppleEnableMenuBarTransparency',
    value  => false,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Save to disk (not to iCloud) by default':
    ensure => present,
    domain => 'NSGlobalDomain',
    key    => 'NSDocumentSaveNewDocumentsToCloud',
    value  => false,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Disable smart quotes':
    ensure => present,
    domain => 'NSGlobalDomain',
    key    => 'NSAutomaticQuoteSubstitutionEnabled',
    value  => false,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Show finder status bar':
    ensure => present,
    domain => 'com.apple.finder',
    key    => 'ShowStatusBar',
    value  => true,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Show finder path bar':
    ensure => present,
    domain => 'com.apple.finder',
    key    => 'ShowPathbar',
    value  => true,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Show full path in finder title':
    ensure => present,
    domain => 'com.apple.finder',
    key    => '_FXShowPosixPathInTitle',
    value  => true,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Search current folder by default':
    ensure => present,
    domain => 'com.apple.finder',
    key    => 'FXDefaultSearchScope',
    value  => 'SCcf',
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Disable warning when changing file extensions':
    ensure => present,
    domain => 'com.apple.finder',
    key    => 'FXEnableExtensionChangeWarning',
    value  => false,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Enable springlaoded folders':
    ensure => present,
    domain => 'NSGlobalDomain',
    key    => 'com.apple.springing.enabled',
    value  => true,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Auto open window for new disks':
    ensure => present,
    domain => 'com.apple.frameworks.diskimages',
    key    => 'auto-open-ro-root',
    value  => true,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Auto open window for new disks 2':
    ensure => present,
    domain => 'com.apple.frameworks.diskimages',
    key    => 'auto-open-rw-root',
    value  => true,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Auto open window for new disks 3':
    ensure => present,
    domain => 'com.apple.finder',
    key    => 'OpenWindowForNewRemovableDisk',
    value  => true,
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Use column view by default':
    ensure => present,
    domain => 'com.apple.finder',
    key    => 'FXPreferredViewStyle',
    value  => 'clmv',
    user   => $::boxen_user;
  }
  boxen::osx_defaults { 'Enable safari debug menu':
    ensure => present,
    domain => 'com.apple.Safari',
    key    => 'IncludeInternalDebugMenu',
    value  => true,
    user   => $::boxen_user;
  }
}