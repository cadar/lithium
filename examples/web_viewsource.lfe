(define-module web_viewsource
  (export all))

(include-file "lfeweb/wf.lfe")
(include-file "lfeweb/helpers.lfe")
(defun path () '"/home/cadar/myproject/lfeweb/examples/")

(defun replacements
  ((()) '())
  (((60 . t)) (cons 38 (cons 108 (cons 116 (cons 59 (replacements t))))))
  (((9 . t)) (cons 32 (cons 32 (replacements t))))
  (((h . t)) (cons h (replacements t))))

(defun get-source
  ((module-arg)
   (let* ((compilerinfo (call-str module-arg 'module_info 'compile))
          ;; Source not used! Compilerinfo do not have right value.
          (source (: proplists get_value 'source compilerinfo))  
          ((tuple 'ok b) (: file read_file (++ (path) (++ module-arg '".lfe")))))
     (list '"<pre>" 
           (replacements (binary_to_list b))
           '"</pre>"))))

(defun main ()
  (let* ((module (hd (: wf q 'module)))
         ((tuple module1 _) (case  module
                              ((119 101 98 95 . es) (: wf_utils path_to_module module))
                              (_ (tuple 'undefined 'undefined)))))
    (get-source module)))

(defun event (_) 'ok)

