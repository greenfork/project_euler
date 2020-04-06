(module print-array *
(import scheme (chicken base) srfi-25)

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
)
