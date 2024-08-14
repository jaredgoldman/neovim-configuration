local api = vim.api

-- Show file path in command bar
api.nvim_create_user_command("ShowFilePath", function()
  print(vim.fn.expand("%:p"))
end, { bang = true })

-- Toggle wrap
vim.api.nvim_create_user_command("ToggleWrap", function()
  if vim.wo.wrap then
    vim.wo.wrap = false
    print("Word wrap disabled")
  else
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    print("Word wrap enabled")
  end
end, {})

local function find_and_replace()
  local find_pattern = ""
  local replace_pattern = ""

  -- Prompt for find pattern
  vim.ui.input({ prompt = "Find: " }, function(input)
    find_pattern = input or ""
  end)

  -- Prompt for replace pattern
  vim.ui.input({ prompt = "Replace: " }, function(input)
    replace_pattern = input or ""
  end)

  if find_pattern ~= "" and replace_pattern ~= "" then
    -- Get list of files in the current directory matching the pattern
    local files = vim.fn.glob("**/*", false, true)

    for _, file in ipairs(files) do
      -- Open each file
      vim.cmd("edit " .. file)

      -- Perform the find and replace with confirmation on each match
      vim.cmd("%s/" .. find_pattern .. "/" .. replace_pattern .. "/gc")

      -- Save the file after replacements
      vim.cmd("write")
    end
  end
end

-- Register the command
api.nvim_create_user_command("FindAndReplace", find_and_replace, {})
