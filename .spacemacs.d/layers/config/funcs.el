(defun my-save-if-bufferfilename ()
  (if (buffer-file-name) (progn (save-buffer))
    (message "No file associated to this buffer: doing nothing")))

(defun my-mark-as-project ())