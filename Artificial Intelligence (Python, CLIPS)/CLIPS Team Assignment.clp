;;; This assignment was made by a team of two 

;;; Εργασία ΕΣ στο μάθημα ΤΕΧΝΙΤΗ ΝΟΗΜΟΣΥΝΗ

;;; ΠΡΟΤΥΠΑ

;; Χώρος
;; Αποτελείται από το όνομα του,
;; το επίπεδο στο οποίο βρίσκεται
;; και την κατάσταση του(Ε για άδειο / ΝΕ για κατειλημμένο)
(deftemplate space
    (slot name)
	(slot level)
    (slot state)
)

;; Πλατφόρμα
;; Αποτελείται από το όνομα της,
;; τον χώρο στον οποίο βρίσκεται,
;; το επίπεδο στο οποίο βρίσκεται,
;; την κατάσταση της(Ε για άδεια / ΝΕ για κατειλημμένη από αυτοκίνητο)
;; και τον ΑΚ του αυτοκινήτου που βρίσκεται πάνω της (αν υπάρχει)
(deftemplate platform
    (slot name)
    (slot space)
	(slot level)
    (slot state)
	(slot AK)
)

;; Αυτοκίνητο
;; Αποτελείται από τον αριθμό κυκλοφορίας
;; και την κατάσταση που βρίσκεται (W για "περιμένει" / P για παρκαρισμένο)
(deftemplate car
	(slot AK)
	(slot state)
)

;;; ΓΕΓΟΝΟΤΑ

(deffacts spaces 
    (space (name S1) (level 1) (state NE))
    (space (name S2) (level 1) (state E))
    (space (name S3) (level 1) (state NE))
    (space (name S4) (level 1) (state NE))
	(space (name S5) (level 1) (state NE))
	(space (name S6) (level 1) (state NE))

    (space (name S1) (level 2) (state E))
    (space (name S2) (level 2) (state NE))
    (space (name S3) (level 2) (state NE))
    (space (name S4) (level 2) (state NE))
	(space (name S5) (level 2) (state NE))
	(space (name S6) (level 2) (state E))

	(space (name S1) (level 3) (state E))
    (space (name S2) (level 3) (state NE))
    (space (name S3) (level 3) (state NE))
    (space (name S4) (level 3) (state NE))
	(space (name S5) (level 3) (state NE))
	(space (name S6) (level 3) (state NE))
)

(deffacts platforms
    (platform (name P1) (space S1) (level 1) (state E) (AK 0))
    (platform (name P2) (space S3) (level 1) (state E) (AK 0))
    (platform (name P3) (space S4) (level 1) (state E) (AK 0))
	(platform (name P4) (space S5) (level 1) (state E) (AK 0))
	(platform (name P5) (space S6) (level 1) (state E) (AK 0))

    (platform (name P6) (space S2) (level 2) (state E) (AK 0))
    (platform (name P7) (space S3) (level 2) (state E) (AK 0))
    (platform (name P8) (space S4) (level 2) (state E) (AK 0))
    (platform (name P9) (space S5) (level 2) (state E) (AK 0))

	(platform (name P10) (space S2) (level 3) (state E) (AK 0))
    (platform (name P11) (space S3) (level 3) (state E) (AK 0))
    (platform (name P12) (space S4) (level 3) (state E) (AK 0))
    (platform (name P13) (space S5) (level 3) (state E) (AK 0))
	(platform (name P14) (space S6) (level 3) (state E) (AK 0))
)

(deffacts east
    (east S1 S2)
    (east S2 S3)
	(east S4 S5)
    (east S5 S6)
)

(deffacts north
	(north S1 S4)
	(north S2 S5)
	(north S3 S6)
)

;;; ΚΑΝΟΝΕΣ

;; init
;; Θέτει την στρατηγική επίλυσης
;; και προσθέτει 3 γεγονότα 
;; target:
;; Το αυτοκίνητο που ψάχνουμε για να το φέρουμε
;; στην είσοδο και να παραλιφθεί από τον ιδιοκτήτη
;; Στην αρχή του προβλήματος η τιμή είναι NA(Not available δηλαδή δεν υπάρχει)
;; is_goal:
;; Το γεγονός αυτό χρησιμοποιείται για να ελέγχουμε αν έχει
;; τελειώσει η διαδικασία εισαγωγής και στάθμευσης αυτοκινήτων
(defrule init
  (declare (salience 100))
  (initial-fact)
  =>
  (set-strategy random)
  (assert (target NA))
  (assert (is_goal F))
  (assert (car (AK 1001) (state W)))
)

;; read
;; Διαβάζει και καταχωρεί τα αυτοκίνητα
;; στην αρχή του προβλήματος 
(defrule read
	(declare (salience 99))
=>
	(printout t "Enter amount of cars(max 13, 0 for none)" crlf)
	(bind ?num(read))
	(while (or (< ?num 0) (> ?num 13))
		(printout t "Invalid amount" crlf)
		(printout t "Enter amount of cars" crlf)
		(bind ?num(read))
	)

	(while (> ?num 0)
		(printout t "Enter car number:" crlf)
		(bind ?carNum(read))
		(assert (car (AK ?carNum) (state W)))
		(bind ?num (- ?num 1))
	)
)

;; Κανόνας enter
;; Μεταφέρει τα αυτοκίνητα από την ουρά στην είσοδο
(defrule enter
	(declare (salience 15))
	?x <- (car (AK ?ak) (state W))
	?p <- (platform (name ?pN) (space S2) (level 1) (state E))
=>
	(modify ?p (state NE) (AK ?ak))
	(modify ?x (state P))
)

;; Κανόνας move_up
;; Μετακινεί μια πλατφόρμα από ένα επίπεδο στο ανώτερο(αν υπάρχει)
(defrule move_up
	(declare (salience 5))
	?x <- (space (name S5) (level ?lvl) (state NE))
    ?y <- (space (name S5) (level ?newLvl) (state E))
	?p <- (platform (space S5) (level ?lvl))
	(test (> ?newLvl ?lvl))
=>
	(modify ?x (state E))
    (modify ?y (state NE))
	(modify ?p (level ?newLvl))
) 

;; Κανόνας move_down
;; Μετακινεί μια πλατφόρμα από ένα επίπεδο στο κατώτερο(αν υπάρχει)
(defrule move_down
	(declare (salience 5))
	?x <- (space (name S5) (level ?lvl) (state NE))
    ?y <- (space (name S5) (level ?newLvl) (state E))
	?p <- (platform (space S5) (level ?lvl))
	(test (< ?newLvl ?lvl))
=>
	(modify ?x (state E))
    (modify ?y (state NE))
	(modify ?p (level ?newLvl))
) 

;; Κανόνας move_north
;; Μετακινεί μια πλατφόρμα προς τον πάνω χώρο, εφόσον αυτός είναι κενός
(defrule move_north
	(declare (salience 5))
    ?x <- (space (name ?s) (level ?lvl) (state NE))
    	(north ?s ?snew)
    ?y <- (space (name ?snew) (level ?lvl) (state E))
	?p <- (platform (space ?s) (level ?lvl))
=>
    (modify ?x (state E))
    (modify ?y (state NE))
	(modify ?p (space ?snew))
)

;; Κανόνας move_east
;; Μετακινεί μια πλατφόρμα προς τον δεξί χώρο, εφόσον αυτός είναι κενός
(defrule move_east
	(declare (salience 5))
    ?x <- (space (name ?s) (level ?lvl) (state NE))
    	(east ?s ?snew)
    ?y <- (space (name ?snew) (level ?lvl) (state E))
	?p <- (platform (space ?s) (level ?lvl))
=>
    (modify ?x (state E))
    (modify ?y (state NE))
	(modify ?p (space ?snew))
)

;; Κανόνας move_south
;; Μετακινεί μια πλατφόρμα προς τον κάτω χώρο, εφόσον αυτός είναι κενός
(defrule move_south
	(declare (salience 5))
    ?x <- (space (name ?s) (level ?lvl) (state NE))
    	(north ?snew ?s)
    ?y <- (space (name ?snew) (level ?lvl) (state E))
	?p <- (platform (space ?s) (level ?lvl))
=>
    (modify ?x (state E))
    (modify ?y (state NE))
	(modify ?p (space ?snew))
)

;; Κανόνας move_west
;; Μετακινεί μια πλατφόρμα προς τον αριστερό χώρο, εφόσον αυτός είναι κενός
(defrule move_west
	(declare (salience 5))
    ?x <- (space (name ?s) (level ?lvl) (state NE))
    	(east ?snew ?s)
    ?y <- (space (name ?snew) (level ?lvl) (state E))
	?p <- (platform (space ?s) (level ?lvl))
=>
    (modify ?x (state E))
    (modify ?y (state NE))
	(modify ?p (space ?snew))
)

;; Κανόνας read_retrieve
;; Διαβάζει το αυτοκίνητο που θέλουμε να ξεπαρκάρουμε
(defrule read_retrieve
	(declare (salience 25))
	(is_goal T)
	?t <- (target NA)
=>
	(printout t "Enter car number to unpark:" crlf)
	(bind ?num (read))
	(retract ?t)
	(assert (target ?num))
)

;; Κανόνας retrieve_car
;; Αφαιρεί το αυτοκίνητο που ψάχνουμε όταν αυτό φτάσει στην είσοδo
(defrule retrieve_car
	(declare (salience 30))
	(is_goal T)
	?t <- (target ?tak)
	?p <- (platform (space S2) (level 1) (state NE) (AK ?ak))
	(test (eq ?tak ?ak))
	?c <- (car (AK ?ak))
=>
	(printout t (implode$ (create$ Removing car ?ak .)) crlf)
	(retract ?c)
	(retract ?t)
	(assert (target NA))
	(modify ?p (state E) (AK 0))
)

;; Κανόνας end_goal
;; Στόχος τερματισμού. Τερματίζει την λειτουργία του ΕΣ όταν δεν υπάρχουν
;; άλλα αυτοκίνητα
(defrule end_goal
	(declare (salience 35))
	(not (car))
=>
	(printout t "All cars unparked." crlf)
	(halt)
)

;; Κανόνας park_goal
;; Ξεκινάει την διαδικασία ξεπαρκαρίσματος
(defrule park_goal
	(declare (salience 20))
	?g <- (is_goal F)
	(or (not (car (state W)))
		(not (platform (state E))))
=>
	(printout t "All cars parked." crlf)
	(retract ?g)
	(assert (is_goal T))
)