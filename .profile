# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 027

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Extend PATH with additional directories if they exist.
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/files/code/scripts/private" ] ; then
    export PATH="$HOME/files/code/scripts/private:$PATH"
fi
if [ -f /usr/local/bin/arduino/arduino-1.0.5/hardware/tools/avr/bin ]; then
  export PATH="$PATH:/usr/local/bin/arduino/arduino-1.0.5/hardware/tools/avr/bin"
fi
if [ -f /home/jody/bin/node-v8.11.3-linux-x64/bin/ ]; then
  export PATH="$PATH:/home/jody/bin/node-v8.11.3-linux-x64/bin/"
fi
if [ -f /home/jody/bin/flutter/bin/ ]; then
  export PATH="$PATH:/home/jody/bin/flutter/bin/"
fi

# PYTHONPATH, SITEPATH, and SCANNER_URL should be set in /etc/environment

export EDITOR="/usr/bin/vim"
export SVN_EDITOR="/usr/bin/vim"


