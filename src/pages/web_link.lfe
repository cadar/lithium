(define-module web_link
  (export all))
(include-file "lfeweb/wf.lfe")

(defun path ()  '"/home/cadar/myproject/")

(defun main () (make-template file '"./wwwroot/template.html"))

(defun title () '"File upload test")

(defun body () (list 
                (make-upload tag 'myupload)
                (make-panel id 'image-panel body (make-image image '"/images/empty.png"))
                (make-hr)
                (make-link url '"viewsource?module=web_link" text '"source")))

(defun event (_) 
  'ok)

(defun upload_event 
  (('myupload 'undefined _)  (: wf flash '"File missing.")
   'ok)
  (('myupload file-name local-file-data) 
   (let* ((dest (++ '"/wwwroot/images/" file-name))
          (image-link (++ '"/images/" file-name)))
     (: file copy 
       (++ (path) local-file-data) 
       (++ (path) dest))
     (: wf update 'image-panel (make-image image image-link)))
   'ok))
