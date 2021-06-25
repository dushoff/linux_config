map <F2> gs
map <S-F2> gr
map <C-F3> :make! -dr pullup > make.log && make exclude && git status<C-M>
map <F4> :make! target<C-M>
map <S-F4> :!make pdftarget<C-M>
map <C-S-F4> :!make vtarget<C-M>
map <C-F4> :make -dr sync > make.log && git status .<C-M>
map <F5> :cn<C-M>
map <C-F5> :make! -dr all.time > make.log && git status .<C-M>
map <S-F5> :!make pdftarget<C-M>
map <C-S-F5> :make -dr allsync > make.log && git status<C-M>
map <F6> :cp<C-M>
map <C-S-F6> :!vsave; sleep 1<C-M>:make -dr allsync > make.log && git status<C-M>
map <F7> :x<C-M>
map <S-F7> gz
map <F8> :w<F4>
map <S-F8> gi<F8>
map <F9> :wall<C-M>
map <S-F9> :wall<C-M>:bd<C-M>
map <S-F10> :!vmake > make.log<C-M>
map <C-F10> :!pmake > make.log<C-M>

nmap d- Vg-d
nmap d_ Vg_d

nmap gM :make! <cfile><C-M>
nmap gf :e <cfile><C-M>

" current F2 engine; old idea of gs for <go script> seems tromped
" could change this to gS and do navigation to rebuild gs
nmap gs mg0f:B:let target=expand("<cfile>")<C-M>:let target=escape(target,'/')<C-M>W:let input=expand("<cfile>")<C-M>$b:let program=expand("<cfile>")<C-M>:e target.mk<C-M>mh:exe "%s/target.*=.*/target = " . target "/"<C-M>`h`g

nmap gF :let ff=expand("<cfile>")<C-M>:let ff=substitute(ff,".Rout",".R", "")<C-M>:let ff=substitute(ff,".rda",".R", "")<C-M>:exe "e ".ff<C-M>

" nmap gu gmgg/target.*:<C-M>f:wvE"sy:let @s=escape(@s,'/')<C-M>:exe "/" .@s. ".*:"<C-M>
nmap gu :e target.mk<C-M>gg/target.*=<C-M>f=wvE"sy1<C-^>:let @s=escape(@s,'/')<C-M>:exe "/\\<" .@s. ".*:"<C-M>
nmap gU gmgugs
" autocmd VimEnter * normal gU " Finally works, but extra vims conflict now

nn Q gq
nn gr 8
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
nn gS 1g0f:BW:e <cfile><C-M>

nn @p yyPi.PRECIOUS: <ESC>f:D<ESC>
nn @i yyPiIgnore += <ESC>f:D<ESC>

nn  :wn<C-M>
