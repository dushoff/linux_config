" Mike, do you have this file?
" Weird escape decoding
map O1;2Q <S-F2>
map! O1;2Q <S-F2>
map [1;2Q <S-F2>
map! [1;2Q <S-F2>
map [1;5R <C-F3>
map! [1;5R <C-F3>
map O1;2S <S-F4>
map! O1;2S <S-F4>
map [1;2S <S-F4>
map! [1;2S <S-F4>
map [1;5S <C-F4>
map! [1;5S <C-F4>
map O1;6S <C-S-F4>
map! O1;6S <C-S-F4>
map [1;6S <C-S-F4>
map! [1;6S <C-S-F4>
map [15;5~ <C-F5>
map [15;5~ <C-F5>
map [15;6~ <C-S-F5>
map! [15;6~ <C-S-F5>
map [17;6~ <C-S-F6>
map! [17;6~ <C-S-F6>

map [19;2~ <S-F8>
map! [19;2~ <S-F8>
map [20;2~ <S-F9>
map! [20;2~ <S-F9>
map [21~ <F10>
map! [21~ <F10>
map [21;5~ <C-F10>
map! [21;5~ <C-F10>

map <F2> gs
map <S-F2> gr
map <C-F3> :make -dr pull > make.log && make exclude && git status<C-M>
map <F4> :make!<C-M>
map <S-F4> :!make vtarget<C-M>
map <S-F5> :!make pdftarget<C-M>
map <C-S-F4> :!make pdftarget<C-M>
map <C-F4> :make -dr sync > make.log && git status<C-M>
map <F5> :cn<C-M>
map <C-F5> :make -dr all.time > make.log && git status<C-M>
map <C-S-F5> :make -dr newSource tsync all.time > make.log && git status<C-M>
map <C-S-F6> :!vsave; sleep 1<C-M>:make -dr newSource tsync all.time > make.log && git status<C-M>
map <F6> :cp<C-M>
map <F7> :x<C-M>
map <S-F7> gz
map <F8> :w<F4>
map <S-F8> gi<F8>
map <F9> :wall<C-M>
map <S-F9> :wall<C-M>:bd<C-M>

map! <F1> <ESC><F1>
map! <F2> <ESC><F2>
map! <S-F2> <ESC><S-F2>
map! <F3> <ESC><F3>
map! <F4> <ESC><F4>
map! <S-F4> <ESC><S-F4>
map! <C-F4> <ESC><C-F4>
map! <C-S-F4> <ESC><C-S-F4>
map! <F5> <ESC><F5>
map! <F6> <ESC><F6>
map! <F7> <ESC><F7>
map! <S-F7> <ESC><S-F7>
map! <F8> <ESC><F8>
map! <S-F8> <ESC><S-F8>
map! <F9> <ESC><F9>
map! <S-F9> <ESC><S-F9>
map! <F10> <ESC><F10>
map! <F11> <ESC><F11>
map! <F12> <ESC><F12>

nmap d- Vg-d
nmap d_ Vg_d

nmap gM :make <cfile><C-M>
nmap gf :e <cfile><C-M>

" Old (pre F2) makefile navigation stuff. Maybe?
" nmap gr mg0f:B:let target=expand("<cfile>")<C-M>:let target=escape(target,'/')<C-M>W:let input=expand("<cfile>")<C-M>$b:let program=expand("<cfile>")<C-M>:exe "%s@target:.*@target: " . target "@"<C-M>`g
" nmap gs mg0f:B:let target=expand("<cfile>")<C-M>W:let input=expand("<cfile>")<C-M>$b:let program=expand("<cfile>")<C-M>1mh:exe "%s/target:.*/target: " . target "/"<C-M>`h`g

" current F2 engine; old idea of gs for <go script> seems tromped
" could change this to gS and do navigation to rebuild gs
nmap gs mg0f:B:let target=expand("<cfile>")<C-M>:let target=escape(target,'/')<C-M>W:let input=expand("<cfile>")<C-M>$b:let program=expand("<cfile>")<C-M>:e target.mk<C-M>mh:exe "%s/target.*=.*/target = " . target "/"<C-M>`h`g

nmap gF :let ff=expand("<cfile>")<C-M>:let ff=substitute(ff,"Rout","R", "")<C-M>:exe "e ".ff<C-M>

" nmap gu gmgg/target.*:<C-M>f:wvE"sy:let @s=escape(@s,'/')<C-M>:exe "/" .@s. ".*:"<C-M>
nmap gu :e target.mk<C-M>gg/target.*=<C-M>f=wvE"sy1<C-^>:let @s=escape(@s,'/')<C-M>:exe "/\\<" .@s. ".*:"<C-M>
nmap gU gmgugs
autocmd * VimEnter gU

nn Q gq
nn go 7
nn gn 6
nn gk 5
nn gj 4
nn gd 3
nn gc 2
nn gm 1

nn gt :exe "e " . target<C-M>
nn gp :exe "e " . program<C-M>
nn gi :exe "e " . input<C-M>

nn gT 1g0f:B:e <cfile><C-M>
nn gP 1g$b:e <cfile><C-M>
nn gI 1g0f:BW:e <cfile><C-M>

nn @p yyPi.PRECIOUS: <ESC>f:D<ESC>
nn @i yyPiIgnore += <ESC>f:D<ESC>

nn  :wn<C-M>
