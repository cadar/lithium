(defrecord elementbase (module 'undefined)      id actions (show_if 'true) (class '"") (style '""))
(defrecord template (module 'element_template)  id actions (show_if 'true) (class '"") (style '"") file (bindings '()))
(defrecord error (module 'element_error)        id actions (show_if 'true) (class '"") (style '"") (text '"") (html_encode 'true))
(defrecord label (module 'element_label)        id actions (show_if 'true) (class '"") (style '"") (text '"") (html_encode 'true))
(defrecord link (module 'element_link)          id  actions (show_if 'true) (class '"") (style '"") (text '"") (body '"") (html_encode 'true) (url '"javascript:") postback)

(defrecord flash (module 'element_flash)        id actions (show_if 'true) (class '"") (style '""))
(defrecord p (module 'element_p)                id actions (show_if 'true) (class '"") (style '""))
(defrecord br (module 'element_br)              id actions (show_if 'true) (class '"") (style '""))
(defrecord hr (module 'element_hr)              id actions (show_if 'true) (class '"") (style '""))
(defrecord script (module 'action_script)       id actions (show_if 'true) (class '"") (style '"") script)
(defrecord actionbase (module 'undefined) trigger target actions (show_if 'true))
(defrecord event (module 'action_event)   trigger target actions (show_if 'true) (type 'click) (delay 1) postback delegate)

