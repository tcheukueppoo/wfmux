add_plug codeberg
add_plug fcodeberg
add_plug github 
add_plug fgithub

opt_wfmux_codeberg  () { git_push codeberg --set-upstream; }
opt_wfmux_fcodeberg () { git_push codeberg --set-upstream --force; }
opt_wfmux_github    () { git_push github   --set-upstream; }
opt_wfmux_fgithub   () { git_push github   --set-upstream --force; }

git_push () {
   tmux_or_die

   requires git

   proj_dir=$(get_proj_dir "$(tmux_cur_session)")
   test -z "$proj_dir" && die_not_wfmux

   cd -L "$proj_dir"

   is_git_repository || return

   upstream=$1; shift
   if   [ "$upstream" = github ] ; then
      test -z "${GITHUB_TOKEN:-}" && wfmux_die "Var 'GITHUB_TOKEN' is unset"
      git_url="https://${GITHUB_TOKEN}@github.com"

   elif [ "$upstream" = codeberg ] ; then
      test -z "${CODEBERG_TOKEN:-}" && wfmux_die "Var 'CODEBERG_TOKEN' is unset"
      git_url="https://${CODEBERG_TOKEN}@codeberg.org"

   else
      wfmux_die 'Unsupported upstream!'
   fi

   name_file=".wfmux/$upstream"
   test -s "$name_file" && read user_name <"$name_file"
   test -z "${user_name:-}" && {
      printf "username ($upstream): "
      read user_name
   }

   test -z "$user_name" && return
   say "$user_name" >"$name_file"

   proj_name=$(basename "$proj_dir")
   cbranch=$(git branch --show-current)

   git push "$@" "$git_url/$user_name/$proj_name" "$cbranch"
   read _
}

add_plug push
add_plug fpush

opt_wfmux_push  () { git_push_remote --set-upstream; }
opt_wfmux_fpush () { git_push_remote --set-upstream --force; }

git_push_remote () {
   tmux_or_die

   requires git

   is_git_repository || return

   remotes=$(git remote show)
   test -z "$remotes" && wfmux_die 'No configured remote!'

   remote=$(say "$remotes" | eval "$MENU")
   test -z "$remote" && return

   cbranch=$(git branch --show-current)
   git push "$@" "$remote" "$cbranch"
   read _
}
