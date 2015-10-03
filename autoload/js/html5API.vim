let s:save_cpo = &cpo
set cpo&vim

let s:getAPIObject = function('jscomplete_html5API#getAPIObject')

" add API Objects {{{1
" Browser {{{2
function! s:addBrowser()
  let browser = s:getAPIObject('browser')
  call extend(b:GlobalObject, browser)
  call extend(b:GlobalObject, browser.Window.props.prototype.props)
endfunction

" DOM {{{2
function! s:addDOM()
  call extend(b:GlobalObject, s:getAPIObject('dom'))
  " [Add] Domstringmap
  let DOMStringMap = {'DOMStringMap' : {'kind' : 'v', 'menu' : '', 'props' : b:GlobalObject.Object.props}}
  call extend(b:GlobalObject, DOMStringMap)

  " [Update] Image() type <- HTMLImageElement
  let b:GlobalObject.Image.type = 'HTMLImageElement'

  " [Extend] HTMLImageElement <- Element
  call extend(b:GlobalObject.HTMLImageElement.props.prototype.props,
  \b:GlobalObject.Element.props.prototype.props)

  " [Update] document.body : HTMLBodyElement -> Element
  let b:GlobalObject.Document.props.prototype.props.body.type = "Element"
endfunction

" CSS {{{2
function! s:addCSS()
  call extend(b:GlobalObject, s:getAPIObject('css'))
  " [Update] document.stylesheets : StyleSheet -> CSSStyleSheet
  call extend(b:GlobalObject.StyleSheetList.props.prototype.props.item,
  \{'type' : 'CSSStyleSheet'})
  call extend(b:GlobalObject.Document.props.prototype.props,
  \{'stylesheets' : {'kind' : 'v', 'menu' : '', 'type' : 'StyleSheetList'}})
endfunction

" Canvas {{{2
function! s:addCanvas ()
  call extend(b:GlobalObject, s:getAPIObject('canvas'))

  " [Add] Element.getContext
  call extend(b:GlobalObject.Element.props.prototype.props, {
  \'getContext' : {'kind' : 'f', 'menu' : 'get CanvasRenderingContext2D', 'type' : 'CanvasRenderingContext2D'}})
endfunction

" FileAPI {{{2
function! s:addFileAPI ()
  call extend(b:GlobalObject, s:getAPIObject('fileAPI'))

  " Add Event.datatransfer
  call extend(b:GlobalObject, s:getAPIObject('dataTransfer'))
  call extend(b:GlobalObject.Event.props.prototype.props, {
  \   'dataTransfer' : {
  \       'kind' : 'v',
  \       'menu' : 'Event.DataTransfer',
  \       'type' : 'DataTransfer'
  \   }
  \})
endfunction

" Geolocation {{{2
function! s:addGeolocation()
  call extend(b:GlobalObject.Navigator.props.prototype.props, {
  \   'geolocation' : {
  \       'kind': 'v',
  \       'type': 'Object',
  \       'props': {
  \           'getCurrentPosition': {'kind': 'f', 'type': 'undefined'},
  \           'watchPosition': {'kind': 'f', 'type': 'undefined'},
  \           'clearWatch': {'kind': 'f', 'type': 'undefined'}
  \       },
  \       'menu': '[Geolocation]'
  \   }
  \})
endfunction
" }}}

" TypedArrays {{{2
function! s:addTypedArrays ()
  call extend(b:GlobalObject, s:getAPIObject('typedArrays'))
endfunction

" Worker {{{2
let s:Worker = s:getAPIObject('worker')
function! s:addWorker ()
  call extend(b:GlobalObject, s:Worker)
endfunction

" }}}1
function! js#html5API#Extend (names)
  if !exists('b:GlobalObject')
    return {}
  endif
  call s:addBrowser()
  call s:addCSS()
  call s:addDOM()
  call s:addCanvas()
  call s:addFileAPI()
  call s:addTypedArrays()
  call s:addWorker()
  call s:addGeolocation()
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__ {{{1
" vim :set fdm=marker fmr={{{,}}} fenc=utf-8:
