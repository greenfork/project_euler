;; 0 1 2 3 4 5  6  7  8  9
;; 1 3 5 7 9 11 13 15 17 19
;; p = 2*index + 1
;; index = (p - 1) / 2
(declare (unit eratosthenes))
(module eratosthenes (eratosthenes-list prime?)
(import scheme (chicken base))

(define (prime->index p)
  (quotient (sub1 p) 2))
(define (index->prime i)
  (add1 (* 2 i)))

;; only odd numbers are kept as indices. check for =2 should be done manually
(define (eratosthenes n)
  (receive (square reminder) (exact-integer-sqrt n)
	(let* ((length (quotient n 2))
		   (v (make-vector length 1)))
	  (vector-set! v 0 0)
	  (letrec ((E (lambda (m step)
					(cond
					 ((>= (prime->index m) length) #t)
					 (else (begin
							 (vector-set! v (prime->index m) 0)
							 (E (+ m step step) step)))))))
		(let loop ((p 3))
		  (when (<= p square)
			(when (= (vector-ref v (prime->index p)) 1)
			  (E (* p p) p))
			(loop (+ 2 p)))))
	  v)))

(define prime?
  (let ((v (eratosthenes 10000000)))
	(lambda (x) (and (> x 0) (= (vector-ref v (index->prime x)))))))

(define (sum-eratosthenes n)
  (let* ((seive (eratosthenes n))
		 (limit (vector-length seive)))
	(letrec ((S (lambda (index sum)
				  (cond
				   ((= index limit) sum)
				   (else (S (add1 index)
							(if (= 1 (vector-ref seive index))
								(+ sum (index->prime index))
								sum)))))))
	  (+ 2 (S 0 0)))))

(define (eratosthenes-list n)
  (let* ((seive (eratosthenes n))
		 (limit (vector-length seive)))
	(letrec ((S (lambda (index l)
				  (cond
				   ((= index limit) l)
				   (else (S (add1 index)
							(if (= 1 (vector-ref seive index))
								(cons (index->prime index) l)
								l)))))))
	  (cons 2 (reverse (S 0 '()))))))
)
