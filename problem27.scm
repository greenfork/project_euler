;; n^2 + an + b, |a| < 1000, |b| <= 1000, should produce primes for n=0 and onward

(declare (uses eratosthenes))
(import eratosthenes)

(define (construct-formulae a b)
  (lambda (n) (+ (* n n) (* a n) b)))

(define (max-non-prime)
  (let ((maxa 0) (maxb 0) (maxn 0))
	(let loopA ((a -999))
	  (when (< a 1000)
		(let loopB ((b 0))
		  (when (<= b 1000)
			(let ((formulae (construct-formulae a b)))
			  (let loopN ((n 0))
				(if (prime? (formulae n))
					(loopN (add1 n))
					(when (> n maxn)
					  (set! maxa a)
					  (set! maxb b)
					  (set! maxn n)))))
			(loopB (add1 b))))
		(loopA (add1 a))))
	(print "a: " a " b: " b " n: " n)))

;; (max-non-prime)
