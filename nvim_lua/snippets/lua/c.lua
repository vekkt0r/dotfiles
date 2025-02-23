local get_filename_upper = function()
  local filename = vim.fn.expand "%:t:r"
  return filename:upper() .. "_H"
end

return {
  s("ifndef", {
    f(function()
      return "#ifndef " .. get_filename_upper()
    end, {}),
    t { "", "#define " },
    f(function()
      return get_filename_upper()
    end, {}),
    t { "", "", "" },
    i(0),
    t { "", "", "#endif" .. "  /* " .. get_filename_upper() .. " */" },
  }),
}
