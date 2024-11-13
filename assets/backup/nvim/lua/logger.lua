-- lua/logger.lua

local M = {}

-- log level
M.LEVELS = {
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
    FATAL = 5
}

-- 默认配置
local config = {
    level = M.LEVELS.INFO,
    file_path = vim.fn.stdpath('data') .. '/nvim.log',
    use_console = true,
    use_file = true,
    max_file_size = 1024 * 1024,  -- 1MB
}

-- 获取当前时间的格式化字符串
local function get_timestamp()
    return os.date("%Y-%m-%d %H:%M:%S")
end

-- 获取当前文件名
local function get_current_file()
    return vim.fn.expand('%:p')
end

-- 获取日志级别的字符串表示
local function get_level_string(level)
    for k, v in pairs(M.LEVELS) do
        if v == level then
            return k
        end
    end
    return "UNKNOWN"
end

-- 格式化日志消息
local function format_message(level, message)
    local timestamp = get_timestamp()
    local current_file = get_current_file()
    return string.format("[%s] [%s] File: %s\n%s\n", 
                         timestamp, 
                         get_level_string(level), 
                         current_file, 
                         message)
end

-- 写入日志到文件
local function write_to_file(message)
    if not config.use_file then return end

    local file = io.open(config.file_path, "a")
    if file then
        file:write(message)
        file:close()

        -- 检查文件大小并在必要时轮换
        local size = vim.fn.getfsize(config.file_path)
        if size > config.max_file_size then
            local backup_path = config.file_path .. ".old"
            os.rename(config.file_path, backup_path)
        end
    end
end

-- 写入日志到控制台
local function write_to_console(level, message)
    if not config.use_console then return end

    if level >= M.LEVELS.WARN then
        vim.api.nvim_err_writeln(message)
    else
        print(message)
    end
end

-- 记录日志
function M.log(level, message)
    if level < config.level then return end

    local formatted_msg = format_message(level, message)
    write_to_file(formatted_msg)
    write_to_console(level, formatted_msg)
end

-- 便捷函数
function M.debug(message) M.log(M.LEVELS.DEBUG, message) end
function M.info(message) M.log(M.LEVELS.INFO, message) end
function M.warn(message) M.log(M.LEVELS.WARN, message) end
function M.error(message) M.log(M.LEVELS.ERROR, message) end
function M.fatal(message) M.log(M.LEVELS.FATAL, message) end

-- 配置函数
function M.setup(opts)
    config = vim.tbl_deep_extend("force", config, opts or {})
end

return M
