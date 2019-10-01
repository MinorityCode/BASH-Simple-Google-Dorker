#!/bin/bash
GetToken(){
	goks=$( curl -s --compressed \
	--url "https://cse.google.com/cse.js?cx=partner-pub-2698861478625135:3033704849" \
	-H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36')
	cse_toked=$( echo $goks | awk -F 'cse_token": "' {'print $2'} | cut -d '"' -f1)
	Goaks
}
Goaks(){
	echo -n "Your Dork: "
	read dork
	dork=$(echo $dork | sed 's/ /+/g')
	for (( i = 1; i < 100; i++ )); do
		dorks=$( curl -s --compressed \
		--url 'https://cse.google.com/cse/element/v1?num=10&hl=en&cx=partner-pub-2698861478625135:3033704849&safe=off&cse_tok='$cse_toked'&start='$i'&q='$dork'&callback=x' \
		-H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36'
		)
		url=$( echo $dorks | awk -F 'unescapedUrl": "' {'print $2'} | cut -d '"' -f1)
		if [[ ! $url ]]; then
			echo "nothing here!"
			exit
		else
			echo "$url"
			echo "$url" >> res.txt
		fi
	done
}
GetToken
