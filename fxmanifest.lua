fx_version "cerulean"
game "gta5"
lua54 'yes'

author 'Your Dad'
description ''

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

escrow_ignore {
    'config.lua'
}
