local saga = require 'lspsaga'

saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    code_action_icon = ' ',
    code_action_keys = { quit = 'q',exec = '<CR>' }
}

