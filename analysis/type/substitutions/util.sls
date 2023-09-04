(library (scheme-langserver analysis type substitutions util)
  (export 
    construct-lambdas-with
    construct-parameter-variable-products-with
    construct-substitutions-between-index-nodes
    substitution-compare
    add-to-substitutions)
  (import 
    (chezscheme)
    (scheme-langserver util dedupe)
    (scheme-langserver util cartesian-product)
    (scheme-langserver util natural-order-compare)
    (scheme-langserver analysis identifier reference)
    (scheme-langserver analysis type domain-specific-language variable)
    (scheme-langserver virtual-file-system index-node))

(define (construct-substitutions-between-index-nodes substitutions left-index-node right-index-node symbol)
  (cartesian-product `(,(index-node-variable left-index-node)) `(,symbol) `(,(index-node-variable right-index-node))))

(define (construct-parameter-variable-products-with parameter-index-nodes)
  (apply cartesian-product (map list (map index-node-variable parameter-index-nodes))))

(define (construct-lambdas-with return-variables parameter-variable-products)
  (cartesian-product return-variables '(<-) parameter-variable-products))

(define (substitution-compare item0 item1)
  (natural-order-compare 
    (variable->uuid->string (car item0))
    (variable->uuid->string (car item1))))

(define add-to-substitutions 
  (case-lambda 
    [(target) (list target)]
    [(substitutions target)
      (if (null? target)
        substitutions
        (dedupe (merge substitution-compare substitutions (list target))))]))
)