(define (fact n)
  (letrec ((! (lambda (n s)
				(cond
				 ((= n 1) s)
				 (else (! (sub1 n) (* n s)))))))
	(! n 1)))

(define (sum-of-digits n)
  (cond
   ((= n 0) 0)
   (else (receive (q m) (quotient&modulo n 10)
		   (+ m (sum-of-digits q))))))
