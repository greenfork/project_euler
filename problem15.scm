(import srfi-25)

(define (print-array arr)
  (let loop1 ((r (array-start arr 0)))
        (when (< r (array-end arr 0))
          (let loop2 ((c (array-start arr 1)))
                (when (< c (array-end arr 1))
                  (display (array-ref arr r c))
                  (display " ")
                  (loop2 (add1 c))))
          (newline)
          (loop1 (add1 r)))))

(define (calc dim)
  (let* ((len (add1 dim))
		 (arr (make-array (shape 0 len 0 len) 0)))
	(let loop ((l 1))
	  (when (< l len)
		(array-set! arr 0 l 1)
		(array-set! arr l 0 1)
		(loop (add1 l))))
	(let loop-row ((row 1))
	  (when (< row len)
		(let loop-col ((col 1))
		  (when (< col len)
			(array-set! arr row col
						(+ (array-ref arr (sub1 row) col)
						   (array-ref arr row (sub1 col))))
			(loop-col (add1 col))))
		(loop-row (add1 row))))
	(print-array arr)
	(array-ref arr dim dim)))