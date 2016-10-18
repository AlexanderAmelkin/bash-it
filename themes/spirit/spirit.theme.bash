# Spirit Bash Prompt Theme, inspired by "Sexy Bash Prompt"
# vim: set ts=2 sw=2 et :

if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
fi

if tput setaf 1 &> /dev/null; then
  BOLD="\[$(tput bold)\]"
  RESET="\[$(tput sgr0)\]"
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    RED="\[$(tput setaf 160)\]"
    LBLUE="\[$(tput setaf 74)\]"
    ORANGE="\[$(tput setaf 172)\]"
    YELLOW="\[$(tput setaf 190)\]"
    GREEN="\[$(tput setaf 2)\]"
    LGREEN="\[$(tput setaf 118)\]"
    PURPLE="\[$(tput setaf 141)\]"
    BLACK="\[$(tput setaf 0)\]"
  else
    RED="\[$(tput setaf 1)\]"
    GREEN="\[$(tput setaf 2)\]"
    YELLOW="\[$(tput setaf 3)\]"
    PURPLE="\[$(tput setaf 5)\]"
    CYAN="\[$(tput setaf 6)\]"
    BLACK="\[$(tput setaf 0)\]"

    LBLUE=$CYAN
    LGREEN=$GREEN$BOLD
    ORANGE=$YELLOW
  fi
else
  RED="\[\e[1;31m\]"
  GREEN="\[\e[1;32m\]"
  YELLOW="\[\e[1;33m\]"
  PURPLE="\[\e[1;35m\]"
  CYAN="\[\e[1;36m\]"
  BLACK="\[\e[0;30m\]"
  BOLD="\[\e[1m\]"
  RESET="\[\e[m\]"

  LBLUE=$CYAN
  ORANGE=$YELLOW
fi
DGRAY=${BLACK}${BOLD}

SCM_THEME_PROMPT_DIRTY=" ${RED}✗"
SCM_THEME_PROMPT_CLEAN=" ${LGREEN}✓"
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_GIT_CHAR="git"
SCM_SVN_CHAR="svn"
SCM_HG_CHAR="hg"

_spirit_scm_prompt() {
  CHAR=$(scm_char)
  if [ $CHAR = $SCM_NONE_CHAR ]
  then
    return
  else
    echo " ${LBLUE}[$(scm_char)] ${PURPLE}[$(scm_prompt_info)${PURPLE}]${RESET}"
  fi
}

function _check_err() {
  EXIT=$?
  if [ $EXIT -eq 0 ]; then
    EXIT="${GREEN}✓$RESET"
  else
    EXIT="${RED}$EXIT$RESET"
  fi
  echo -e "$EXIT"
}

function _prompt_command() {
  PS1="[$(_check_err)] $LBLUE\u${DGRAY} at $ORANGE\h ${DGRAY}in $YELLOW\w$RESET$(_spirit_scm_prompt)\n$DGRAY\$ $RESET"
  PS2="> "
  PS3=">> "
}

PROMPT_COMMAND=_prompt_command
