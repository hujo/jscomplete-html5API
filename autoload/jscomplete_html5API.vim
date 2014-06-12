let s:save_cpo = &cpo
set cpo&vim

let s:TYPE_FNCTION = type(function('tr'))
let s:TYPE_DICT    = type({})

let s:JSONS_DIR       = globpath(expand('<sfile>:p:h') . '/..', 'jsons/')
let s:API_FILES_NAMES = map(split(globpath(s:JSONS_DIR, '*.json'), '\n'), 'fnamemodify(v:val,":t:r")')

let s:API_FILES = {}

for s:api_name in s:API_FILES_NAMES
    let s:API_FILES[tolower(s:api_name)] = {
        \   'path' : s:JSONS_DIR . s:api_name . '.json',
        \}
endfor

function! s:getAPIObject(api_dict)
    let api_dict = a:api_dict
    let api_dict['object'] = has_key(api_dict, 'object') ?
    \   api_dict['object'] : eval(join(map(readfile(api_dict.path), 'iconv(v:val, "utf8", &encoding)'))
    return deepcopy(api_dict['object'])
endfunction

function! jscomplete_html5API#showAPIList()
    return keys(s:API_FILES)
endfunction

function! jscomplete_html5API#getAPIObject(name)
    let api_dict = get(s:API_FILES, tolower(a:name), 0)
    if type(api_dict) == s:TYPE_DICT
        return s:getAPIObject(api_dict)
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set foldmethod=marker sw=4 ts=4 tw=4
