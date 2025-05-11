fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_script 'config.lua'

client_scripts {
	'@es_extended/imports.lua',
    'client/main.lua'
}

server_scripts {
	'@es_extended/imports.lua',
	'@mysql-async/lib/MySQL.lua',
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

escrow_ignore {
	'config.lua'
}

dependency 'es_extended'