#! /usr/bin/bash
#An script for sending Result or file to Discord OR Telegram
# Note This script required a Config file where Discord|Telegram's api are included or You can simply install notify tool .

#custom_config =~/.custom_path/config.yaml
CONFIG=~/.config/notify/provider-config.yaml

function send2td {
    
		if grep -q '^ telegram\|^telegram\|^    telegram' $CONFIG ; then
			telegram_chat_id=$(cat ${CONFIG} | grep '^    telegram_chat_id\|^telegram_chat_id\|^    telegram_chat_id' | xargs | cut -d' ' -f2)
			telegram_key=$(cat ${CONFIG} | grep '^    telegram_api_key\|^telegram_api_key\|^    telegram_apikey' | xargs | cut -d' ' -f2 )
			curl -F document=@${1} "https://api.telegram.org/bot${telegram_key}/sendDocument?chat_id=${telegram_chat_id}" &>/dev/null
		fi
		if grep -q '^ discord\|^discord\|^    discord' $CONFIG ; then
			discord_url=$(cat ${CONFIG} | grep '^ discord_webhook_url\|^discord_webhook_url\|^    discord_webhook_url' | xargs | cut -d' ' -f2)
			curl -v -i -H "Accept: application/json" -H "Content-Type: multipart/form-data" -X POST -F file1=@${1} $discord_url &>/dev/null
		fi
	
}
send2td $1
echo -e '\nSent Bro 😐'
