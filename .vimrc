if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings ==========
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
" 依存関係がある場合
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" ====================


" 画面表示の設定============================
set title
set number          " 行番号を表示する
set cursorline      " カーソル行の背景色を変える
set laststatus=2    " ステータス行を常に表示
set cmdheight=2     " メッセージ表示欄を2行確保
set showmatch       " 対応する括弧を強調表示
set helpheight=999  " ヘルプを画面いっぱいに開く
syntax on           " コードに色をつける
set tabstop=4
set list            " 不可視文字を表示
" 不可視文字の表示記号指定
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" deleteキーが効かない対応
set backspace=indent,eol,start

set t_Co=256        " 256色を使う

" ヤンクをクリップボードへ送り込む
set clipboard+=unnamed
" ステータスのところにファイル情報表示
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P

" ctags ===================================
" 拡張子で読み込みタグ変更
au BufNewFile,BufRead *.php set tags+=$HOME/php.tags
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 

" neosnippet ==============================
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" unite.vim ===============================
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" taglist =================================
:set tags=tags
let Tlist_Show_One_File = 1      " 現在表示中のファイルのみのタグしか表示しない
let Tlist_Use_Right_Window = 1   " 右側にtag listのウインドうを表示する
let Tlist_Exit_OnlyWindow = 1    " taglistのウインドウだけならVimを閉じる
" \lでtaglistウインドウを開いたり閉じたり出来るショートカット
map <silent> <leader>l :TlistToggle<CR>

" alias ===================================
:command Tr NERDTree
