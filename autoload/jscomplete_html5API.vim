let s:save_cpo = &cpo
set cpo&vim

let s:DEBUG = 0
let s:TYPE_DICT = type({})

let s:JSONS_DIR       = globpath(expand('<sfile>:p:h') . '/..', 'jsons/')
let s:API_FILES_NAMES = map(split(globpath(s:JSONS_DIR, '*.json'), '\n'), 'fnamemodify(v:val,":t:r")')

let s:API_FILES = {}

for s:api_name in s:API_FILES_NAMES
    let s:API_FILES[tolower(s:api_name)] = {
        \   'path' : s:JSONS_DIR . s:api_name . '.json',
        \}
    unlet s:api_name
endfor

" functions  {{{1

function! s:getAPIObject(api_dict) " {{{2
    let api_dict = a:api_dict
    if has_key(api_dict, 'object')
        return deepcopy(api_dict['object'])
    endif
    let encode = get(split(&fileencodings, ','), 0, &encoding)
    let json = join(readfile(api_dict.path), '')
    let api_dict['object'] = eval(json)
    return deepcopy(api_dict['object'])
endfunction

function! jscomplete_html5API#JSONFileList() " {{{2
    return keys(s:API_FILES)
endfunction

function! jscomplete_html5API#getAPIObject(name) " {{{2
    let api_dict = get(s:API_FILES, tolower(a:name), 0)
    if type(api_dict) == s:TYPE_DICT
        return s:getAPIObject(api_dict)
    else
        echoerr a:name ' is not exists'
        return ''
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__ {{{1
" vim:set et:
