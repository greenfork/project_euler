(define n 600851475143)

(define (prime-factors n)
  (receive (s r) (exact-integer-sqrt n)
	(letrec ((LPF (lambda (n primes divider)
					(cond
					 ((> divider s) primes)
					 (else (receive (q r) (quotient&remainder n divider)
							 (if (= r 0)
								 (LPF q (cons divider primes) (+ divider 2))
								 (LPF n primes (+ divider 2)))))))))
	  (LPF n '() 3))))
