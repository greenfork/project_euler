(import srfi-13 (chicken sort))

(define names
  (call-with-input-file "problem22.txt"
	(lambda (port)
	  (let loop ((tk (read port)) (l '()))
		(if (not (eof-object? tk))
			(begin
			  (read-char port)			;cut comma
			  (loop (read port) (cons tk l)))
			l)))))

(define sorted-names (sort! names string<))

(define alphabet-values
  (let loop ((i 1) (alph (string->list "ABCDEFGHIJKLMNOPQRSTUVWXYZ")) (dict '()))
	(if (null? alph)
		dict
		(loop (add1 i) (cdr alph) (cons (list (car alph) i) dict)))))

(define (ch->val ch)
  (car (cdr (assq ch alphabet-values))))
(assert (= (ch->val #\I) 9))

(define (string-value s)
  (let loop ((l (string->list s)) (sum 0))
	(if (null? l) sum (loop (cdr l) (+ sum (ch->val (car l)))))))
(assert (= (string-value "COLIN") 53))

(define (main)
  (let loop ((i 1) (names sorted-names) (sum 0))
	(if (null? names)
		sum
		(loop (add1 i) (cdr names) (+ sum (* i (string-value (car names))))))))
