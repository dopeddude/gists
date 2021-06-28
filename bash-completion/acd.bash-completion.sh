_complete_repo_name () {
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	comp_ccd_an_dirs=$(ls ${HOME}/go/src/bitbucket-eng-sjc1.cisco.com/an)
	repos=""
	for i in ${comp_ccd_an_dirs}
	do
		i=${i#ui-an-}
		i=${i#ucs-}
		repos="${repos} ${i}"
	done
	comp_bitbucket_context_paths="branches browse commits compare pull-requests pull-requests?create"
	if [ "${COMP_CWORD}" == "2" ];then
		comp_suggestions="${comp_bitbucket_context_paths}"
	else
		comp_suggestions="${repos}"
	fi
	COMPREPLY=( $(compgen -W "${comp_suggestions}" -- $cur))
	return 0
}
complete -F _complete_repo_name icd bb
