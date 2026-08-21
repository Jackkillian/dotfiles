if vim.g.started_by_firenvim then
  vim.opt.guifont = "FiraCode Nerd Font:h8"
end

return { "glacambre/firenvim", build = ":call firenvim#install(0)" }

