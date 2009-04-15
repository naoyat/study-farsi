(use util.match)

(define dic '(("AN"     "a:n"      pron (あ そ))
              ("IN"     "i:n"      pron (こ))

              ("@ST"    "ast"      be   (です))

              ("KTAB"   "keta:b"   n    (本))
              ("SG"     "sa:g"     n    (犬))
              ("MDAD"   "meda:d"   n    (鉛筆))
              ("@SB"    "asb"      n    (馬))
              ("DRKhT"  "derakht"  n    (木))
              ("KAGhDz" "ka:ghaz"  n    (紙))
              ("NAN"    "na:n"     n    (パン))
              ("AB"     "a:b"      n    (水))
              ("GL"     "gol"      n    (花))
              ("SYB"    "si:b"     n    (リンゴ))
              ("GRBH"   "gorbe"    n    (猫))

              ("BRzRG"  "bozorg"   adj  (大きい))
              ("KVChK"  "ku:chek"  adj  (小さい))
              ("SRD"    "sard"     adj  (冷たい 寒い))
              ("QShNG"  "ghashang" adj  (美しい))
              ("SFYD"   "sefi:d"   adj  (白い))
              ))

(define (lookup-words dic words)
  ;; 辞書{dic}からの単純なルックアップ
  (define (lookup word)
    (let1 it (assoc word dic)
      (if it (cddr it) (list '? (string-append "%(" word ")%")))))
  (map lookup words))

(define (faTL->ja text)
  (let* ([words (string-split text " ")]
         [trans (lookup-words dic words)])
    (let ([pos (map car trans)]  ; (pron n be)
          [ja (map caadr trans)]) ; (こ 本 です)
      (match pos
        [('pron 'n 'be) (format "~aれは~aです。" (car ja) (cadr ja))] ;こ-れ(は)
        [('pron 'n 'adj 'be) (format "~aの~aは~a。" (car ja) (cadr ja) (caddr ja))] ;こ-の
        [else ja]) )))

;;
;; TEST
;;
(use gauche.test)
(test-start "第５課")
(require "./lesson5-test")
(test-end)
