let s:getAPIObject = function('jscomplete_html5API#getAPIObject')
function! js#webGL#Extend (names)
  if !exists('b:GlobalObject')
    return {}
  endif
  call extend(b:GlobalObject, s:getAPIObject('webGL'))
  if exists('g:jscomplete_webgl_ns')
    let props = deepcopy(b:GlobalObject.WebGLRenderingContext.props)
    let webgl = {
    \   'kind': 'v'
    \ , 'props': props
    \ , 'menu': 'webGL.WebGLRenderingContext'
    \ , 'type': 'WebGLRenderingContext'
    \}
    if type([]) is type(g:jscomplete_webgl_ns)
      for ns in g:jscomplete_webgl_ns
        let b:GlobalObject[ns] = webgl
      endfor
    elseif type('') is type(g:jscomplete_webgl_ns)
      let b:GlobalObject[g:jscomplete_webgl_ns] = webgl
    endif
  endif
endfunction
