-- grind: the practice gym's nvim side (https://github.com/heyodog0/grind). Loaded at startup: it only acts in
-- nvims launched by `grind` (GRIND / GRIND_VIEW), plus the <leader>d keymaps.
return {
  dir = "~/code/personal/grind",
  name = "grind",
  lazy = false,
  config = function() require("grind") end,
}
