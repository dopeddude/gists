_complete_ssh_hosts () {
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	comp_ssh_known_hosts=`cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | grep -v ^\# | uniq | grep -v "\["`
	comp_ssh_config_hosts=`cat ~/.ssh/config | grep --color=never "^Host " | awk '{print $2}'`
	comp_ssh_hosts="${comp_ssh_known_hosts} ${comp_ssh_config_hosts}"
	COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
	return 0
}
complete -F _complete_ssh_hosts ssh
