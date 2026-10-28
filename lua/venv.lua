local M = {}

function M.start_terminal()
  local python = vim.g.venv_detector_python_path
  local venv = python and vim.fs.dirname(vim.fs.dirname(python))

  vim.cmd "enew" -- Create an empty buffer for the terminal.
  local job = vim.fn.jobstart({ vim.o.shell }, { term = true })

  if venv and job > 0 then
    vim.defer_fn(function()
      if vim.fn.jobwait({ job }, 0)[1] == -1 then
        local cmd = "source " .. vim.fn.shellescape(venv .. "/bin/activate")
        vim.fn.chansend(job, cmd .. "\n")
      end
    end, 800)
  end

  vim.cmd "startinsert"
end
return M

