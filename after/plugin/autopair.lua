local npairs = require('nvim-autopairs')
local cmp = require('cmp')

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},
        javascript = {'template_string'},
        java = false,
    }
})

-- Integration with nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())