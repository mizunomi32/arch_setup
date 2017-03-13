############################################
#
# 環境設定
#
############################################

# 日本語UTF-8環境設定
export LANG=ja_JP.UTF-8

# PATH 追加
export PATH="$PATH;${HOME}/bin"

# beep無効
setopt no_beep

############################################
# 履歴

# 履歴ファイルの保存先
export HISTFILE=${ZSHHOME}/zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複する履歴を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

# 複数ターミナル間で履歴の共有
setopt share_history

# スペースから始まるコマンド行は履歴に含まない
setopt hist_ignore_space

# 履歴の余分なスペース除去
setopt hist_reduce_blanks

############################################
# 補完

# 自動補完の有効化
autoload -U compinit && compinit

# ディレクトリ名でcd
setopt auto_cd

# sudo の後ろも補完
# zstyle ':completion:*:sudo:*' command-path 
