;;    3
;;   7 4
;;  2 4 6
;; 8 5 9 3

;; 3 4 6 3
;; 7 4 9
;; 2 5
;; 8

;; 3  7  13  16
;; 10 14 23
;; 12 19
;; 20

(load "print-array.scm")
(import (chicken io) srfi-25 srfi-13 print-array)

;; (define arr (make-array (shape 0 15 0 15) 0))
;; (define arr (make-array (shape 0 4 0 4) 0))
(define arr (make-array (shape 0 100 0 100) 0))


(define (fill-array arr row col vals)
  (cond
   ((null? vals) #t)
   (else (begin
		   (array-set! arr (vector row col) (string->number (car vals)))
		   (fill-array arr (sub1 row) (add1 col) (cdr vals))))))

(call-with-input-file "problem67.txt"
  (lambda (port)
	(let loop ((line (read-line port)) (i 0))
	  (when (not (eof-object? line))
		(let ((tokens (string-tokenize line)))
		  (fill-array arr i 0 tokens))
		(loop (read-line port) (add1 i))))
	#;(print-array arr)))

(define (main)
  (let ((rows (array-end arr 0))
		(cols (array-end arr 1)))
	(letrec ((fill-x
			  (lambda ()
				(let loop ((col 1))
				  (when (< col cols)
					(array-set! arr 0 col
								(+ (array-ref arr 0 col)
								   (array-ref arr 0 (sub1 col))))
					(loop (add1 col))))))
			 (fill-y
			  (lambda ()
				(let loop ((row 1))
				  (when (< row rows)
					(array-set! arr row 0
								(+ (array-ref arr row 0)
								   (array-ref arr (sub1 row) 0)))
					(loop (add1 row))))))
			 (fill-inner-array
			  (lambda (row col)
				(cond
				 ((= row 0) #t)
				 (else (begin
						 (array-set! arr (vector row col)
									 (+ (array-ref arr (vector row col))
										(max (array-ref arr (vector (sub1 row) col))
											 (array-ref arr (vector row (sub1 col))))))
						 (fill-inner-array (sub1 row) (add1 col)))))))
			 (array-diag
			  (lambda (row col)
				(cond
				 ((= row -1) '())
				 (else (cons (array-ref arr row col)
							 (array-diag (sub1 row) (add1 col))))))))
	  (fill-x)
	  (fill-y)
	  (let loop ((i 1))
		(when (< i (sub1 rows))
		  (fill-inner-array i 1)
		  (loop (add1 i))))
	  #;(print-array arr)
	  (apply max (array-diag (sub1 rows) 0)))))
