set nocompatible
filetype off

if has('win32') || has ('win64')
    set runtimepath^=$HOME\.vim runtimepath+=$HOME\.vim\after
endif
let s:deinDir       = ! exists('s:deinDir') ? $HOME . '/.vim/dein.vim' : s:deinDir
let s:dein_repo_dir = s:deinDir . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" dein.vim {{{
if dein#load_state(s:deinDir)
    call dein#begin(s:deinDir)
    call dein#add('KazuakiM/neosnippet-snippets')
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    call dein#add('junegunn/vim-easy-align')
    call dein#add('thinca/vim-ref')
    call dein#add('Yggdroot/indentLine')
    call dein#add('mbbill/VimExplorer')
    call dein#add('vim-syntastic/syntastic')
    call dein#add('itchyny/lightline.vim')
"    call dein#add('edkolev/tmuxline')
    call dein#add('violetyk/neocomplete-php.vim')
    call dein#add('vim-scripts/PDV--phpDocumentor-for-Vim')
"    call dein#add('SirVer/ultisnips')
"    call dein#add('tobyS/vmustache')
"    call dein#add('tobyS/pdv')
    call dein#end()
    call dein#save_state()
endif
" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif
"}}}
filetype plugin indent on
syntax enable

set modeline
set number
set tabstop=4 softtabstop=4 shiftwidth=4
set laststatus=2         " ステータス行を表示
set hlsearch             " 検索時にハイライト表示
" Esc連打でハイライト解除：
nmap <Esc><Esc> :nohlsearch<CR><Esc>
set ambiwidth=double     " 記号文字の表示がおかしくならないように
set foldmethod=marker    " 畳み込み指定
set nobackup
set expandtab
set encoding=utf8
set autoread

" phpファイルの場合 下矢印で文法チェックをする
"autocmd FileType php :map <DOWN> <ESC>:!clear<CR>:!php -l %<CR>
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
autocmd FileType php :map <DOWN> <ESC>:make<CR>
autocmd FileType php :map <C-E> <ESC>:!php %<CR>

map <LEFT>  <ESC>:bp<CR>
map <RIGHT> <ESC>:bn<CR>
map <UP>    <ESC>:ls<CR>
map <C-A>   <ESC>:'<,'>Align =><CR>

"表示行単位で移動(snippet展開対策済み)
nnoremap j gj
onoremap j gj
xnoremap j gj
nnoremap k gk
onoremap k gk
xnoremap k gk

"phpmanual
let g:ref_use_vimproc = 0
let g:ref_phpmanual_path = '/data/ApplicationData/chm/php-chunked-xhtml'

" php-doc
" Default values
" let g:pdv_cfg_Type      = "string"
" let g:pdv_cfg_Package   = ""
" let g:pdv_cfg_Version   = "$id$"
" let g:pdv_cfg_Author    = "hashimoto <hashimoto@no1s.biz>"
" let g:pdv_cfg_Copyright = "Copyright (C) 2007 Hoge Corporation. All Rights Reserved."
" let g:pdv_cfg_License   = "PHP Version 5.0 {@link http://www.php.net/license/5_0.txt}"
" let g:pdv_template_dir = $HOME ."/.vim/pdv/templates"
autocmd FileType php inoremap <C-p> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-p> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-p> :call PhpDocRange()<CR> 


" ステータスラインの変更


" Vim EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" 使い方..................
" Shift+vの行選択ビジュアルモードで対象行となる4行を選択してからgaキーを入力すると、Vimのコマンドラインに以下のようなコマンドが表示される。
"
" :EasyAlign (_)
" その後、続けて*,と入力すればテキスト整形される。
" ここで*,の意味だが、2文字目の,はデリミタを表す。例えば元の文字列が,ではなく|で句切られていたとすれば、*|と入力すればよい。
" デリミタとしてデフォルトで定義されているものは<Space>, =, :, ., |, &, #,
" ,である。
"
" 1文字目の*は何番目のデリミタに対してテキスト整形を適用するかを表す。*は全てを対象にするが、1,と入力すれば（デフォルトでは1なので,だけでもよい）、

vnoremap <silent> <Leader>a :EasyAlign<CR>
let g:easy_align_delimiters = {
\    '=': {
\        'pattern': '===\|!==\|<=>\|\(&&\|||\|<<\|>>\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.-]\?=[#?]\?',
\        'left_margin': 1,
\        'right_margin': 1,
\        'stick_to_left': 0 },
\    '>': {
\        'pattern': '>>\|=>\|>', },
\    '/': {
\        'pattern':       '//\+\|/\*\|\*/',
\        'ignore_groups': ['String'], },
\    '#': {
\        'pattern':         '#\+',
\        'ignore_groups':   ['String'],
\        'delimiter_align': 'l', },
\    '$': {
\        'pattern':         '\((.*\)\@!$\(.*)\)\@!',
\        'ignore_groups':   ['String'],
\        'right_margin':  0,
\        'delimiter_align': 'l', },
\    ']': {
\        'pattern':       '[[\]]',
\        'left_margin':   0,
\        'right_margin':  0,
\        'stick_to_left': 0, },
\    ')': {
\        'pattern':       '[()]',
\        'left_margin':   0,
\        'right_margin':  0,
\        'stick_to_left': 0, },
\    'd': {
\        'pattern':      ' \(\S\+\s*[;=]\)\@=',
\        'left_margin':  0,
\        'right_margin': 0, }, }
"}}}
"}}}

" vim-ref {{{
inoremap <silent><C-k> <C-o>:call<Space>ref#K('normal')<CR><ESC>
nmap <silent>K <Plug>(ref-keyword)
let g:ref_no_default_key_mappings = 1
let g:ref_cache_dir               = $HOME . '/.vim/vim-ref/cache'
let g:ref_detect_filetype         = {
\    'css':        'phpmanual',
\    'html':       ['phpmanual',  'javascript', 'jquery'],
\    'javascript': ['javascript', 'jquery'],
\    'php':        ['phpmanual',  'javascript', 'jquery']
\}
let g:ref_javascript_doc_path = $HOME . '/.vim/dein.vim/repos/github.com/tokuhirom/jsref/htdocs'
let g:ref_jquery_doc_path     = $HOME . '/.vim/dein.vim/repos/github.com/mustardamus/jqapi'
let g:ref_phpmanual_path      = $HOME . '/.vim/vim-ref/php-chunked-xhtml'
let g:ref_use_cache           = 1
let g:ref_use_vimproc         = 1
"}}}

" 以下補完機能
"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<TAB>"
        else
                if pumvisible()
                        return "\<C-N>"
                else
                        return "\<C-N>\<C-P>"
                end
        endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

"snippets コードスニペッド
" Plugin key-mappings.  " <C-k>でsnippetの展開
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = '~/.vim/snippets/'

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable omni completion.
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags


" 以下のようにすると自分定義ファイルも追加できるみたい
"let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets, ~/.vim/mysnippets'

" 参照先
" http://c-brains.jp/blog/wsg/12/07/30-094244.php
"
" Load settings for each location.
augroup vimrc-local
    autocmd!
    autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
    let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

