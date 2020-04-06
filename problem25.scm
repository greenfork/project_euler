(define (number-of-digits n)
  (define (NOF n number)
    (cond
     ((zero? n) number)
     (else (NOF (quotient n 10) (add1 number)))))
  (NOF n 0))

(define (fib-with-1000-digits)
  (let loop ((i 1) (a 1) (b 0))
    (if (= (number-of-digits a) 1000)
        i
        (loop (add1 i) (+ a b) a))))

(print (fib-with-1000-digits))
