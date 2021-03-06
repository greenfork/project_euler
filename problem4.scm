(define (palindrome? n)
  (let* ((s (number->string n))
		 (l (string-length s)))
	(letrec ((P (lambda (s start end)
				  (cond
				   ((>= start end) #t)
				   ((eq? (string-ref s start)
						 (string-ref s end))
					(P s (add1 start) (sub1 end)))
				   (else #f)))))
	  (P s 0 (sub1 l)))))

(define (solve)
  (let ((max 0) (m1 0) (m2 0))
	(let steps ((start 900) (end 999) (step 100))
	  (when (>= start 100)
		(let mult1 ((n end))
		  (when (>= n start)
			(call/cc
			 (lambda (k)
			   (let mult2 ((m n))
				 (when (>= m start)
				   (let ((multiple (* n m)))
					 (when (and (palindrome? multiple)
								(> multiple max))
					   (set! max multiple)
					   (set! m1 n)
					   (set! m2 m)
					   (k #t)))
				   (mult2 (sub1 m))))))
			(mult1 (sub1 n))))
		(when (= max 0)
		  (steps (- start step) (- end step) step))))
	(print m1 " " m2)
	max))
