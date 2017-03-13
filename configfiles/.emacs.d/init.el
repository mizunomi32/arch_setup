;; 日本語UTF-8設定
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; スタートアップメッセージ無効
(setq inhibit-startup-message t)

;; バックアップファイルを作らない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを消去
(setq delete-auto-seve-file t)

;; タブを４スペースに
(setq-default tab-width 4 indent-tabs-mode nil)

;; 改行コード表示
(setq eol-mnemomic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-monemonic-unix "(LF)")

;; 複数ウィンド表示禁止
(setq ns-pop-up-frames nil)

;; メニューバー非表示
(menu-bar-mode -1)

;; ツールバー非表示
(tool-bar-mode -1)

;; 列数表示
(column-number-mode t)

;; 行数表示
(global-linum-mode t)
(setq linum-format "%04d|")

;; カーソル点滅無効
(blink-cursor-mode 0)

;; カーソル行ハイライト
(global-hl-line-mode t)

;; 対応するカッコを強調
(show-paren-mode 1)

;; タブ,スペースの可視化
;;(global-whitespace-mode 1)

;; スクロールを１行毎
(setq scrool-conservatively 1)

;; シフト＋矢印で選択
;;(setq pc-select-selection-keys-only t)
;;(pc-selection-mode 1)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Auto Compllete
;; 設定ファイルロード
(require 'auto-complete-config)

(ac-config-default)

;; tab補完有効化
(ac-set-trigger-key "TAB")

;; auto-complete-mode を起動時に有効
(global-auto-complete-mode t)

