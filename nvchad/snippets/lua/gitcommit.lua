return {
  s(
    "prev",
    f(function()
      local result = vim.fn.system "git log -1 --pretty=%B | awk '{print $1}'"
      return result:match "%S+" .. " "
    end)
  ),
}
