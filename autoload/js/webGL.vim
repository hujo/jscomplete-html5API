let s:getAPIObject = function('jscomplete_html5API#getAPIObject')
function! js#webGL#Extend (names)
  if !exists('b:GlobalObject')
    return {}
  endif
  call extend(b:GlobalObject, s:getAPIObject('webGL'))
  if exists('g:js_complete_webgl_ns')
    let b:GlobalObject[g:js_complete_webgl_ns] = {
    \   'kind': 'v'
    \ , 'menu': 'webGL.WebGLRenderingContext'
    \ , 'type': 'WebGLRenderingContext'
    \}
  endif
endfunction
