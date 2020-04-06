(define (fib-even-sum)
  ;; every 3rd number is even
  (letrec ((F (lambda (a b c sum k)
				(cond
				 ((> c 4000000) (k sum))
				 (else (F (+ b c)
						  (+ b c c)
						  (+ b c b c c)
						  (+ sum c)
						  k))))))
	(call/cc
	 (lambda (k)
	   (F 1 1 2 0 k)))))
