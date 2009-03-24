;; parametrized module call 
(defmacro call-str
  ((module-string . arg-list) 
   `(let ((module (list_to_atom ,module-string)))
       (call module . ,arg-list))))
