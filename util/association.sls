(library (scheme-langserver util association)
    (export assq-ref assoc-ref assv-ref make-alist)
    (import (rnrs) )

(define (assq-ref key alist)
    (let ((key-value-pair (assq key alist)))
        (if key-value-pair
            (if (pair? key-value-pair)
                (cdr key-value-pair)
                #f)
            #f)))

(define (assv-ref key alist)
    (let ((key-value-pair (assv key alist)))
        (if key-value-pair
            (if (pair? key-value-pair)
                (cdr key-value-pair)
                #f)
            #f)))

(define (assoc-ref key alist)
    (let ((key-value-pair (assoc key alist)))
        (if key-value-pair
            (if (pair? key-value-pair)
                (cdr key-value-pair)
                #f)
            #f)))

(define (make-alist . args)
    (let loop ([result '()] [index 0])
        (if (< index (- (length args) 2))
            (loop (append result (list (cons (list-ref args index) (list-ref args (+ 1 index))))) (+ 2 index))
            (append result (list (cons (list-ref args index) (list-ref args (+ 1 index))))))))
)