-- set colorscheme with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme nightfox")
-- there are also colorschemes for the different styles
-- colorscheme dawnfox
-- colorscheme dayfox
-- colorscheme duskfox
-- colorscheme nightfox
-- colorscheme nordfox
-- colorscheme terafox
-- colorscheme carbonfox
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end
