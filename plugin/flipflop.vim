function! FlipFlopMoveToBufferInCurrentWindow(bufspec)
    let typenr = type(a:bufspec)
    if typenr == 0 " Number
        exec a:bufspec 'wincmd w'
    elseif typenr == 1 " String
        let winnr = bufwinnr(a:bufspec)
        if winnr != -1
            exec winnr 'wincmd w'
        endif
    endif
endfunction

" Open the FlipFlop buffer. Height argument controls the height of
" opened flipflop buffer If a:keep_current is 1, the original current
" buffer will retrieved as the current buffer at the end of function. If
" a:keep_current is 0, the opened flipflop buffer will be the current
" buffer after the function call. It deletes the contents of flipflop
" buffer.
function! FlipFlopOpenFlipFlopBuffer(height, keep_current)
    let land_on = ''
    if a:keep_current == 1
        let land_on = bufname("%")
    else
        let land_on = g:flipflop_buffer_name
    endif
    if exists("g:flipflop_buffer_align_topof")
        let align_bufferwinnr = bufwinnr(g:flipflop_buffer_align_topof)
        if align_bufferwinnr != -1
            call FlipFlopMoveToBufferInCurrentWindow(align_bufferwinnr)
        endif
    endif
    exec a:height 'split ' g:flipflop_buffer_name
    set buftype=nofile
    set fileformat=unix
    colorscheme decorative-terminal
    exec "%delete"

    call FlipFlopMoveToBufferInCurrentWindow(land_on)
endfunction


function! FlipFlopShowText(text)
    " Save the window number here is not applicable because it could be
    " cahnged by the side-effect of following use of split command.
    let curbufwinnr = bufwinnr("%")
    let bufwinnr = bufwinnr(g:flipflop_buffer_name)
    let splitted_text = split(a:text, "\n")
    if  bufwinnr == -1
        call FlipFlopOpenFlipFlopBuffer(len(splitted_text), 0)
    else
        exec bufwinnr 'wincmd w'
        exec 'resize ' len(splitted_text)
        exec "%delete"
    endif
    call append(0, splitted_text)
    call cursor(1,0)
    call FlipFlopMoveToBufferInCurrentWindow(curbufwinnr)
endfunction
