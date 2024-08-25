fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
name 'ys_randoldadheist'
author 'Yeet, Snowy, Redacted and obviously Randolio\'s Dad'
version '1.0.0'
repository 'https://github.com/YeeetSK/ys_randoldadheist'
description 'Play as Randolio, searching for his dad who left to get milk, while facing debuffs that make your journey more difficult.'

dependencies {
    'oxmysql',
    'ox_lib',
}


shared_scripts {
    '@ox_lib/init.lua',
    'init.lua',
}


server_script '@oxmysql/lib/MySQL.lua'

files {
    'client/main.lua',
    'modules/missions/loader.lua',
    'modules/missions/data/**.lua',
    'modules/bridge/**/**.lua'
}

escrow_ignore {
    'config.lua'
}