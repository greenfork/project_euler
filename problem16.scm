(define (^ x a)
  (cond
   ((zero? a) 1)
   (else (* x (^ x (sub1 a))))))

(define (char->number ch)
  (- (char->integer ch) 48))

(define (sum-of-numbers n)
  (let* ((str (number->string n))
		 (len (string-length str)))
	(letrec ((SON (lambda (i sum)
					(cond
					 ((= i len) sum)
					 (else (SON (add1 i)
								(+ sum
								   (char->number (string-ref str i)))))))))
	  (SON 0 0))))
