(import srfi-1)

(define unit-decimal-recur-length
  (let ((max-tries 1000))
	(lambda (divident divisor remainders repr tries)
	  (cond
	   ((= tries max-tries) (begin (print "can't print for " divisor) -1))
	   ((zero? divident) 0)
	   ((and (not (null? remainders))
			 (member divident (cdr remainders)))
		(let ((len (add1 (list-index (lambda (x) (= x divident)) (cdr remainders)))))
		  (when (= len 982) (print divisor " " repr " " len " " remainders))
		  len)
		)
	   (else (receive (q r) (quotient&remainder (* divident 10) divisor)
			   (unit-decimal-recur-length
				r
				divisor
				(cons r remainders)
				(string-append repr (number->string q))
				(add1 tries))))))))
;; (unit-decimal-recur-length 1 3 '() "0." 0)

(let loop ((i 2) (maxn 0))
  (if (= i 1000)
	  (print maxn)
	  (loop (add1 i) (max maxn (unit-decimal-recur-length 1 i '() "0." 0)))))
