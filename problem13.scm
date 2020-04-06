(import (chicken io))

(define numbers
  (call-with-input-file "problem13.txt"
	(lambda (port) (read-lines port))))

(apply + (map string->number numbers))
