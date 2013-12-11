let s:basedir = expand('<sfile>:h:h:h') . '/static'
let s:count = 0

function! webapp#foo#handle(req)
  if a:req.path == '/foo'
    " redirect
    return webapp#redirect(a:req, "/foo/")
  elseif a:req.path == '/foo/api' && a:req.method == 'POST'
    " count up
    let s:count += 1
    let params = webapp#params(a:req)
    return webapp#json(a:req, {"value": s:count}, get(params, 'callback'))
  else
    " strip path
    let a:req.path = a:req.path[4:]
    " serve static files
    return webapp#servefile(a:req, s:basedir)
  endif
endfunction
