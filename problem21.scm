(import srfi-69)

(define d (make-hash-table = number-hash 10000))

;; does not account for perfect squares
(define (sum-of-divisors n)
  (let ((sum 1))
	(receive (s r) (exact-integer-sqrt n)
	  (let loop ((i 2))
		(if (<= i s)
			(begin
			  (receive (q r) (quotient&remainder n i)
				(when (= r 0)
				  (set! sum (+ sum i q))))
			  (loop (add1 i)))
			sum)))))

(define (sum-of-divisors-c n)
  (if (hash-table-exists? d n)
	  (hash-table-ref d n)
	  (begin
		(let ((s (sum-of-divisors n)))
		  (hash-table-set! d n s)
		  s))))

(define (main limit)
  (let ((sum 0))
   (let loop ((n 1))
	 (if (< n limit)
		 (begin
		   (let ((sod (sum-of-divisors-c n)))
			 (when (and (not (= n sod))
						(= n (sum-of-divisors-c sod)))
			   (print n " " sod)
			   (set! sum (+ sum n))))
		   (loop (add1 n)))
		 (begin
		   (print sum)
		   sum)))))
