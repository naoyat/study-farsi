;;
;; Lesson 7 - TEST
;;
;(define (faTL->ja* faTL) "＊＊＊")
;(define faTL->ja* faTL->ja)
;(define-macro (faTL->ja*-test cap faTL ja)
;  `(test* ,(string-append cap faTL) ,ja (faTL->ja* ,faTL)))

(define-macro (faTL->ja-test cap faTL ja)
  `(test* ,(string-append cap faTL) ,ja (faTL->ja ,faTL)))

(test-section "第7課:本文")
(faTL->ja-test "〔句〕" "GL-e SRKh" "赤い花")
(faTL->ja-test "〔句〕" "PDR-e U" "彼の父")
(faTL->ja-test "〔句〕" "PDR-e PIR-e U" "彼の年老いた父")
(faTL->ja-test "〔句〕" "PA-Ye @SB" "馬の足")
(faTL->ja-test "〔句〕" "MU-Ye SFID" "白い髪")
(faTL->ja-test "〔句〕" ".SNDLI-ye NU" "新しい椅子")
(faTL->ja-test "〔句〕" "BChChH-ye MN" "私の子供")
(faTL->ja-test "" "IN GL-e SRKh @ST" "これは赤い花です。")

(test-section "第7課:練習")
(faTL->ja-test "1) " "DST-e U BLND @ST" "彼の手は長い。")
(faTL->ja-test "2) " "MU-Ye SFID-e BLND-e AN MRD" "あの男の人の長い白い髪") ;白髪
(faTL->ja-test "3) " "@SM-e ShMA ChIST ?" "あなたの名前は何ですか？")
(faTL->ja-test "   " "@SM-e MN NADR @ST" "私の名前はナーデルです。")
(faTL->ja-test "4) " "AN MRD KIST ?" "あの男の人は誰ですか？")
(faTL->ja-test "   " "U PDR-e MA @ST" "彼は私たちの父です。")
(faTL->ja-test "5) " "AN MRD PDR-e U @ST" "あの男の人は彼の父です。") ;お父さん
(faTL->ja-test "6) " "AN RzN KIST ?" "あの女の人は誰ですか？")
(faTL->ja-test "   " "U MADR-e HSN @ST" "彼女はハサンの母です。") ;お母さん
(faTL->ja-test "7) " "DST-e RAST V DST-e ChP" "右手と左手")

(test-section "第7課:エザーフェの用法")
(faTL->ja-test "" "HSN-e KASB" "商人のハサン") ;Hasan the merchant
(faTL->ja-test "" "AQA-Ye RJBRzADH" "ラジャブザーデ氏") ;-さん
(faTL->ja-test "" "KhANM-e @FShAR" "アフシャール夫人") ;-さん
(faTL->ja-test "" "BNDR-e `BAS" "アッバース港")
(faTL->ja-test "" "RUD-e KARUN" "カールーン川")
(faTL->ja-test "" "KUH-e DMAUND" "ダマーヴァンド山")
(faTL->ja-test "" "ShHR-e THRAN" "テヘラン市")
