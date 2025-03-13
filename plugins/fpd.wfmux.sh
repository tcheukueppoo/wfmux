add_plug fpd
add_plug pd

opt_wfmux_fpd () {
   tmux_or_die

   requires fzf perldoc fzfperldoc
}

opt_wfmux_pd () {
   tmux_or_die

   requires fzf perldoc stest

   cache="$HOME/.cache/wfmux_pd_pm_files"
   lib_dirs=$(perl -E 'say "$_" foreach @INC')

   IFS='
'
   if stest -qdr -n "$cache" $lib_dirs \
   || test -n "$(find $lib_dirs -type d -cnewer "$cache")" ; then

      for lib_dir in $lib_dirs ; do
         pms=$(find "$lib_dir" -type f -iname '*.pm' | perl -pE "s#^\Q$lib_dir\E/?+(.+)\.pm\$#\$1#;s#/#::#g;")
         lib_pms="${lib_pms:-}${lib_pms:+$IFS}${pms}"
      done

      lib_pms=$(printf '%s\n' "$lib_pms" | uniq | tee -a "$cache")
   else
      lib_pms=$(cat "$cache")
   fi

   pm=$(printf '%s\n' "$lib_pms" | fzf)
   run_cmd "perldoc $pm" true
}
