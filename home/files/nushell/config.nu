let base00 = "#191724" # Default Background
let base01 = "#1f1d2e" # Lighter Background (Used for status bars, line number and folding marks)
let base02 = "#26233a" # Selection Background
let base03 = "#6e6a86" # Comments, Invisibles, Line Highlighting
let base04 = "#908caa" # Dark Foreground (Used for status bars)
let base05 = "#e0def4" # Default Foreground, Caret, Delimiters, Operators
let base06 = "#e0def4" # Light Foreground (Not often used)
let base07 = "#524f67" # Light Background (Not often used)
let base08 = "#eb6f92" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
let base09 = "#f6c177" # Integers, Boolean, Constants, XML Attributes, Markup Link Url
let base0a = "#ebbcba" # Classes, Markup Bold, Search Text Background
let base0b = "#31748f" # Strings, Inherited Class, Markup Code, Diff Inserted
let base0c = "#9ccfd8" # Support, Regular Expressions, Escape Characters, Markup Quotes
let base0d = "#c4a7e7" # Functions, Methods, Attribute IDs, Headings
let base0e = "#f6c177" # Keywords, Storage, Selector, Markup Italic, Diff Changed
let base0f = "#524f67" # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

# we're creating a theme here that uses the colors we defined above.

let base16_theme = {
    separator: $base03
    leading_trailing_space_bg: $base04
    header: $base0b
    date: $base0e
    filesize: $base0d
    row_index: $base0c
    bool: $base08
    int: $base0b
    duration: $base08
    range: $base08
    float: $base08
    string: $base04
    nothing: $base08
    binary: $base08
    cellpath: $base08
    hints: dark_gray

    # shape_garbage: { fg: $base07 bg: $base08 attr: b} # base16 white on red
    # but i like the regular white on red for parse errors
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_bool: $base0d
    shape_int: { fg: $base0e attr: b}
    shape_float: { fg: $base0e attr: b}
    shape_range: { fg: $base0a attr: b}
    shape_internalcall: { fg: $base0c attr: b}
    shape_external: $base0c
    shape_externalarg: { fg: $base0b attr: b}
    shape_literal: $base0d
    shape_operator: $base0a
    shape_signature: { fg: $base0b attr: b}
    shape_string: $base0b
    shape_filepath: $base0d
    shape_globpattern: { fg: $base0d attr: b}
    shape_variable: $base0e
    shape_flag: { fg: $base0d attr: b}
    shape_custom: {attr: b}
}

def devshellInit [] {
  nix flake init --template $'($env.flake)#devshell-basic'
}

$env.config  = {
  table: {
    mode: rounded,
  },
  color_config: $base16_theme,
  edit_mode: vi,
  show_banner: false
}

$env.PATH = (
  $env.PATH |
  split row (char esep) |
  prepend /home/moxie/.apps |
  append /usr/bin/env
)

$env.LS_COLORS = (vivid generate molokai | str trim)

def psc [] { ps | sort-by mem | select pid name cpu} 
def psm [] { ps | sort-by mem | select pid name mem} 

source ~/.cache/carapace/init.nu