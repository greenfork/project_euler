;; 1 Jan 1900 was a Monday.
;; Thirty days has September,
;; April, June and November.
;; All the rest have thirty-one,
;; Saving February alone,
;; Which has twenty-eight, rain or shine.
;; And on leap years, twenty-nine.
;; A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

;; How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

(define (leap? year)
  (let ((r4 (remainder year 4))
		(r100 (remainder year 100))
		(r400 (remainder year 400)))
	(and (zero? r4) (or (not (zero? r100)) (zero? r400)))))

(define (month-days year)
  (list 31 (if (leap? year) 29 28) 31 30 31 30
		31 31 30 31 30 31))
(assert (= (apply + (month-days 2000)) 366))
(assert (= (apply + (month-days 2001)) 365))
(assert (= (apply + (month-days 1900)) 365))
(assert (= (apply + (month-days 1904)) 366))

(define (sunday? day)
  (= 0 (remainder day 7)))

(define (check-year year day)
  (let ((days (month-days year)))
	(letrec ((CY (lambda (day days sundays)
				   (cond
					((null? days) (values day sundays))
					(else (CY (+ day (car days))
							  (cdr days)
							  (if (sunday? day) (add1 sundays) sundays)))))))
	  (CY day days 0))))

(define (main end-year)
  (let loop ((y 1900) (day 1) (sundays 0))
	(receive (day1900 sundays1900) (check-year 1900 1)
		(if (<= y end-year)
			(receive (d s) (check-year y day)
			  (print y ": " day " " s)
			  (loop (add1 y) d (+ sundays s)))
			(- sundays sundays1900)))))
