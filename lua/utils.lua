local M = {}

-- Function to escape special characters in the pattern
local function escape_pattern(text)
  return text:gsub("([%-%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end

-- Function to log messages
local function log(message)
  print("[FindAndReplace] " .. message)
end

-- Function to find and replace text in files
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
    local total_files = #files

    log("Starting find and replace in " .. total_files .. " files.")

    for i, file in ipairs(files) do
      -- Log progress
      log("Processing file " .. i .. " of " .. total_files .. ": " .. file)

      -- Open each file
      vim.cmd("edit " .. file)

      -- Perform the find and replace with confirmation on each match
      vim.cmd("%s/" .. find_pattern .. "/" .. replace_pattern .. "/gc")

      -- Save the file after replacements
      vim.cmd("write")
    end

    log("Find and replace completed in all files.")
  end
end

return M
