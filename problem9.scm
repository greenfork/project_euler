;; a^2 + b^2 = c^2
;; a + b + c = 1000
;; a < b < c
;; abc = ?

(define (check a b c)
  (and (= (* c c) (+ (* a a) (* b b)))
	   (= 1000 (+ a b c))
	   (< a b c)))

(define (main args)
  (call/cc
   (lambda (k)
	 (let loopc ((c 5))
	   (let loopb ((b 4))
		 (when (< b c)
		   (let loopa ((a 3))
			 (when (< a b)
			   (if (check a b c)
				   (k (* a b c))
				   (loopa (add1 a)))))
		   (loopb (add1 b))))
	   (loopc (add1 c))))))
