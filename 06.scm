(use srfi-1)
(use util.match)

(define dic '(
              ;第5課
;              ("AN"     "a:n"      pron (あ そ))
;              ("IN"     "i:n"      pron (こ))
              ("AN"     "a:n"      pron (あれ それ))
              ("IN"     "i:n"      pron (これ))

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

              ;第6課
              ("AYA"     "a:ya:"    AYA   (？))
              ("?"       "?"        ?     (？))

              ("BLH"     "bale"     yn    (はい))
              ("NH KhYR" "na kheir" yn    (いいえ))
              ("NKhYR"   "nakheir"  yn    (いいえ))

              ("NYST"    "ni:st"    be    (ではありません))

              ("ChH"     "che"      qu    (何))
              ("KY"      "ki:"      qu    (誰))
              ("KJA"     "koja:"    qu    (どこ))

;              ("ChYST"   "chi:st"   x     (何ですか))
              ("ChYST"   "chi:st"   S     ("ChH" "@ST"))
;              ("KYST"    "ki:st"    x     (誰ですか))
              ("KYST"    "ki:st"    S     ("KY" "@ST"))
;              ("KJAST"   "koja:st"  x     (どこですか))
              ("KJAST"   "koja:st"  S     ("KJA" "@ST"))

              ("INJA"    "i:nja:"   pron  (ここ))
              ("U"       "u:"       pron  (彼 彼女))

              ("JA"      "ja:"      n     (場所))
              ("TVT"     "tu:t"     n     (桑の実))
              ("HSYN"    "hosein"   n     (ホセイン {人名,男}))
              ("IRAN"    "i:ra:n"   n     (イラン))
              ("QLM"     "ghalam"   n     (ペン))
              ("MYRz"    "mi:z"     n     (机))
              (".SNDLY"  "sandali:" n     (いす))
              ("RzhAPN"  "zha:pon"  n     (日本))
              ))

(define (string-rtrim-n str n)
  (let1 len (string-length str)
	(if (< len n) str (substring str 0 (- len n)))))

(define (lookup-words dic words)
  ;; 辞書{dic}からの単純なルックアップ
  (define (lookup word)
    (let1 it (assoc word dic)
      (if it (cddr it) #f) ; (list '? (string-append "%(" word ")%")))))
	  ))
;  (Map lookup words))
  (let loop ([rest words]
             [result '()])

    (define (not-found word)
      (loop (cdr rest) (cons (list '? (string-append "%(" word ")%")) result)))

    (if (null? rest) (reverse! result)
        (let* ([head (car rest)]
               [trans (lookup head)])
          (cond [(not trans) ; not found
                 (if (#/ST$/ head)
                     (let1 tmp (lookup (string-rtrim-n head 2))
                       (if tmp
                           (loop (cdr rest) (cons (lookup "@ST") (cons tmp result)))
                           (not-found head) ))
                     (not-found head) )]
                [(eq? 'S (car trans))
                 (loop (cdr rest) (append (reverse! (map lookup (cadr trans))) result))]
                [else
                 (loop (cdr rest) (cons trans result))]
                )
          ))))

(define (symbol-append . symbols)
  (string->symbol (string-join (map symbol->string symbols) "")))

(define (nom->gen nom)
  (case nom
    ((あれ) 'あの)
    ((これ) 'この)
    ((それ) 'その)
    ((どれ) 'どの)
    (else (symbol-append nom 'の))
    ))

(define (faTL->ja text)
  (let* ([words (string-split text " ")]
         [trans (lookup-words dic words)])
    (let ([pos (map car trans)]  ; (pron n be)
          [ja (map caadr trans)]) ; (こ 本 です)
      (match pos
        ;; lesson 5
;        [('pron 'n 'be) (format "~aれは~aです。" (first ja) (second ja))] ;こ-れ(は)
;        [('pron 'n 'adj 'be) (format "~aの~aは~a。" (first ja) (second ja) (third ja))] ;こ-の
        [('pron 'n 'be) (format "~aは~aです。" (first ja) (second ja))] ;これ(は)
        [('pron 'n 'adj 'be) (format "~a~aは~a。" (nom->gen (first ja)) (second ja) (third ja))] ;この
        ;; lesson 6
        [('AYA 'pron 'n 'be '?) (format "~aは~aですか？" (second ja) (third ja))] ;これ(は)
        [('pron 'n 'be '?) (format "~aは~aですか？" (first ja) (second ja))] ;これ(は)
        [('yn 'pron 'n 'be) (format "~a、~aは~a~a。"
                                    (first ja) (second ja) (third ja) (fourth ja))] ;
        [('pron 'qu 'be '?) (format "~aは~aですか？" (first ja) (second ja))] ;これ(は)

        [else ja]) )))

;;
;; TEST
;;
(use gauche.test)
(test-start "第６課")
(require "./lesson5-test")
(require "./lesson6-test")
(test-end)

