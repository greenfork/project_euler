(import srfi-1 (chicken sort) (chicken time))

(define (lp l nth)
  (define continue)
  (define i 1)
  (define mezi-result)
  (define (lp-h l rest k)
	(cond
	 ((null? rest) (call/cc
					(lambda (q)
					  (set! continue q)
					  (k (reverse l)))))
	 (else (let loop ((c (car rest)) (r (cdr rest)))
			 (lp-h (cons c l) (delete c rest) k)
			 (when (not (null? r))
			   (loop (car r) (cdr r)))))))
  (cond
   ((null? l) '())
   (else
	(call/cc
	 (lambda (return)
	   (set! mezi-result
		 (call/cc
		  (lambda (k)
			(lp-h '() (sort l <) k))))
	   (when (= i nth)
		 (return mezi-result))
	   (set! i (add1 i))
	   (continue 'please))))))

;; (time (lp '(0 1 2 3 4 5 6 7 8 9) 1000000))
