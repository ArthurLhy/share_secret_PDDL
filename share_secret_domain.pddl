(define (domain secrets)
   (:requirements :adl)

   (:types agent secret)

   (:predicates
        (know ?agent - agent ?secret - secret)
        (connected ?x ?y - agent)
        (deceiver ?a - agent)
        (has_belief ?a - agent ?s - secret)
        (has_true_belief ?a - agent ?s - secret)
   )
   
   (:action tell
          :parameters (?teller ?reciver - agent ?s - secret)
          :precondition 
          (and
            (know ?teller ?s)
            (connected ?teller ?reciver)
          )
          :effect (know ?reciver ?s)
   )

   (:action share_belief
          :parameters (?teller ?reciver - agent ?s - secret)
          :precondition 
          (and
            (connected ?teller ?reciver)
            (has_belief ?teller ?s)
          )
          :effect 
          (and
            (has_belief ?reciver ?s) 
            (when (and (deceiver ?teller) (has_true_belief ?teller ?s)) 
                  (not (has_true_belief ?reciver ?s))   
            )
            (when (and (deceiver ?teller) (not (has_true_belief ?teller ?s))) 
                  (has_true_belief ?reciver ?s)   
            )
            (when (and (not (deceiver ?teller)) (has_true_belief ?teller ?s)) 
                  (has_true_belief ?reciver ?s)  
            )
            (when (and (not (deceiver ?teller)) (not (has_true_belief ?teller ?s))) 
                  (not (has_true_belief ?reciver ?s))
            )
          )
   )
   
)
