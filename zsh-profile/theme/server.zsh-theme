# by: superzerosec
# user, host, full path, and time/date on two lines for easier vgrepping

function hg_prompt_info {
  if (( $+commands[hg] )) && grep -q "prompt" ~/.hgrc; then
    hg prompt --angle-brackets "\
<hg:%{$fg[magenta]%}<branch>%{$reset_color%}><:%{$fg[magenta]%}<bookmark>%{$reset_color%}>\
</%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
  fi
}

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[green]%}$ZSH_THEME_GIT_PROMPT_SUFFIX "
  fi
}

function retcode() {}

# alternate prompt with git & hg
PROMPT=$'%{$fg_bold[red]%}┌─[%{$fg_bold[green]%}%n%b%{$fg_bold[white]%}@%{$fg_bold[cyan]%}%m%{$fg_bold[red]%}]%{$reset_color%} %{$fg_bold[red]%}[%{$fg_bold[white]%}%~%{$fg_bold[red]%}]%{$reset_color%}
%{$fg_bold[red]%}└-[%{$fg_bold[blue]%}%{$fg_bold[magenta]%}%?$(retcode)%{$fg_bold[red]%}]$(mygit)$(hg_prompt_info)>%{$reset_color%} '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

# change LS colour
LS_COLORS="di=1;36"
