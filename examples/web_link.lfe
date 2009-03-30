(define-module web_link
  (export all))
(include-file "lfeweb/wf.lfe")

(defun path ()  '"/home/cadar/myproject/wwwroot")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"File upload test")

(defun body () (list 
		(make-upload tag 'myupload)
		(make-panel id 'imagepanel body (make-image image '"/images/empty.png"))
		(make-hr)
                (make-link url '"viewsource?module=web_link" text '"source")))

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
     (: io format '"~p uploaded~n" (list (++ (path) file-and-path)))
     (: wf update 'imagepanel (make-image image (++ (path) file-and-path))))
   'ok))




