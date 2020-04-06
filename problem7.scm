(import srfi-1)

(define (eratosthenes n)
  (let ((v (make-vector n 1)))
	(vector-set! v 0 0)
	(vector-set! v 1 0)
	(letrec ((E (lambda (m step)
				  (cond
				   ((>= m n) #t)
				   (else (begin
						   (vector-set! v m 0)
						   (E (+ m step) step)))))))
	  (let loop ((p 0))
		(when (< p n)
		  (when (= (vector-ref v p) 1)
			(E (* p p) p))
		  (loop (add1 p)))))
	v))

(define (nth-prime primes n)
  (call/cc
   (lambda (k)
	(let loop ((m 0) (p 0))
	  (if (= (vector-ref primes m) 1)
		  (begin
			(if (= n (add1 p))
				(k m)
				(loop (add1 m) (add1 p))))
		  (loop (add1 m) p))
	  #t))))

(define (solve)
  (let ((primes (eratosthenes 1000000)))
	(nth-prime primes 10001)))
