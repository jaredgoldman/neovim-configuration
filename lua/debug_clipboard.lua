-- Clipboard Debug Script
-- Run this with :lua dofile("debug_clipboard.lua")

local function debug_print(msg)
    print("DEBUG: " .. msg)
end

debug_print("=== Clipboard Debug Information ===")

-- Check if we're in SSH
local ssh_tty = os.getenv("SSH_TTY")
debug_print("SSH_TTY: " .. (ssh_tty or "not set"))

-- Check if we're in tmux
local tmux = os.getenv("TMUX")
debug_print("TMUX: " .. (tmux or "not set"))

-- Check current clipboard setting
debug_print("vim.opt.clipboard: " .. vim.inspect(vim.opt.clipboard:get()))
debug_print("vim.g.clipboard: " .. vim.inspect(vim.g.clipboard))

-- Test OSC 52 availability
local has_osc52, osc52 = pcall(require, 'vim.ui.clipboard.osc52')
debug_print("OSC 52 available: " .. tostring(has_osc52))

if has_osc52 then
    -- Test basic OSC 52 functionality
    debug_print("Testing OSC 52...")
    local test_text = {"test clipboard content"}
    
    local success, err = pcall(function()
        osc52.copy('+')(test_text)
    end)
    
    debug_print("OSC 52 copy test: " .. (success and "SUCCESS" or "FAILED: " .. tostring(err)))
else
    debug_print("OSC 52 module not found")
end

-- Test basic vim registers
vim.fn.setreg('"', "test content")
local reg_content = vim.fn.getreg('"')
debug_print('Default register content: "' .. reg_content .. '"')

-- Check terminal capabilities
debug_print("TERM: " .. (os.getenv("TERM") or "not set"))
debug_print("COLORTERM: " .. (os.getenv("COLORTERM") or "not set"))

debug_print("=== End Debug Info ===") 