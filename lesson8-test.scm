'(
;p.38
("TU" "to" pron (お前 あなた)))
;p.39
("IShAN" "i:sha:n" pron (あの人 彼ら 彼女ら))
("ANHA" "a:nha:" pron (彼ら それら))
;p.40
("DBSTAN" "dabesta:n" n (小学校))
("KShVR" "keshvar" n (国))
("@,TAQ" "ota:q" n (部屋))
("DUST" "du:st" n (友人))
;p.41
("M.HMD" "mohammad" prop (モハンマド {人名} <male>))
("KhANH" "kha:ne" n (家))
("PSR" "pesar" n (息子 少年 <male>))
("DKhTR" "dokhtar" n (娘 少女 <female>))
("BRADR" "bara:dar" (兄 弟 <male>))
("AMURzGAR" "a:mu:zega:r" (先生))
("KhVAHR" "kha:har" n (姉 妹 <female>))
;p.42
;p.43
("VY" "vei" (彼 彼女 <文語>)))
)

(define-macro (faTL->ja-test cap faTL ja)
  `(test* ,(string-append cap faTL) ,ja (faTL->ja ,faTL)))

(test-section "第7課:本文")
(faTL->ja-test "" "U MADR-e ShMA @ST" "あの人はあなたのお母さんです")
(faTL->ja-test "" "U PDR-e TU @ST" "あの人は君のお父さんです")

(faTL->ja-test "〔句〕" "MADR-e MN" "私の母")
;"ShMARA" "あなたを"
(faTL->ja-test "〔句〕" "KTAB-e ShMA" "あなたの本") ; あなたがたの本
(faTL->ja-test "〔句〕" "PDR-e ANHA" "彼らの父")
(faTL->ja-test "〔句〕" "PDR-e IShAN" "あの方のお父さん")
(
