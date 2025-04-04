-- Github copilot
return {
    'zbirenbaum/copilot.lua',
    dependencies = {
        { 'zbirenbaum/copilot-cmp', opts = {} },
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    keys = {
        { '<leader>Cp', '<cmd>Copilot panel<cr>', desc = 'Open [C]opilot [p]anel' },
        { '<leader>Ct', '<cmd>Copilot toggle<cr>', desc = '[C]opilot [t]oggle' },
    },
    opts = {
        panel = {
            layout = {
                position = 'right',
            },
        },
    },
}
