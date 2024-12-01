-- Simple, minimal statusline with emojis
vim.cmd([[
  highlight StatusLine   guifg=#4a4a4a guibg=#f0f0f0 gui=NONE
  highlight StatusLineNC guifg=#8a8a8a guibg=#f0f0f0 gui=NONE
  highlight StMode      guifg=#4a4a4a guibg=#e0e0e0 gui=bold
  highlight StFile      guifg=#4a4a4a guibg=#f0f0f0 gui=NONE
  highlight StGit       guifg=#4a4a4a guibg=#f0f0f0 gui=NONE
  highlight StInfo      guifg=#4a4a4a guibg=#f0f0f0 gui=NONE
]])

-- Mode configurations with emojis
local modes = {
    ['n']    = '🔍 NORMAL',    -- Search emoji for normal mode
    ['no']   = '🔍 N·OP',
    ['v']    = '✂️ VISUAL',    -- Scissors for visual mode
    ['V']    = '✂️ V·LINE',
    ['']   = '✂️ V·BLOCK',
    ['s']    = '✂️ SELECT',
    ['S']    = '✂️ S·LINE',
    ['']   = '✂️ S·BLOCK',
    ['i']    = '✏️ INSERT',    -- Pencil for insert mode
    ['ic']   = '✏️ INSERT',
    ['R']    = '🔄 REPLACE',   -- Sync emoji for replace mode
    ['Rv']   = '🔄 V·REPLACE',
    ['c']    = '💻 COMMAND',   -- Computer for command mode
    ['cv']   = '💻 VIM·EX',
    ['ce']   = '💻 EX',
    ['r']    = '❓ PROMPT',    -- Question mark for prompt
    ['rm']   = '❓ MORE',
    ['r?']   = '❓ CONFIRM',
    ['!']    = '🚀 SHELL',     -- Rocket for shell
    ['t']    = '🚀 TERM',
}

-- Function to get current mode
local function get_mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format('%%#StMode# %s ', modes[current_mode] or modes['n'])
end

-- Function to get git info with emoji
local function get_git_info()
    local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    if branch ~= "" then
        return string.format('%%#StGit# 🌿 %s ', branch)
    end
    return ''
end

-- Function to get file info with emoji
local function get_file_info()
    local file = vim.fn.expand('%:t')
    if file == '' then file = '[No Name]' end
    
    -- Get file type emoji
    local file_icon = '📄 '  -- Default file icon
    local extension = vim.fn.expand('%:e')
    local file_icons = {
        lua = '🌙 ',    -- Moon for Lua
        py = '🐍 ',     -- Snake for Python
        js = '💛 ',     -- Yellow heart for JavaScript
        html = '🌐 ',   -- Globe for HTML
        css = '🎨 ',    -- Paint palette for CSS
        json = '📦 ',   -- Package for JSON
        md = '📝 ',     -- Memo for Markdown
        vim = '💚 ',    -- Green heart for Vim
        sh = '🐚 ',     -- Shell for shell scripts
        ['.git'] = '📓 ', -- Notebook for git files
        [''] = '📄 ',    -- Default file icon
    }
    
    local icon = file_icons[extension] or file_icon
    local modified = vim.bo.modified and ' 💫' or ''  -- Sparkle for modified
    return string.format('%%#StFile#%s%s%s ', icon, file, modified)
end

-- Function to get diagnostic info with emojis
local function get_diagnostics()
    if vim.fn.exists('*vim.diagnostic.get') == 1 then
        local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        
        local status = ''
        if errors > 0 then status = status .. string.format('❌ %d ', errors) end
        if warnings > 0 then status = status .. string.format('⚠️ %d ', warnings) end
        if hints > 0 then status = status .. string.format('💡 %d ', hints) end
        return status
    end
    return ''
end

-- Function to get file position with emoji
local function get_position()
    local line = vim.fn.line('.')
    local col = vim.fn.col('.')
    local total_lines = vim.fn.line('$')
    local percent = math.floor(line * 100 / total_lines)
    return string.format('%%#StInfo# 📍 %d:%d %d%%%% ', line, col, percent)
end

-- Function to get file type
local function get_filetype()
    local ft = vim.bo.filetype
    if ft == '' then return '' end
    return string.format('%%#StInfo# 📎 %s ', ft)
end

-- Set up the statusline
function StatusLine()
    local status = ''
    
    -- Left side
    status = status .. get_mode()
    status = status .. get_git_info()
    status = status .. get_file_info()
    status = status .. get_diagnostics()
    
    -- Right side
    status = status .. '%='  -- Switch to right side
    status = status .. get_filetype()
    status = status .. get_position()
    
    return status
end

-- Apply the statusline
vim.opt.statusline = '%!v:lua.StatusLine()'
vim.opt.laststatus = 3  -- Global statusline
vim.opt.showmode = false  -- Don't show mode in command line

-- Set minimal theme colors
vim.opt.background = 'light'
