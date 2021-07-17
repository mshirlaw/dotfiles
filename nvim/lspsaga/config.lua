local saga = require 'lspsaga'

local signs = { 
    error = " ",
    warning = " ",
    hint = " ",
    information = " ", 
    code = " " 
}

saga.init_lsp_saga {
    error_sign = signs.error,
    warn_sign = signs.warning,
    hint_sign = signs.hint,
    infor_sign = signs.information,
    code_action_icon = signs.code,
    code_action_keys = { quit = 'q',exec = '<CR>' }
}


