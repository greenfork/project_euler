(define (next-collatz n)
  (if (even? n) (quotient n 2) (add1 (* 3 n))))
(assert (= (next-collatz 13) 40))
(assert (= (next-collatz 40) 20))

(define (collatz-chain n)
  (cond
   ((= 1 n) '(1))
   (else (cons n (collatz-chain (next-collatz n))))))
(assert (equal? (collatz-chain 13) '(13 40 20 10 5 16 8 4 2 1)))

(define (count-collatz-chain n)
  (cond
   ((= 1 n) 1)
   (else (add1 (count-collatz-chain (next-collatz n))))))

(define (main args)
  (let ((maxn 0) (number 0) (limit (string->number (car args))))
	(let loop ((n 1))
	  (when (< n limit)
		(let ((cnt (count-collatz-chain n)))
		  (when (> cnt maxn)
			(set! maxn cnt)
			(set! number n)))
		;; (print (collatz-chain n))
		(loop (add1 n))))
	(print number)
	number))
