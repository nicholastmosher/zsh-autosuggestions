
#--------------------------------------------------------------------#
# Match Most Frequented Commands in the given Directory              #
#--------------------------------------------------------------------#
#
# Keeps a record of which commands were executed from which directories
# and how many times that command has occurred there. Typing commands
# will search for the most frequent occurrence of the prefix in the
# current directory.

_zsh_autosuggest_record_command() {
	local command="$1"
	local path="$(pwd)"

	$($ZSH_CUSTOM/plugins/zsh-autosuggestions/autofish add $command $path)
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _zsh_autosuggest_record_command

_zsh_autosuggest_strategy_autofish() {
	local prefix="$1"
	local path="$(pwd)"
	local suggestion = "$($ZSH_CUSTOM/plugins/zsh-autosuggestions/autofish get $prefix $path)"

	# If there is no suggestion, fall back to default strategy.
	if [ -z "$suggestion" ] && [ "${suggestion+x}" = "x" ]; then
		echo -E _zsh_autosuggest_strategy_default $prefix
	else
		echo -E $suggestion
	fi
}
