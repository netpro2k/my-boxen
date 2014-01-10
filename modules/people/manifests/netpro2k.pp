class people::jbarnette {
  include zsh
  include phantomjs

  include chrome
  include chrome:canary
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
  nodejs::module { 'js2cofee': node_version => 'v0.10' }
  nodejs::module { 'karma': node_version => 'v0.10' }

  # Homebrew packages
  package {
    [
      "ant",
      "ffmpeg",
      "ios-sim",
      "tig",
      "wget",
      "z",
      "zsh"
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
      "omnidisksweeeper",
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
    source => "${::github_user}/dotfiles"
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
}