local M = {}

local function escape_pattern(text)
  -- Escape special characters in the pattern
  return text:gsub("([%-%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end

function M.find_and_replace()
  local find_pattern = ""
  local replace_pattern = ""

  -- Prompt for find pattern
  vim.ui.input({ prompt = "Find: " }, function(input)
    find_pattern = escape_pattern(input or "")
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

return M
