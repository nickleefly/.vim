local attach_to_buffer = function(output_bufnr, pattern, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("automagic", { clear = true }),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
        end
      end

      vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output of your code" })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

local function create_new_vertical_buffer(name)
  -- Create a new vertical buffer
  local new_buffer_number = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_name(new_buffer_number, name)

  -- Open the buffer in vertical split
  vim.api.nvim_command("vertical split " .. vim.api.nvim_buf_get_name(new_buffer_number))

  return new_buffer_number
end

-- attach_to_buffer(3, "*.py", { "python", "hello.py" })
vim.api.nvim_create_user_command("AutoRun", function()
  print("Autorun starts now...")
  -- local bufnr = vim.fn.input("Bufnr: ")
  local bufnr = create_new_vertical_buffer("output_buffer")
  local pattern = vim.fn.input("Pattern: ")
  local command = vim.split(vim.fn.input("Command: "), " ")
  attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})
