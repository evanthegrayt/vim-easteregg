" Vim color file
" File:         easteregg.vim - a colorscheme for vim
" Maintainer:   Evan Gray <egray1985@gmail.com>
" Version:      2.0
" Last Change:  Tue Nov 11 07:32:53 2014
" Creators:     NanoTech <http://nanotech.nanotechcorp.net/>
"               Re-done by Evan Gray
"
" Copyright (c) 2009-2010 NanoTech
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the 'Software'), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "easteregg"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  let s:low_color = 0
else
  let s:low_color = 1
endif

" Color approximation functions by Henry So, Jr. and David Liang {{{
" Added to easteregg.vim by Evan Gray

" returns an approximate grey index for the given grey level
fun! s:grey_number(x)
  if &t_Co == 88
    if a:x < 23
      return 0
    elseif a:x < 69
      return 1
    elseif a:x < 103
      return 2
    elseif a:x < 127
      return 3
    elseif a:x < 150
      return 4
    elseif a:x < 173
      return 5
    elseif a:x < 196
      return 6
    elseif a:x < 219
      return 7
    elseif a:x < 243
      return 8
    else
      return 9
    endif
  else
    if a:x < 14
      return 0
    else
      let l:n = (a:x - 8) / 10
      let l:m = (a:x - 8) % 10
      if l:m < 5
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" returns the actual grey level represented by the grey index
fun! s:grey_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 46
    elseif a:n == 2
      return 92
    elseif a:n == 3
      return 115
    elseif a:n == 4
      return 139
    elseif a:n == 5
      return 162
    elseif a:n == 6
      return 185
    elseif a:n == 7
      return 208
    elseif a:n == 8
      return 231
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 8 + (a:n * 10)
    endif
  endif
endfun

" returns the palette index for the given grey index
fun! s:grey_color(n)
  if &t_Co == 88
    if a:n == 0
      return 16
    elseif a:n == 9
      return 79
    else
      return 79 + a:n
    endif
  else
    if a:n == 0
      return 16
    elseif a:n == 25
      return 231
    else
      return 231 + a:n
    endif
  endif
endfun

" returns an approximate color index for the given color level
fun! s:rgb_number(x)
  if &t_Co == 88
    if a:x < 69
      return 0
    elseif a:x < 172
      return 1
    elseif a:x < 230
      return 2
    else
      return 3
    endif
  else
    if a:x < 75
      return 0
    else
      let l:n = (a:x - 55) / 40
      let l:m = (a:x - 55) % 40
      if l:m < 20
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" returns the actual color level for the given color index
fun! s:rgb_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 139
    elseif a:n == 2
      return 205
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 55 + (a:n * 40)
    endif
  endif
endfun

" returns the palette index for the given R/G/B color indices
fun! s:rgb_color(x, y, z)
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun

" returns the palette index to approximate the given R/G/B color levels
fun! s:color(r, g, b)
  " get the closest grey
  let l:gx = s:grey_number(a:r)
  let l:gy = s:grey_number(a:g)
  let l:gz = s:grey_number(a:b)

  " get the closest color
  let l:x = s:rgb_number(a:r)
  let l:y = s:rgb_number(a:g)
  let l:z = s:rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " there are two possibilities
    let l:dgr = s:grey_level(l:gx) - a:r
    let l:dgg = s:grey_level(l:gy) - a:g
    let l:dgb = s:grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = s:rgb_level(l:gx) - a:r
    let l:dg = s:rgb_level(l:gy) - a:g
    let l:db = s:rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " use the grey
      return s:grey_color(l:gx)
    else
      " use the color
      return s:rgb_color(l:x, l:y, l:z)
    endif
  else
    " only one possibility
    return s:rgb_color(l:x, l:y, l:z)
  endif
endfun

" returns the palette index to approximate the 'rrggbb' hex string
fun! s:rgb(rgb)
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
  return s:color(l:r, l:g, l:b)
endfun

" sets the highlighting for the given group
fun! s:X(group, fg, bg, attr, lcfg, lcbg)
  if s:low_color
    let l:fge = empty(a:lcfg)
    let l:bge = empty(a:lcbg)

    if !l:fge && !l:bge
      exec "hi ".a:group." ctermfg=".a:lcfg." ctermbg=".a:lcbg
    elseif !l:fge && l:bge
      exec "hi ".a:group." ctermfg=".a:lcfg." ctermbg=NONE"
    elseif l:fge && !l:bge
      exec "hi ".a:group." ctermfg=NONE ctermbg=".a:lcbg
    endif
  else
    let l:fge = empty(a:fg)
    let l:bge = empty(a:bg)

    if !l:fge && !l:bge
      exec "hi ".a:group." guifg=#".a:fg." guibg=#".a:bg." ctermfg=".s:rgb(a:fg)." ctermbg=".s:rgb(a:bg)
    elseif !l:fge && l:bge
      exec "hi ".a:group." guifg=#".a:fg." guibg=NONE ctermfg=".s:rgb(a:fg)
    elseif l:fge && !l:bge
      exec "hi ".a:group." guifg=NONE guibg=#".a:bg." ctermbg=".s:rgb(a:bg)
    endif
  endif

  if a:attr == ""
    exec "hi ".a:group." gui=none cterm=none"
  else
    if a:attr == 'italic'
      if exists('g:easteregg_use_italics') && g:easteregg_use_italics
        exec "hi ".a:group." gui=".a:attr." cterm=italic"
      else
        exec "hi ".a:group." gui=".a:attr." cterm='NONE'"
      endif
    else
      exec "hi ".a:group." gui=".a:attr." cterm=".a:attr
    endif
  endif
endfun
" }}}
"
if version >= 700
  "CSV support
  call s:X("CSVColumnHeaderOdd","","536991","","","")
  call s:X("CSVColumnHeaderEven","","8f5370","","","")
  call s:X("CSVColumnOdd","","536991","","","")
  call s:X("CSVColumnEven","","8f5370","","","")

  call s:X("CursorLine","","000000","","","")
  call s:X("CursorColumn","","000000","","","")
  call s:X("ColorColumn","","000000","","","")
  call s:X("MatchParen","a56aa8","474545","bold","","")

  call s:X("TabLine","000000","b0b8c0","italic","","")
  call s:X("TabLineFill","9098a0","","","","")
  call s:X("TabLineSel","000000","f0f0f0","italic,bold","","")

  "Auto-completion
  call s:X("Pmenu","C3C3C3","222222","","","")
  call s:X("PmenuSel","cae682","404040","","","")
  call s:X("PMenuSbar","C3C3C3","222222","","","")
  call s:X("PMenuThumb","C3C3C3","222222","","","")
  " Indent Guides
  call s:X("IndentGuidesOdd","616161","000000","bold","","")
  call s:X("IndentGuidesEven","000000","616161","bold","","")
endif
" Visual Mode and Cursor
call s:X("Visual","f1adff","302028","underline","","")
call s:X("Cursor","000000","c4ffc8","underline","","")
" Non-code Text (THE TOP LINE SETS THE BACKGROUND!)
call s:X("Normal","e8e8d3","1B1D1E","","","")
call s:X("LineNr","eeeeee","000000","italic","","")
call s:X("Comment","616161","000000","italic","","")
call s:X("Todo","82c78f","000000","bold","","")
" Status Lines
call s:X("StatusLineNC","000000","eeeeee","bold","","")
call s:X("StatusLine","000000","eeeeee","bold","","")
call s:X("VertSplit","eeeeee","000000","bold","","")
" Folds
call s:X("Folded","a0a8b0","384048","underline","","")
call s:X("FoldColumn","a0a8b0","384048","","","")
call s:X("SignColumn","a0a8b0","384048","","","")
call s:X("Title","70b950","","bold","","")
" Constants
call s:X("Constant","cf6a4c","","italic","","")
call s:X("String","de97ab","","","","")
call s:X("Character","c7b6db","","","","")
call s:X("Number","6bbfbb","","","","")
call s:X("Boolean","6bbfbb","","","","")
call s:X("Float","6bbfbb","","","","")
" Identifiers
call s:X("Identifier","fa8989","","","","")
call s:X("Function","cf745b","","","","")
" Statements
call s:X("Conditional","8197bf","","bold","","")
call s:X("Statement","7cb37c","","bold","","")
call s:X("Repeat","819bde","","bold","","")
call s:X("Label","e0c98d","","bold","","")
call s:X("Operator","c77a56","","","","")
call s:X("Keyword","b05858","","","","")
call s:X("Exception","d4cc77","","","","")
" PreProc
call s:X("PreProc","8fbfdc","","bold","","")
call s:X("Include","dbcb7d","","bold","","")
call s:X("Define","7ddbc0","","bold","","")
call s:X("Macro","c6ffba","","bold","","")
call s:X("PreCondit","ffc8ba","","bold","","")
" Type
call s:X("Type","8ecc7e","","italic","","")
call s:X("StorageClass","c59f6f","","","","")
call s:X("Structure","8ecc7e","","","","")
call s:X("Typedef","8ecc7e","","","","")
" Special
call s:X("Special","668594","","","","")
call s:X("SpecialChar","eeeeee","313131","","","")
call s:X("Tag","668594","","","","")
call s:X("Delimiter","ccac85","","","","")
call s:X("SpecialComment","668594","000000","","","")
call s:X("Debug","668594","","","","")
" HTML Links
call s:X("Underlined","4059bd","","underline","","")
" Ignored
call s:X("Ignore","4059bd","","underline","","")
" Error
call s:X("Error","","ff0040","underline","","")
"listchars
call s:X("NonText","5e5e5e","","","","")
call s:X("SpecialKey","5e5e5e","","","","")
" Other
call s:X("StringDelimiter","77d47d","","bold","","")
call s:X("Structure","8fbfdc","","","","")
call s:X("Search","d1c78a","302028","underline","","")
call s:X("Directory","902020","000000","","","")
call s:X("ErrorMsg","e06b83","000000","","","")
call s:X("Question","000000","668594","","","")
" VimDiff
call s:X("DiffAdd","","032218","","","")
call s:X("DiffChange","","100920","","","")
call s:X("DiffDelete","220000","220000","","","")
call s:X("DiffText","","000940","","","")
" Spelling
call s:X("SpellBad", "000000", "f06363", "bold", "", "")
call s:X("SpellCap", "000000", "de97ab", "bold", "", "")

hi link Error ErrorMsg

"ZSH
hi link zshSharpBang        Comment
hi link zshTodo             Todo
hi link zshComment          Comment
hi link zshPreProc          PreProc
hi link zshQuoted           SpecialChar
hi link zshString           String
hi link zshStringDelimiter  zshString
hi link zshPOSIXString      zshString
hi link zshJobSpec          Special
hi link zshPrecommand       Special
hi link zshDelimiter        Repeat
hi link zshConditional      Conditional
hi link zshException        Exception
hi link zshRepeat           Repeat
hi link zshKeyword          Keyword
hi link zshFunction         Function
hi link zshKSHFunction      zshFunction
hi link zshHereDoc          String
hi link zshOperator         Operator
hi link zshRedir            Operator
hi link zshVariable         Identifier
hi link zshVariableDef      zshVariable
hi link zshDereferencing    PreProc
hi link zshCommands         Keyword
hi link zshOptions          Constant
hi link zshTypes            Type
hi link zshSwitches         Special
hi link zshNumber           Number
hi link zshSubst            PreProc
hi link zshMathSubst        zshSubst
hi link zshOldSubst         zshSubst
hi link zshSubstDelim       zshSubst

" RUBY
hi link rubyBoolean Boolean
hi link rubyDefine Define
hi link rubyFloat Float
hi link rubyLocalVariableOrMethod StorageClass
hi link rubyFunction Function
hi link rubyInteger Number
hi link rubyInstanceVariable Define
hi link rubySharpBang Comment
hi link rubyClass Exception
hi link rubyIdentifier Identifier
hi link rubySymbol Delimiter
hi link rubyBlockParameter PreCondit
hi link rubyGlobalVariable PreProc
hi link rubyModule PreProc
hi link rubyControl Repeat
hi link rubyString String
hi link rubyStringDelimiter Structure
hi link rubyInterpolationDelimiter Include
hi link rubyRegexDelimiter Operator
hi link rubyRegexp Keyword
hi link rubyRegexSpecial PreCondit
hi link rubyPredefinedIdentifier StorageClass
hi link rubyConstant Type
hi link rubyConditional Conditional

" OCAML
hi link ocamlBrackErr     Error
hi link ocamlParenErr     Error
hi link ocamlArrErr       Error
hi link ocamlCommentErr   Error
hi link ocamlCountErr     Error
hi link ocamlDoErr        Error
hi link ocamlDoneErr      Error
hi link ocamlEndErr       Error
hi link ocamlThenErr      Error
hi link ocamlCharErr      Error
hi link ocamlErr          Error
hi link ocamlBraceErr     Error
hi link ocamlConstant     Constant
hi link ocamlComment      Comment
hi link ocamlConditional  Conditional
hi link ocamlKeyword      Repeat
hi link ocamlOperator     Operator
hi link ocamlBoolean      Boolean
hi link ocamlCharacter    Character
hi link ocamlNumber       Number
hi link ocamlFloat        Float
hi link ocamlType         Type
hi link ocamlString       String
hi link ocamlLabel        Label
hi link ocamlTodo         Todo
hi link ocamlObject       Exception
hi link ocamlAnyVar       PreProc
hi link ocamlEncl         Structure
hi link ocamlModType      PreCondit
hi link ocamlKeyChar      Statement
hi link ocamlModPath      Include
hi link ocamlModule       PreProc
hi link ocamlModParam1    Include
hi link ocamlMPRestr3     Delimiter
hi link ocamlFullMod      Operator
hi link ocamlModTypeRestr Function
hi link ocamlWith         Include
hi link ocamlMTDef        StorageClass
hi link ocamlScript       Include
hi link ocamlConstructor  Keyword
hi link ocamlModPreRHS    Keyword
hi link ocamlMPRestr2     Type
hi link ocamlMethod       Include
hi link ocamlFunDef       Function
hi link ocamlRefAssign    Keyword
hi link ocamlTopStop      PreProc

" Diff
hi link diffRemoved Constant
hi link diffAdded String

" PHP
hi link phpFunctions Function
hi link phpSuperglobal Identifier
hi link phpQuoteSingle StringDelimiter
hi link phpQuoteDouble StringDelimiter
hi link phpBoolean Constant
hi link phpNull Constant
hi link phpArrayPair Operator

" JavaScript
hi link javaScriptValue Constant
hi link javaScriptRegexpString rubyRegexp

" C
hi link cOperator Operator

" Objective-C/Cocoa
hi link objcClass Type
hi link cocoaClass objcClass
hi link objcSubclass objcClass
hi link objcSuperclass objcClass
hi link objcDirective rubyClass
hi link cocoaFunction Function
hi link objcMethodName Identifier
hi link objcMethodArg Normal
hi link objcMessageName Identifier

" Tag list
hi link TagListFileName Directory

" delete functions {{{
delf s:X
delf s:rgb
delf s:color
delf s:rgb_color
delf s:rgb_level
delf s:rgb_number
delf s:grey_color
delf s:grey_level
delf s:grey_number
" }}}
