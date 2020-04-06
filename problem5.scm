(import srfi-1)

(define (prime-factors n)
  (receive (s r) (exact-integer-sqrt n)
	(letrec ((LPF (lambda (n primes divider)
					(cond
					 ((> divider s) (if (and (not (= n 1)) (null? primes))
										(cons n primes)
										primes))
					 (else (receive (q r) (quotient&remainder n divider)
							 (if (= r 0)
								 (LPF q (cons divider primes) divider)
								 (LPF n primes (+ divider 2))))))))
			 (DIV2 (lambda (n primes)
					 (receive (q r) (quotient&remainder n 2)
					   (if (= r 0)
						   (DIV2 q (cons 2 primes))
						   (values n primes))))))
	  (receive (n primes) (DIV2 n '())
		(append (LPF n '() 3) primes)))))

(define (intersect table)
  (let ((total '()))
	(letrec ((I (lambda (table)
				  (cond
				   ((null? table) #t)
				   (else (begin
						   (set! total
							 (append (add-to-total (car table) total) total))
						   (I (cdr table)))))))
			 (add-to-total
			  (lambda (l total)
				(cond
				 ((null? l) '())
				 (else (if (member (car l) total =)
						   (add-to-total (cdr l) (remove-first (car l) total))
						   (cons (car l) (add-to-total (cdr l) total)))))))
			 (remove-first
			  (lambda (x l)
				(cond
				 ((null? l) '())
				 ((= x (car l)) (cdr l))
				 (else (cons (car l) (remove-first x (cdr l))))))))
	  (I table)
	  total)))

(define (solve)
  (let ((factors (map prime-factors (iota 20 1))))
	(print factors)
	(let ((intersection (intersect factors)))
	  (apply * intersection))))
