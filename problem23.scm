(import srfi-69 (chicken sort))

(define (sum-proper-divisors n)
  (receive (limit r) (exact-integer-sqrt n)
	(when (zero? r) (set! limit (sub1 limit)))
	(let ((step (if (odd? n) 2 1)))
	  (let loop ((k (if (odd? n) 3 2))
				 (sum (if (zero? r) (+ 2 limit) 1))) ;+ 2 because limit is set to 1 less
		(if (<= k limit)
			(if (zero? (modulo n k))
				(loop (+ k step) (+ sum k (quotient n k)))
				(loop (+ k step) sum))
			sum)))))
(assert (= (sum-proper-divisors 81) 40))
(assert (= (sum-proper-divisors 28) 28))

(define (abundant? n)
  (> (sum-proper-divisors n) n))

(define upper-limit 28123)
(define abundant-numbers (make-hash-table = number-hash 10000))
(let loop ((n 2))
  (when (< n upper-limit)
	(when (abundant? n)
	  (hash-table-set! abundant-numbers n #t))
	(loop (add1 n))))
(define sorted-numbers (sort! (hash-table-keys abundant-numbers) <))

(define (sum-of-abundant-numbers? n)
  (define limit (quotient n 2))
  (call/cc
   (lambda (k)
	 (let loop ((addends sorted-numbers))
	   (if (<= (car addends) limit)
		   (begin
			 (when (hash-table-exists? abundant-numbers (- n (car addends)))
			   (k #t))
			 (loop (cdr addends)))
		   #f)))))
(assert (eq? (sum-of-abundant-numbers? 24) #t))
(assert (eq? (sum-of-abundant-numbers? 404) #t))

(define (main)
  (let loop ((n 1) (sum 0))
	(if (< n upper-limit)
		(loop (add1 n) (if (sum-of-abundant-numbers? n) sum (+ sum n)))
		(print sum `))))

