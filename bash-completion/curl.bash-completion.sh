_complete_curl_hosts () {
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	comp_curl_hosts="localhost https://localhost localhost: https://localhost: intersight.com https://intersight.com"
	COMPREPLY=( $(compgen -W "${comp_curl_hosts}" -- $cur))
	return 0
}
complete -F _complete_curl_hosts curl
