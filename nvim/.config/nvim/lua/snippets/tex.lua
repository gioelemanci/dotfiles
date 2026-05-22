local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node -- Node for simple static text
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local rep = require("luasnip.extras").rep

-- Helper function: Bulletproof math zone detection
local in_mathzone = function()
  local has_ts, ts = pcall(require, "vim.treesitter")
  if has_ts then
    local node = ts.get_node({ ignore_injections = false })
    while node do
      local type = node:type()
      if type == "math_environment" or type == "inline_formula" or type == "displayed_equation" or string.match(type, "math") then
        return true
      end
      node = node:parent()
    end
  end
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- ==========================================
-- MAIN SNIPPETS TABLE
-- ==========================================
local snippets = {

  -- 1. Inline Math (fm)
  s({ trig = "fm", snippetType = "autosnippet" },
    fmta("\\(<>\\)", { i(1) }),
    { condition = function() return not in_mathzone() end }
  ),

  -- 2. Display Math (dm)
  s({ trig = "dm", snippetType = "autosnippet" },
    fmta(
      [[
        \[
          <>
        \]
      ]],
      { i(1) }
    ),
    {
      condition = function(line_to_cursor, matched_trigger, captures)
        return not in_mathzone() and conds.line_begin(line_to_cursor, matched_trigger, captures)
      end
    }
  ),

  -- 3. Aligned Display Math (am)
  s({ trig = "am", snippetType = "autosnippet" },
    fmta(
      [[
        \[
          \begin{aligned}
            <>
          \end{aligned}
        \]
      ]],
      { i(1) }
    ),
    {
      condition = function(line_to_cursor, matched_trigger, captures)
        return not in_mathzone() and conds.line_begin(line_to_cursor, matched_trigger, captures)
      end
    }
  ),

  -- 4. MATH FONTS
  s({ trig = "rm", snippetType = "autosnippet" },
    fmta("\\mathrm{<>}", { i(1) }),
    { condition = function() return in_mathzone() end }
  ),

  s({ trig = "bf", snippetType = "autosnippet" },
    fmta("\\mathbf{<>}", { i(1) }),
    { condition = function() return in_mathzone() end }
  ),

  s({ trig = "bb", snippetType = "autosnippet" },
    fmta("\\mathbb{<>}", { i(1) }),
    { condition = function() return in_mathzone() end }
  ),

  s({ trig = "cal", snippetType = "autosnippet" },
    fmta("\\mathcal{<>}", { i(1) }),
    { condition = function() return in_mathzone() end }
  ),

  s({ trig = "fr", snippetType = "autosnippet" },
    fmta("\\mathfrak{<>}", { i(1) }),
    { condition = function() return in_mathzone() end }
  ),

  -- 5. SMART FRACTIONS AND SCRIPTS
  s({ trig = "//", snippetType = "autosnippet", wordTrig = false },
    fmta("\\frac{<>}{<>}", { i(1), i(2) }),
    { condition = function() return in_mathzone() end }
  ),

  s({ trig = "^", snippetType = "autosnippet", wordTrig = false },
    fmta("^{<>}", { i(1) }),
    { condition = function() return in_mathzone() end }
  ),

  s({ trig = "_", snippetType = "autosnippet", wordTrig = false },
    fmta("_{<>}", { i(1) }),
    { condition = function() return in_mathzone() end }
  ),

  -- 6. ENVIRONMENTS
  -- Generic Environment (beg)
  s({ trig = "beg", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      { i(1), i(2), rep(1) } -- rep(1) copia in tempo reale quello che scrivi in i(1)
    ),
    { condition = conds.line_begin }
  ),

  -- 7. TEXT FORMATTING

  -- Italics / Emphasize (tii)
  s({ trig = "tii", snippetType = "autosnippet" },
    fmta("\\emph{<>}", { i(1) }),
    { condition = function() return not in_mathzone() end }
  ),

  -- Bold (tbb)
  s({ trig = "tbb", snippetType = "autosnippet" },
    fmta("\\textbf{<>}", { i(1) }),
    { condition = function() return not in_mathzone() end }
  ),

  -- 8. FIGURES

  -- Standard Figure (fig)
  s({ trig = "fig", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{figure}[H]
          \centering
          \includegraphics[width=0.9\textwidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
      ]],
      {
        i(1, "image_path"),
        i(2, "caption"),
        i(3, "label")
      }
    ),
    {
      condition = function(line_to_cursor, matched_trigger, captures)
        return not in_mathzone() and conds.line_begin(line_to_cursor, matched_trigger, captures)
      end
    }
  ),

  -- Figure with Side-by-Side Minipages (mfig)
  s({ trig = "mfig", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{figure}[H]
          \centering
          \begin{minipage}{0.45\textwidth}
            \centering
            \includegraphics[width=0.9\linewidth]{<>}
          \end{minipage}
          \hfill
          \begin{minipage}{0.45\textwidth}
            \caption{<>}
            \label{fig:<>}
          \end{minipage}
        \end{figure}
      ]],
      {
        i(1, "image_path"),
        i(2, "caption"),
        i(3, "label")
      }
    ),
    {
      condition = function(line_to_cursor, matched_trigger, captures)
        return not in_mathzone() and conds.line_begin(line_to_cursor, matched_trigger, captures)
      end
    }
  ),

  -- 9. TABLES

  -- Table with booktabs (tab)
  s({ trig = "tab", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{table}[H]
          \centering
          \begin{tabular}{<>}
            \toprule
            <> \\
            \midrule
            <> \\
            \bottomrule
          \end{tabular}
          \caption{<>}
          \label{tab:<>}
        \end{table}
      ]],
      {
        i(1, "c c"),
        i(2, "Title 1 & Title 2"),
        i(3, "Input 1 & Input 2"),
        i(4, "caption"),
        i(5, "label")
      }
    ),
    {
      condition = function(line_to_cursor, matched_trigger, captures)
        return not in_mathzone() and conds.line_begin(line_to_cursor, matched_trigger, captures)
      end
    }
  ),

}

-- ==========================================
-- AUTO-BACKSLASH MATH WORDS (Dynamic Generation)
-- ==========================================
local auto_backslash_words = {
  -- Greek Letters (Lowercase)
  "alpha", "beta", "gamma", "delta", "epsilon", "zeta", "eta", "theta", "iota", "kappa", "lambda", "mu", "nu", "xi", "pi", "rho", "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega",
  -- Greek Letters (Uppercase)
  "Gamma", "Delta", "Theta", "Lambda", "Xi", "Pi", "Sigma", "Upsilon", "Phi", "Psi", "Omega",
  -- Greek Letters (Variants)
  "varepsilon", "varphi", "varrho", "vartheta",

  -- Operators & Relations
  "approx", "sim", "simeq", "propto", "neq", "leq", "geq", "equiv", "ll", "gg",
  "times", "cdot", "oplus", "otimes", "dagger", "supset",

  -- Calculus & Logic
  "nabla", "partial", "infty", "forall", "exists", "ell", "hbar",

  -- Arrows
  "mapsto", "implies", "iff", "uparrow", "downarrow",

  -- Standard Math Functions
  "sin", "cos", "tan", "csc", "sec", "cot",
  "ln", "log", "exp",
  "min", "max", "sup", "inf", "det", "lim",
}

for _, word in ipairs(auto_backslash_words) do
  table.insert(snippets,
    s({ trig = word, snippetType = "autosnippet" },
      t("\\" .. word),
      { condition = function() return in_mathzone() end }
    )
  )
end

-- Return snippets to LuaSnip
return snippets
