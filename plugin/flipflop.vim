function! FlipFlopShowText(text)
    " Save the window number here is not applicable because it could be
    " cahnged by the side-effect of following use of split command.
    let curbufname = bufname("%")
    let bufname = "__STDIFF__"
    let bufwinnr = bufwinnr(bufname)
    let splitted_text = split(a:text, "\n")
    if  bufwinnr == -1
        exec len(splitted_text) 'split ' . bufname
        set buftype=nofile
        set fileformat=unix
        exec bufwinnr(bufname) 'wincmd w'
    else
        exec bufwinnr 'wincmd w'
        exec 'resize ' len(splitted_text)
    endif
    exec "%delete"

    colorscheme decorative-terminal
    call append(0, splitted_text)
    let curwinnr = bufwinnr(curbufname)
    exec curwinnr . 'wincmd w'
endfunction
