(define-module web_viewsource
  (export all))

(include-file "include/wf.lfe")
(include-file "include/helpers.lfe")
(defun path () '"/home/cadar/myproject/lfeweb/examples/")

(defun replacements
  ((()) '())
  (((60 . t)) `(38 108 116 59 . ,(replacements t)))
  (((9 . t))  `(32 32 . ,(replacements t)))
  (((h . t))  `(,h . ,(replacements t))))

(defun get-source
  ((module-arg)
   (let* ((compilerinfo (call-str module-arg 'module_info 'compile))
          ;; Source not used! Compilerinfo do not have right value.
          (source (: proplists get_value 'source compilerinfo))  
          ((tuple 'ok b) (: file read_file (++ (path) (++ module-arg '".lfe")))))
     (list '"<!-- " source  '" -->"
	   '"<pre>" 
	   (replacements (binary_to_list b))
	   '"</pre>"))))

(defun main ()
  (let* ((module (hd (: wf q 'module)))
         ((tuple module1 _) (case  module
                              ((119 101 98 95 . es) (: wf_utils path_to_module module))
                              (_ (tuple 'undefined 'undefined)))))
    (get-source module)))

(defun event (_) 'ok)

