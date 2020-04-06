(import (chicken io) srfi-69 srfi-13 srfi-1)

(define *dict* (make-hash-table = number-hash 30))
(call-with-input-file "problem17.txt"
  (lambda (port)
	(let loop ((line (read-line port)))
	  (when (not (eof-object? line))
		(let* ((tokens (string-tokenize line))
			   (key (car tokens))
			   (value (car (cdr tokens))))
		  (hash-table-set! *dict* (string->number key) value))
		(loop (read-line port))))))

(define (number->digits n)
  (letrec ((ND (lambda (n)
				 (cond
				  ((zero? n) '())
				  (else (receive (q r) (quotient&remainder n 10)
						  (cons r (ND q))))))))
	(reverse (ND n))))
(assert (equal? (number->digits 1234560987) '(1 2 3 4 5 6 0 9 8 7)))

(define (number->words n)
  (let* ((digits (number->digits n))
		 (len (length digits)))
	(cond
	 ((= len 1) (hash-table-ref *dict* n))
	 ((and (= len 2) (= 1 (first digits))) (hash-table-ref *dict* n))
	 ((= len 2)
	  (cond
	   ((= 1 (first digits)) (hash-table-ref *dict* n))
	   ((= 0 (second digits)) (hash-table-ref *dict* (* (first digits) 10)))
	   (else
		(string-append (hash-table-ref *dict* (* (first digits) 10))
					   "-"
					   (number->words (second digits))))))
	 ((= len 3)
	  (cond
	   ((= 0 (second digits) (third digits))
		(string-append (number->words (first digits))
					   " hundred"))
	   (else
		(string-append (number->words (first digits))
					   " hundred and "
					   (number->words (+ (* (second digits) 10)
										 (third digits)))))))
	 ((= len 4) "one thousand")
	 (else #f))))
(assert (string= (number->words 5) "five"))
(assert (string= (number->words 12) "twelve"))
(assert (string= (number->words 36) "thirty-six"))
(assert (string= (number->words 528) "five hundred and twenty-eight"))
(assert (string= (number->words 1000) "one thousand"))

(define (count-characters s)
  (let ((len (string-length s)))
	(let loop ((i 0) (sum 0))
	  (if (< i len)
		  (loop (add1 i)
				(if (or (eq? (string-ref s i) #\-)
						(eq? (string-ref s i) #\space))
					sum
					(add1 sum)))
		  sum))))
(assert (= (count-characters "hey-hey how are you") 15))

(define (main)
  (count-characters
   (string-join (map number->words (iota 1000 1)))))
