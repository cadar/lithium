(define-module web_link
  (export all))
(include-file "lfeweb/wf.lfe")

(defun path ()  '"/Users/cadar/myproject/")


(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"Here is a link to my disk, help your self.")

(defun body () (list 
		(make-upload tag 'myupload)
		(make-panel id 'imagepanel body (make-image image '"/images/empty.png"))
		(make-hr)
                (make-link url '"/web/viewsource?module=web_link" text '"source")))

(defun event (_) 
  'ok)

(defun upload_event 
  (('myupload 'undefined _)  (: wf flash '"File missing.")
   'ok)
  (('myupload file-name local-file-data) 
   (let ((file-and-path (++ '"/images/" file-name)))
     (: file copy 
       (++ (path) local-file-data) 
       (++ (path) file-and-path))
     (: wf update 'imagepanel (make-image image file-and-path)))
   'ok))




