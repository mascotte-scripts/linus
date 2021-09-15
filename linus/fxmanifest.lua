fx_version 'cerulean'
game 'gta5'

client_scripts { 
    
    'client/cl_cache',
    'client/misc.lua',
    'client/cl_functions.lua',
    'client/cl_events.lua',
    'client/cl_main.lua'

} 

server_scripts {

    'server/misc.lua',
    'server/sv_functions.lua',
    'server/sv_events.lua',
    'server/sv_server.lua'
}

shared_script 'shared/import.lua'

ui_page "html/index.html"

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css',
    'html/assets/*.png'
}
