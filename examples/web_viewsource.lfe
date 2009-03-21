(define-module web_viewsource
  (export all))

(include-file "lfeweb/wf.lfe")

(defun replacements
  ((()) '())
  (((60 . t)) (cons 38 (cons 108 (cons 116 (cons 59 (replacements t))))))
  (((9 . t)) (cons 32 (cons 32 (replacements t))))
  (((h . t)) (cons h (replacements t))))

(defun get-source
  (('undefined) '"undefined")
  ((module-arg)
   (let* ((module (list_to_atom module-arg))
          (compilerinfo (call module 'module_info 'compile))
          ;; Source not used. Compilerinfo do not have right value.
          ;;(source (: proplists get_value 'source compilerinfo))  
          ((tuple 'ok b) (: file read_file 
                           (++ '"/home/cadar/myproject/lfeweb/examples/" 
                               (++ module-arg '".lfe")))))
     (list '"<pre>"
           (replacements (binary_to_list b))
           '"</pre>"))))

(defun main ()
  (let* ((module (hd (: wf q 'module)))
         ((tuple module1 _)
          (case  module
            ((119 101 98 95 . es) 
             (: wf_utils path_to_module module))
            (_ (tuple 'undefined 'undefined)))))
    (get-source module)))

(defun title () '"LFEweb")

(defun body () (make-label text '"First <h1>LFEweb</h1> page"))

(defun event (_) 'ok)

