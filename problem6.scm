(import srfi-1)

(define (sum-of-squares l)
  (apply + (map (lambda (x) (* x x)) l)))

(define (square-of-sum l)
  (let ((sum (apply + l)))
	(* sum sum)))

(define (solve)
  (let ((l (iota 100 1)))
   (- (square-of-sum l) (sum-of-squares l))))
