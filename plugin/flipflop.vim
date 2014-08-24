function! FlipFlopShowText(text)
    " Save the window number here is not applicable because it could be
    " cahnged by the side-effect of following use of split command.
    let curbufname = bufname("%")
    let bufname = "__STDIFF__"
    let bufwinnr = bufwinnr(bufname)
    if  bufwinnr == -1
        exec '5split ' . bufname
        set buftype=nofile
        let bufwinnr = bufwinnr(bufname)
    endif

    exec bufwinnr 'wincmd w'
    colorscheme decorative-terminal
    call append(0, a:text)
    let curwinnr = bufwinnr(curbufname)
    exec curwinnr . 'wincmd w'
endfunction
