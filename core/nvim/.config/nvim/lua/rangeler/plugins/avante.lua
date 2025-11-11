return {
    'yetone/avante.nvim',
    build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
    event = 'VeryLazy',
    version = false,
    opts = {
        instructions_file = 'avante.md',
        provider = 'copilot',
        providers = {
            copilot = {
                endpoint = 'https://api.githubcopilot.com',
                model = 'gpt-5-mini',
                proxy = nil,
                allow_insecure = false,
                timeout = 30000,
                context_window = 64000,
                use_response_api = copilot_use_response_api, -- Automatically switch to Response API for GPT-5 Codex models
                support_previous_response_id = false,
                -- NOTE: Copilot doesn't support previous_response_id, always sends full conversation history including tool_calls
                -- NOTE: Response API doesn't support some parameters like top_p, frequency_penalty, presence_penalty
                extra_request_body = {
                    max_tokens = 20480,
                },
            },
        },
        selector = {
            provider = 'mini_pick',
        },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        --- The below dependencies are optional,
        'nvim-mini/mini.pick', -- for file_selector provider mini.pick
        'folke/snacks.nvim', -- for input provider snacks
        'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
        'zbirenbaum/copilot.lua', -- for providers='copilot'
        {
            -- support for image pasting
            'HakonHarnes/img-clip.nvim',
            event = 'VeryLazy',
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { 'markdown', 'Avante' },
            },
            ft = { 'markdown', 'Avante' },
        },
    },
}
