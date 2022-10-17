set -gx OSTYPE (uname -s)
if [ $OSTYPE = 'Linux' -a -e /etc/wsl.conf ]
  set -gx OSTYPE WSL
end

if [ $OSTYPE = "Darwin" ]
  set -gx HOMEBREW_PREFIX "/opt/homebrew"
  set -gx HOMEBREW_NO_ENV_HINTS true
  set -gx CPPFLAGS "$CPPFLAGS -I $HOMEBREW_PREFIX/include"
  set -gx LDFLAGS "$LDFLAGS -L $HOMEBREW_PREFIX/lib"
  eval ($HOMEBREW_PREFIX/bin/brew shellenv)
end

if [ $OSTYPE = "WSL" ]
  set -xp PATH /snap/bin
  set -xp PATH '/mnt/c/Users/me/AppData/Local/Programs/Microsoft VS Code/bin/'


  set -x HOST_IP (ip route |awk '/^default/{print $3}')
  set -x PULSE_SERVER "tcp:$HOST_IP"
  set -x DISPLAY "$HOST_IP:0.0"
end
