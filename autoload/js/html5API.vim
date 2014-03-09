let s:save_cpo = &cpo
set cpo&vim

function! s:getAPIObject(name)
    return jscomplete_html5API#getAPIObject(a:name)
endfunction

" Browser {{{
function! s:addBrowser()
    let browser = s:getAPIObject('browser')
    call extend(b:GlobalObject, browser)
    call extend(b:GlobalObject, browser.Window.props.prototype.props)
endfunction
" }}}
" DOM {{{
function! s:addDOM()
    let DOMStringMap = {'DOMStringMap' : {'kind' : 'v', 'menu' : '', 'props' : b:GlobalObject.Object.props}}
    call extend(b:GlobalObject, s:getAPIObject('dom'))
    call extend(b:GlobalObject, DOMStringMap)
endfunction
" }}}
" CSS {{{
function! s:addCSS()
    call extend(b:GlobalObject, s:getAPIObject('css'))
    call extend(b:GlobalObject.StyleSheetList.props.prototype.props.item,
        \{'type' : 'CSSStyleSheet'})
    call extend(b:GlobalObject.Document.props.prototype.props,
        \{'stylesheets' : {'kind' : 'v', 'menu' : '', 'type' : 'StyleSheetList'}})
endfunction
" }}}
" Canvas {{{
function! s:addCanvas ()
    call extend(b:GlobalObject, s:getAPIObject('canvas'))
    call extend(b:GlobalObject.Element.props.prototype.props, {
        \'getContext' : {'kind' : 'f', 'menu' : 'get CanvasRenderingContext2D', 'type' : 'CanvasRenderingContext2D'}})
endfunction
" }}}
" FileAPI {{{
function! s:addFileAPI ()
    call extend(b:GlobalObject, s:getAPIObject('fileAPI'))
    call extend(b:GlobalObject, s:getAPIObject('dataTransfer'))
    call extend(b:GlobalObject.Event.props.prototype.props, {
        \   'dataTransfer' : {
        \       'kind' : 'v',
        \       'menu' : 'Event.DataTransfer',
        \       'type' : 'DataTransfer'
        \   }
        \})
endfunction
" }}}
" TypedArrays {{{
function! s:addTypedArrays ()
    call extend(b:GlobalObject, s:getAPIObject('typedArrays'))
endfunction
" }}}
" Worker {{{
let s:Worker = s:getAPIObject('worker')
function! s:addWorker ()
    call extend(b:GlobalObject, s:Worker)
endfunction
" }}}

function! js#html5API#Extend (names)
    if !exists('b:GlobalObject')
        return
    endif
    call s:addBrowser()
    call s:addCSS()
    call s:addDOM()
    call s:addCanvas()
    call s:addFileAPI()
    call s:addTypedArrays()
    call s:addWorker()
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set foldmethod=marker sw=4 ts=4 tw=4
