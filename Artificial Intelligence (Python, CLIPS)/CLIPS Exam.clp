;; Templates για θέσεις παρκινγΚ
(deftemplate parking
    (slot space)
    (slot state)
)

;; Templates για αυτοκίνητα
(deftemplate vehicle
    (slot car)
    (slot type_of_vehicle)
)

;; Δήλωση γεγονότων, 4 θέσεις πάρκινγκ κενές
 (deffacts parking
    (parking (space 1) (state free))
    (parking (space 2) (state free))
    (parking (space 3) (state free))
    (parking (space 4) (state free))
 )

;; Δήλωση αυτοκινήτων, car_disabled για αυτοκίνητα αναπήρων
;; car για υπόλοιπα.
 (deffacts vehicles
    (vehicle (car 1) (type_of_vehicle car_disabled))
    (vehicle (car 2) (type_of_vehicle car))
    (vehicle (car 3) (type_of_vehicle car))
    (vehicle (car 4) (type_of_vehicle car))
 )

;; Κανόνας που παρκάρει ένα αναπηρικό αυτοκίνητο.
;; Μπορεί να παρκαριστεί μόνο στις θέσεις 1 ή 3 (μόνο όταν είναι κενή), 
;; και καλύπτει και την δεξια(+1) θέση του.
(defrule park_disabled_vehicle
    (declare (salience 10))
    ?p1 <- (parking (space ?p1S) (state free))
    ?p2 <- (parking (space ?p2S) (state free))
    ?veh <- (vehicle (type_of_vehicle car_disabled))
    (test (eq ?p1S (- ?p2S 1)))
    (test (neq ?p1S 2))
=>
    (modify ?p1 (state car_disabled))
    (modify ?p2 (state car_disabled))
    (retract ?veh)
 )

;; Κανόνας που παρκάρει ένα αυτοκίνητο.
;; Μπορεί να παρκαριστεί σε όποια θέση είναι κενή.
(defrule park_vehicle
    (declare (salience 5))
    ?p <- (parking (space ?pS) (state free))
    ?veh <- (vehicle (type_of_vehicle car))
=>
    (modify ?p (state car))
    (retract ?veh)
 )

;; Κανόνας goal, πυροδοτείται όταν όλοι οι χώροι πάρκινγκ είναι γεμάτοι.
 (defrule goal
    (declare (salience 20))
    (not (parking (state free)))
=>
    (printout t "All parking spaces are full." crlf)
    (halt)
 )



;; 2. Αποτελέσματα εξαντλητικών ελέγχων
;; 
;; 
;; 2 αναπηρικά αυτοκίνητα :
;; 
;; CLIPS> (reset)
;; <== f-0 (initial-fact)
;; ==> f-0 (initial-fact)
;; ==> f-1 (parking (space 1) (state free))
;; ==> f-2 (parking (space 2) (state free))
;; ==> f-3 (parking (space 3) (state free))
;; ==> f-4 (parking (space 4) (state free))
;; ==> f-5 (vehicle (car 1) (type_of_vehicle car_disabled))
;; ==> f-6 (vehicle (car 5) (type_of_vehicle car_disabled))
;; CLIPS> (run)
;; FIRE 1 park_disabled_vehicle: f-3,f-4,f-5
;; <== f-3 (parking (space 3) (state free))
;; ==> f-7 (parking (space 3) (state car_disabled))
;; <== f-4 (parking (space 4) (state free))
;; ==> f-8 (parking (space 4) (state car_disabled))
;; <== f-5 (vehicle (car 1) (type_of_vehicle car_disabled))
;; FIRE 2 park_disabled_vehicle: f-1,f-2,f-6
;; <== f-1 (parking (space 1) (state free))
;; ==> f-9 (parking (space 1) (state car_disabled))
;; <== f-2 (parking (space 2) (state free))
;; ==> f-10 (parking (space 2) (state car_disabled))
;; <== f-6 (vehicle (car 5) (type_of_vehicle car_disabled))
;; FIRE 3 goal: *
;; All parking spaces are full.
;; 
;; 
;; 1 αναπηρικό και 2 κανονικά :
;; 
;; CLIPS> (reset)
;; <== f-0 (initial-fact)
;; ==> f-0 (initial-fact)
;; ==> f-1 (parking (space 1) (state free))
;; ==> f-2 (parking (space 2) (state free))
;; ==> f-3 (parking (space 3) (state free))
;; ==> f-4 (parking (space 4) (state free))
;; ==> f-5 (vehicle (car 1) (type_of_vehicle car_disabled))
;; ==> f-6 (vehicle (car 2) (type_of_vehicle car))
;; ==> f-7 (vehicle (car 3) (type_of_vehicle car))
;; CLIPS> (run)
;; FIRE 1 park_disabled_vehicle: f-1,f-2,f-5
;; <== f-1 (parking (space 1) (state free))
;; ==> f-8 (parking (space 1) (state car_disabled))
;; <== f-2 (parking (space 2) (state free))
;; ==> f-9 (parking (space 2) (state car_disabled))
;; <== f-5 (vehicle (car 1) (type_of_vehicle car_disabled))
;; FIRE 2 park_vehicle: f-4,f-7
;; <== f-4 (parking (space 4) (state free))
;; ==> f-10 (parking (space 4) (state car))
;; <== f-7 (vehicle (car 3) (type_of_vehicle car))
;; FIRE 3 park_vehicle: f-3,f-6
;; <== f-3 (parking (space 3) (state free))
;; ==> f-11 (parking (space 3) (state car))
;; <== f-6 (vehicle (car 2) (type_of_vehicle car))
;; FIRE 4 goal: *
;; All parking spaces are full.
;; 
;; 
;; 4 κανονικά αυτοκίνητα :
;; CLIPS> (reset)
;; <== f-0 (initial-fact)
;; ==> f-0 (initial-fact)
;; ==> f-1 (parking (space 1) (state free))
;; ==> f-2 (parking (space 2) (state free))
;; ==> f-3 (parking (space 3) (state free))
;; ==> f-4 (parking (space 4) (state free))
;; ==> f-5 (vehicle (car 2) (type_of_vehicle car))
;; ==> f-6 (vehicle (car 3) (type_of_vehicle car))
;; ==> f-7 (vehicle (car 4) (type_of_vehicle car))
;; ==> f-8 (vehicle (car 10) (type_of_vehicle car))
;; CLIPS> (run)
;; FIRE 1 park_vehicle: f-4,f-6
;; <== f-4 (parking (space 4) (state free))
;; ==> f-9 (parking (space 4) (state car))
;; <== f-6 (vehicle (car 3) (type_of_vehicle car))
;; FIRE 2 park_vehicle: f-2,f-8
;; <== f-2 (parking (space 2) (state free))
;; ==> f-10 (parking (space 2) (state car))
;; <== f-8 (vehicle (car 10) (type_of_vehicle car))
;; FIRE 3 park_vehicle: f-3,f-7
;; <== f-3 (parking (space 3) (state free))
;; ==> f-11 (parking (space 3) (state car))
;; <== f-7 (vehicle (car 4) (type_of_vehicle car))
;; FIRE 4 park_vehicle: f-1,f-5
;; <== f-1 (parking (space 1) (state free))
;; ==> f-12 (parking (space 1) (state car))
;; <== f-5 (vehicle (car 2) (type_of_vehicle car))
;; FIRE 5 goal: *
;; All parking spaces are full.