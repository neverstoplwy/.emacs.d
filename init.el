;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;miscellaneous setup;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/load-path"))

;;-----设置个人信息
(setq user-full-name "WenyongLiu")
(setq user-mail-address "neverstoplwy@gmail.com")

;;-----设置窗口位置
(set-frame-position (selected-frame) 60 40)
(set-frame-width (selected-frame) 160)
(set-frame-height (selected-frame) 50)

;;-----y/n代表yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;-----去掉工具栏及菜单栏
(tool-bar-mode 0)
;;(menu-bar-mode 0)

;;-----显示时间
(display-time-mode 1) 
(setq display-time-24hr-format t) 
(setq display-time-day-and-date t)

;;-----绑定c-j为新的一行，无论在什么位置----
(global-set-key (kbd "C-j") '(lambda () 
(interactive) 
(move-end-of-line 1) 
(newline)))

;;-----标记开始  
(global-set-key (kbd "C-'") 'set-mark-command)

;;-----显示行号line-num.el文件显示行号
(global-linum-mode t)

;;----设置光标为竖线  
(setq-default cursor-type 'bar)

;;-----括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号  
(show-paren-mode t)  
(setq show-paren-style 'parentheses)

;;----关闭开机画面  
(setq inhibit-startup-message t)

;;----tabbar栏设置 alt jk 左右移动，所以buff一个分组------
(require 'tabbar)
(tabbar-mode 1)

(global-set-key (kbd "C-9") 'tabbar-backward)
(global-set-key (kbd "C-0") 'tabbar-forward)
(setq
 tabbar-scroll-left-help-function nil  
 tabbar-scroll-right-help-function nil
 tabbar-help-on-tab-function nil
 tabbar-home-help-function nil
 tabbar-buffer-home-button (quote (("") ""))
 tabbar-scroll-left-button (quote (("") ""))
 tabbar-scroll-right-button (quote (("") "")))
(defun my-tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
Return a list of one element based on major mode."
  (list "all"))
(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)

;;----用C-.做标记,用C-,切换-------------------------
(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))


;-----定义c-l拷贝当前行-----------
(defun copy-line (&optional arg)
;"Save current line into Kill-Ring without mark the line"
(interactive "P")
(let ((beg (line-beginning-position))
   (end (line-end-position arg)))
(copy-region-as-kill beg end))
)
(global-set-key (kbd "C-l") 'copy-line)

;------------------------alt和箭头整行移动-------------------
(global-set-key [(meta up)] 'move-line-up)
(global-set-key [(meta down)] 'move-line-down)
(defun move-line (&optional n)
  (interactive "p")
  (when (null n)
    (setq n 1))
  (let ((col (current-column)))
    (beginning-of-line)
    (next-line 1)
    (transpose-lines n)
    (previous-line 1)
    (forward-char col)))
(defun move-line-up (n)
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  (interactive "p")
  (move-line (if (null n) 1 n)))

;;-----书签对应的快捷键
(global-set-key [f7] 'bookmark-set);设置书签
(global-set-key [f8] 'edit-bookmarks);编辑书签
(global-set-key [f9] 'bookmark-jump);切换至对应的书签

;;-----设置日历
(setq calendar-load-hook
'(lambda ()
(set-face-foreground 'diary-face "skyblue")
(set-face-background 'holiday-face "slate blue")
(set-face-foreground 'holiday-face "white")))

;;-----让emacs能计算日出日落的时间，在 calendar 上用 S 即可看到
(setq calendar-latitude +39.54)
(setq calendar-longitude +116.28)
(setq calendar-location-name "北京")

;;-----设置阴历显示，在 calendar 上用 pC 显示阴历
(setq chinese-calendar-celestial-stem
  ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
  ["子" "丑" "寅" "卯" "辰" "巳" "戊" "未" "申" "酉" "戌" "亥"])
(setq calendar-remove-frame-by-deleting t)
(setq calendar-week-start-day 1) ; 设置星期一为每周的第一天
(setq mark-diary-entries-in-calendar t) ; 标记calendar上有diary的日期

