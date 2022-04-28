" =============================================================================
" URL: https://github.com/sainnhe/edge-neo
" Filename: autoload/edge-neo.vim
" Author: sainnhe
" Email: sainnhe@gmail.com
" License: MIT License
" =============================================================================

function! edge-neo#get_configuration() "{{{
  return {
        \ 'style': get(g:, 'edge-neo_style', 'default'),
        \ 'transparent_background': get(g:, 'edge-neo_transparent_background', 0),
        \ 'disable_italic_comment': get(g:, 'edge-neo_disable_italic_comment', 0),
        \ 'enable_italic': get(g:, 'edge-neo_enable_italic', 0),
        \ 'cursor': get(g:, 'edge-neo_cursor', 'auto'),
        \ 'menu_selection_background': get(g:, 'edge-neo_menu_selection_background', 'blue'),
        \ 'spell_foreground': get(g:, 'edge-neo_spell_foreground', 'none'),
        \ 'show_eob': get(g:, 'edge-neo_show_eob', 1),
        \ 'current_word': get(g:, 'edge-neo_current_word', get(g:, 'edge-neo_transparent_background', 0) == 0 ? 'grey background' : 'bold'),
        \ 'lightline_disable_bold': get(g:, 'edge-neo_lightline_disable_bold', 0),
        \ 'diagnostic_text_highlight': get(g:, 'edge-neo_diagnostic_text_highlight', 0),
        \ 'diagnostic_line_highlight': get(g:, 'edge-neo_diagnostic_line_highlight', 0),
        \ 'diagnostic_virtual_text': get(g:, 'edge-neo_diagnostic_virtual_text', 'grey'),
        \ 'disable_terminal_colors': get(g:, 'edge-neo_disable_terminal_colors', 0),
        \ 'better_performance': get(g:, 'edge-neo_better_performance', 0),
        \ }
endfunction "}}}
function! edge-neo#get_palette(style) "{{{
  if &background ==# 'dark' "{{{
    if a:style ==# 'default' "{{{
      let palette = {
            \ 'black':      ['#2D3034',   '232'],
            \ 'bg0':        ['#373A3F',   '235'],
            \ 'bg1':        ['#37353F',   '236'],
            \ 'bg2':        ['#363944',   '237'],
            \ 'bg3':        ['#3b3e48',   '237'],
            \ 'bg4':        ['#414550',   '238'],
            \ 'bg_grey':    ['#919494',   '246'],
            \ 'bg_red':     ['#bf616a',   '203'],
            \ 'diff_red':   ['#55393d',   '52'],
            \ 'bg_green':   ['#99c794',   '107'],
            \ 'diff_green': ['#394634',   '22'],
            \ 'bg_blue':    ['#6699cc',   '110'],
            \ 'diff_blue':  ['#354157',   '17'],
            \ 'bg_purple':  ['#b48ead',   '176'],
            \ 'diff_yellow':['#4e432f',   '54'],
            \ 'fg':         ['#c5cdd9',   '250'],
            \ 'red':        ['#bf616a',   '203'],
            \ 'yellow':     ['#ebcb8b',   '179'],
            \ 'green':      ['#99c794',   '107'],
            \ 'cyan':       ['#5fb3b3',   '72'],
            \ 'blue':       ['#6699cc',   '110'],
            \ 'purple':     ['#b48ead',   '176'],
            \ 'grey':       ['#7f8490',   '246'],
            \ 'grey_dim':   ['#5b616e',   '240'],
            \ 'none':       ['NONE',      'NONE']
            \ } "}}}
    endif "}}}
  else "{{{
    let palette = {
          \ 'black':      ['#dde2e7',   '253'],
          \ 'bg0':        ['#fafafa',   '231'],
          \ 'bg1':        ['#eef1f4',   '255'],
          \ 'bg2':        ['#e8ebf0',   '254'],
          \ 'bg3':        ['#e8ebf0',   '253'],
          \ 'bg4':        ['#dde2e7',   '253'],
          \ 'bg_grey':    ['#bcc5cf',   '246'],
          \ 'bg_red':     ['#e17373',   '167'],
          \ 'diff_red':   ['#f6e4e4',   '217'],
          \ 'bg_green':   ['#76af6f',   '107'],
          \ 'diff_green': ['#e5eee4',   '150'],
          \ 'bg_blue':    ['#6996e0',   '68'],
          \ 'diff_blue':  ['#e3eaf6',   '153'],
          \ 'bg_purple':  ['#bf75d6',   '134'],
          \ 'diff_yellow':['#f0ece2',   '183'],
          \ 'fg':         ['#4b505b',   '240'],
          \ 'red':        ['#d05858',   '167'],
          \ 'yellow':     ['#be7e05',   '172'],
          \ 'green':      ['#608e32',   '107'],
          \ 'cyan':       ['#3a8b84',   '73'],
          \ 'blue':       ['#5079be',   '68'],
          \ 'purple':     ['#b05ccc',   '134'],
          \ 'grey':       ['#8790a0',   '245'],
          \ 'grey_dim':   ['#bac3cb',   '249'],
          \ 'none':       ['NONE',      'NONE']
          \ }
  endif "}}}
  return palette
endfunction "}}}
function! edge-neo#highlight(group, fg, bg, ...) "{{{
  execute 'highlight' a:group
        \ 'guifg=' . a:fg[0]
        \ 'guibg=' . a:bg[0]
        \ 'ctermfg=' . a:fg[1]
        \ 'ctermbg=' . a:bg[1]
        \ 'gui=' . (a:0 >= 1 ?
          \ a:1 :
          \ 'NONE')
        \ 'cterm=' . (a:0 >= 1 ?
          \ a:1 :
          \ 'NONE')
        \ 'guisp=' . (a:0 >= 2 ?
          \ a:2[0] :
          \ 'NONE')
endfunction "}}}
function! edge-neo#syn_gen(path, last_modified, msg) "{{{
  " Generate the `after/syntax` directory.
  let full_content = join(readfile(a:path), "\n") " Get the content of `colors/edge-neo.vim`
  let syn_conent = []
  let rootpath = edge-neo#syn_rootpath(a:path) " Get the path to place the `after/syntax` directory.
  call substitute(full_content, '" syn_begin.\{-}syn_end', '\=add(syn_conent, submatch(0))', 'g') " Search for 'syn_begin.\{-}syn_end' (non-greedy) and put all the search results into a list.
  for content in syn_conent
    let syn_list = []
    call substitute(matchstr(matchstr(content, 'syn_begin:.\{-}{{{'), ':.\{-}{{{'), '\(\w\|-\)\+', '\=add(syn_list, submatch(0))', 'g') " Get the file types. }}}}}}
    for syn in syn_list
      call edge-neo#syn_write(rootpath, syn, content) " Write the content.
    endfor
  endfor
  call edge-neo#syn_write(rootpath, 'text', "let g:edge-neo_last_modified = '" . a:last_modified . "'") " Write the last modified time to `after/syntax/text/edge-neo.vim`
  let syntax_relative_path = has('win32') ? '\after\syntax' : '/after/syntax'
  if a:msg ==# 'update'
    echohl WarningMsg | echom '[edge-neo] Updated ' . rootpath . syntax_relative_path | echohl None
    call edge-neo#ftplugin_detect(a:path)
  else
    echohl WarningMsg | echom '[edge-neo] Generated ' . rootpath . syntax_relative_path | echohl None
    execute 'set runtimepath+=' . fnamemodify(rootpath, ':p') . 'after'
  endif
endfunction "}}}
function! edge-neo#syn_write(rootpath, syn, content) "{{{
  " Write the content.
  let syn_path = a:rootpath . '/after/syntax/' . a:syn . '/edge-neo.vim' " The path of a syntax file.
  " create a new file if it doesn't exist
  if !filereadable(syn_path)
    call mkdir(a:rootpath . '/after/syntax/' . a:syn, 'p')
    call writefile([
          \ "if !exists('g:colors_name') || g:colors_name !=# 'edge-neo'",
          \ '    finish',
          \ 'endif'
          \ ], syn_path, 'a') " Abort if the current color scheme is not edge-neo.
    call writefile([
          \ "if index(g:edge-neo_loaded_file_types, '" . a:syn . "') ==# -1",
          \ "    call add(g:edge-neo_loaded_file_types, '" . a:syn . "')",
          \ 'else',
          \ '    finish',
          \ 'endif'
          \ ], syn_path, 'a') " Abort if this file type has already been loaded.
  endif
  " If there is something like `call edge-neo#highlight()`, then add
  " code to initialize the palette and configuration.
  if matchstr(a:content, 'edge-neo#highlight') !=# ''
    call writefile([
          \ 'let s:configuration = edge-neo#get_configuration()',
          \ 'let s:palette = edge-neo#get_palette(s:configuration.style)'
          \ ], syn_path, 'a')
  endif
  " Append the content.
  call writefile(split(a:content, "\n"), syn_path, 'a')
  " Add modeline.
  call writefile(['" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:'], syn_path, 'a')
endfunction "}}}
function! edge-neo#syn_rootpath(path) "{{{
  " Get the directory where `after/syntax` is generated.
  if (matchstr(a:path, '^/usr/share') ==# '') " Return the plugin directory. The `after/syntax` directory should never be generated in `/usr/share`, even if you are a root user.
    return fnamemodify(a:path, ':p:h:h')
  else " Use vim home directory.
    if has('nvim')
      return stdpath('config')
    else
      return expand('~') . '/.vim'
    endif
  endif
endfunction "}}}
function! edge-neo#syn_newest(path, last_modified) "{{{
  " Determine whether the current syntax files are up to date by comparing the last modified time in `colors/edge-neo.vim` and `after/syntax/text/edge-neo.vim`.
  let rootpath = edge-neo#syn_rootpath(a:path)
  execute 'source ' . rootpath . '/after/syntax/text/edge-neo.vim'
  return a:last_modified ==# g:edge-neo_last_modified ? 1 : 0
endfunction "}}}
function! edge-neo#syn_clean(path, msg) "{{{
  " Clean the `after/syntax` directory.
  let rootpath = edge-neo#syn_rootpath(a:path)
  " Remove `after/syntax/**/edge-neo.vim`.
  let file_list = split(globpath(rootpath, 'after/syntax/**/edge-neo.vim'), "\n")
  for file in file_list
    call delete(file)
  endfor
  " Remove empty directories.
  let dir_list = split(globpath(rootpath, 'after/syntax/*'), "\n")
  for dir in dir_list
    if globpath(dir, '*') ==# ''
      call delete(dir, 'd')
    endif
  endfor
  if globpath(rootpath . '/after/syntax', '*') ==# ''
    call delete(rootpath . '/after/syntax', 'd')
  endif
  if globpath(rootpath . '/after', '*') ==# ''
    call delete(rootpath . '/after', 'd')
  endif
  if a:msg
    let syntax_relative_path = has('win32') ? '\after\syntax' : '/after/syntax'
    echohl WarningMsg | echom '[edge-neo] Cleaned ' . rootpath . syntax_relative_path | echohl None
  endif
endfunction "}}}
function! edge-neo#syn_exists(path) "{{{
  return filereadable(edge-neo#syn_rootpath(a:path) . '/after/syntax/text/edge-neo.vim')
endfunction "}}}
function! edge-neo#ftplugin_detect(path) "{{{
  " Check if /after/ftplugin exists.
  " This directory is generated in earlier versions, users may need to manually clean it.
  let rootpath = edge-neo#syn_rootpath(a:path)
  if filereadable(edge-neo#syn_rootpath(a:path) . '/after/ftplugin/text/edge-neo.vim')
    let ftplugin_relative_path = has('win32') ? '\after\ftplugin' : '/after/ftplugin'
    echohl WarningMsg | echom '[edge-neo] Detected ' . rootpath . ftplugin_relative_path | echohl None
    echohl WarningMsg | echom '[edge-neo] This directory is no longer used, you may need to manually delete it.' | echohl None
  endif
endfunction "}}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
