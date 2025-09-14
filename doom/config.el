;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;; (setq doom-font (font-spec :family "ComicShannsMono Nerd Font" :size 16)
;;       doom-symbol-font(font-spec :family "CaskaydiaCove NF" :size 16))
(setq doom-font (font-spec :family "ComicShannsMono Nerd Font" :size 18)
      doom-symbol-font (font-spec :family "CaskaydiaCove NF" :size 18)
      doom-big-font (font-spec :family "ComicShannsMono Nerd Font" :size 24))
                                        ;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-Iosvkem)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(after! org-roam
  ;; Make sure the dailies feature is enabled
  (require 'org-roam-dailies)

  ;; Set the directory where your daily notes will be stored.
  ;; It's good practice to make this a subdirectory of your main org-roam-directory.
  (setq org-roam-dailies-directory "/Users/kai/org/roam/dailies")
  (add-to-list 'org-agenda-files org-roam-dailies-directory)
  ;; Define the template for your daily notes.
  ;; This is the most powerful part of the configuration.
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%A, %B %d, %Y>\n"))))
  (map! :leader :prefix "n" :desc "Org Roam Dailies" "d" #'org-roam-dailies-goto-today))



;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; -------------------------------
;; Org & Roam Directories
;; -------------------------------
;; Define all org-related paths in one place, before they are used.
(setq org-directory (expand-file-name "~/org"))
(setq org-roam-directory (expand-file-name "roam" org-directory))
(setq org-roam-dailies-directory (expand-file-name "dailies" org-roam-directory))


;; -------------------------------
;; Org-roam integration
;; -------------------------------
(after! org-roam
  ;; --- Org Roam Dailies ---
  (require 'org-roam-dailies)

  ;; Add the dailies directory to the agenda files.
  ;; Doom's +roam2 module handles org-roam-directory, but we must add
  ;; the dailies directory manually. Using add-to-list is safer than setq.
  (add-to-list 'org-agenda-files org-roam-dailies-directory)

  ;; Dailies capture template
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%A, %B %d, %Y>\n"))))

  ;; Dailies keybinding
  (map! :leader :prefix "n" :desc "Org Roam Dailies" "d" #'org-roam-dailies-goto-today)

  ;; --- General Org Roam Settings ---
  ;; Automatically assign IDs to new nodes
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
  ;; Prettify org-roam links
  (setq org-roam-node-display-template "${title}"))

;; --- Other Org Settings ---
(setq org-id-locations-file (expand-file-name "org-id-locations" doom-cache-dir))
(setq org-startup-with-inline-images t)    ;; auto display images

;; -------------------------------
;; Org-modern setup
;; -------------------------------
(use-package! org-modern
  :after org
  :hook (org-mode . org-modern-mode)
  :config
  ;; Hiding heading stars for cleaner look
  (setq org-modern-hide-stars t)
  ;; Remove brackets around links
  (setq org-modern-label-border 0)
  ;; Optional: cleaner code block fringe
  (setq org-modern-block-fringe nil)
  ;; Prettify inline code/literals
  (setq org-modern-prettify-symbols t)
  (+org-pretty-mode 1))

;; -------------------------------
;; Faces / Styling
;; -------------------------------
(custom-set-faces!
  ;; Links: colored, underlined
  '(org-link :inherit link :foreground "#5fafff" :underline t)
  ;; Italics
  '(italic :slant italic)
  ;; Inline code / literals
  '(org-verbatim :inherit fixed-pitch :foreground "#ff7f50")
  '(org-code :inherit fixed-pitch :foreground "#ff7f50")
  ;; Callouts / admonitions
  '(org-block-begin-line :inherit font-lock-keyword-face :foreground "#5fafff")
  '(org-block :background "#f0f8ff" :extend t))

;; -------------------------------
;; Admonition / Callouts
;; -------------------------------
(font-lock-add-keywords
 'org-mode
 '(("^#\\+BEGIN_ADMONITION.*TIP.*$" . 'font-lock-function-name-face)
   ("^#\\+BEGIN_ADMONITION.*WARNING.*$" . 'font-lock-warning-face)
   ("^#\\+BEGIN_ADMONITION.*DANGER.*$" . 'font-lock-error-face)
   ("^#\\+BEGIN_ADMONITION.*INFO.*$" . 'font-lock-comment-face)))
;; -------------------------------
;; Fontification & LSP for source blocks
;; -------------------------------
;; Enable syntax highlighting in src blocks
(setq org-src-fontify-natively t)
;; Keep editing blocks in current window for proper font-lock
(setq org-src-window-setup 'current-window)

;; Optional: use LSP inside code blocks (Java example)
(use-package! lsp-mode
  :commands lsp
  :hook ((java-mode . lsp)
         ;; Add other languages here if needed
         ))
(custom-set-faces!
  '(org-block :background "#22242B" :extend t))

;; -------------------------------
;; Babel
;; -------------------------------
(org-babel-do-load-languages
 'org-babel-load-languages
 '((java . t)))
;; -------------------------------
;; Hugo
;; -------------------------------
(after! org
  (require 'ox-hugo)
  (setq time-stamp-active t
        time-stamp-start "#\\+hugo_lastmod:[ \t]*"
        time-stamp-end "$"
        time-stamp-format "\[%Y-%m-%d\]")
  (add-hook 'before-save-hook 'time-stamp))
;; -------------------------------
;; Org-Roam templates
;; -------------------------------
(after! org
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n#+filetags:\n#+hugo_section: notes | blog\n#+date: [%<%Y-%m-%d>]\n#+hugo_lastmod: [%<%Y-%m-%d>]\n#+hugo_tags: noexport\n")
           :unnarrowed t))))

(after! which-key
  (setq which-key-idle-delay 0.2))

(setq-default indent-tabs-mode nil)
;; Set default indent size (for modes that respect it)
(setq-default tab-width 2
              standard-indent 2)
(after! centaur-tabs
  (map! :n "H" #'centaur-tabs-backward
        :n "L" #'centaur-tabs-forward))
(map! :n "C-h" #'windmove-left
      :n "C-j" #'windmove-down
      :n "C-k" #'windmove-up
      :n "C-l" #'windmove-right)

(map! :after lsp-mode
      :n "K" #'lsp-ui-doc-glance)

(require 'neotree)
(after! neotree
  (map!
   :leader
   :desc "NeoTree"
   "e" #'neotree-toggle))

(after! evil-surround
  (map! :n "gsa" #'evil-surround-edit
        :v "gsa" #'evil-surround-region
        :n "gsd" #'evil-surround-delete
        :n "gsr" #'evil-surround-edit))
