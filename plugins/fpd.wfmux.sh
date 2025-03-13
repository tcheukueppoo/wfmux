add_plug pd
add_plug spd

fzfdoc () {
   requires fzf stest

   cache="$HOME/.cache/wfmux_pd_pm_files"
   dirs=$(perl -E 'say "$_" foreach @INC')

   OIFS=$IFS IFS='
'
   if stest -qdr -n "$cache" $dirs \
   || test -n "$(find $dirs -type d -cnewer "$cache")" ; then

      for dir in $dirs ; do
         dir_reg="${dir_reg:-}${dir_reg:+|}\Q$dir\E"
      done
      pms=$(find $dirs -type f -iname '*.pm' | perl -pE "s#^(?:$dir_reg)/?+(.+)\.pm\$#\$1#;s#/#::#g;")
      pms=$(printf '%s\n' "$pms" | sort -u | tee -a "$cache")
   else
      pms=$(cat "$cache")
   fi

   printf '%s\n' "$pms" | fzf
   IFS=$OIFS
}


opt_wfmux_pd () {
   tmux_or_die

   requires perldoc

   pm=$(fzfdoc)
   test -n "$pm" && run_cmd "perldoc $pm" true
}

opt_wfmux_spd () {
   tmux_or_die

   requires perldoc fzfperldoc

   pm=$(fzfdoc)
   test -z "$pm" && return

   printf 'Search: '
   read search

   IFS='
'
   fzfperldoc "$pm" $search
}
