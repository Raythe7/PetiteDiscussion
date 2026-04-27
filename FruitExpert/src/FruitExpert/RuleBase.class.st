Class {
	#name : 'RuleBase',
	#superclass : 'Object',
	#instVars : [
		'rules'
	],
	#category : 'FruitExpert-ExpertSystem',
	#package : 'FruitExpert',
	#tag : 'ExpertSystem'
}

{ #category : 'examples' }
RuleBase class >> example [
    ^ self new
    	add: (Rule newWithCondition: [ :fb | (fb at: 'inactif') = false ] andAction: [ :fb |
		fb at: 'inactif' put: (SpConfirmDialog new label: 'Suis-je à la retraite ?' ; openModal)
		]) ;
    	add: (Rule newWithCondition: [ :fb | (fb at: 'femme') isNil ] andAction: [ :fb |
		fb at: 'femme' put: (SpConfirmDialog new label: 'Suis-je une femme ?' ; openModal)
		]) ;
    	add: (Rule newWithCondition: [ :fb | (fb at: 'inactif') isNil ] andAction: [ :fb |
		fb at: 'inactif' put: (SpConfirmDialog new label: 'Suis-je à l''école ?' ; openModal)
		]) ;
    	yourself

]

{ #category : 'accessing' }
RuleBase class >> experience [
    ^ self new
    	add: (Rule newWithCondition: [ :fb | (fb at: 'rouge') isNil ]
						andAction: 'rouge'
						andQuestion: 'It''s ok ?'
						andValue: 5) ;
						
		add: (Rule newWithCondition: [ :fb | (fb at: 'pepin') isNil ]
						andAction: 'pepin'
						andQuestion:'Voit-on les pépins?'
						andValue: 7) ;

    	yourself

]

{ #category : 'as yet unclassified' }
RuleBase class >> fruitExpert [ 
    ^ self new
        add: (Rule newWithCondition: [ :fb | (fb at: 'Acidulee') isNil ]
                        andAction: 'Acidulee'
                        andQuestion: 'Est-ce que la pomme est acidulee ?'
                        andValue: 3) ;

        add: (Rule newWithCondition: [ :fb | (fb at: 'Sucree') isNil ]
                        andAction: 'Sucree'
                        andQuestion:'Est-ce que la pomme est Sucree ?'
                        andValue: 3) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Tres sucree') isNil ]
                        andAction: 'Tres sucree'
                        andQuestion:'Est-ce que la pomme est tres sucree ?'
                        andValue: 7) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Croquante') isNil ]
                        andAction: 'Croquante'
                        andQuestion:'Est-ce que la pomme est croquante ?'
                        andValue: 5) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Juteuse') isNil ]
                        andAction: 'Juteuse'
                        andQuestion:'Est-ce que la pomme est juteuse ?'
                        andValue: 5) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Petite') isNil ]
                        andAction: 'Petite'
                        andQuestion:'Est-ce que la pomme est petite ?'
                        andValue: 10) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Moyenne') isNil ]
                        andAction: 'Moyenne'
                        andQuestion:'Est-ce que la pomme est moyenne ?'
                        andValue: 3) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Grosse') isNil ]
                        andAction: 'Grosse'
                        andQuestion:'Est-ce que la pomme est grosse ?'
                        andValue: 5) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Rouge') isNil ]
                        andAction: 'Rouge'
                        andQuestion:'Est-ce que la pomme est rouge ?'
                        andValue: 3) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Jaune') isNil ]
                        andAction: 'Jaune'
                        andQuestion:'Est-ce que la pomme est jaune ?'
                        andValue: 5) ;

		add: (Rule newWithCondition: [ :fb | (fb at: 'Verte') isNil ]
                        andAction: 'Verte'
                        andQuestion:'Est-ce que la pomme est verte ?'
                        andValue: 10) ;

        yourself

]

{ #category : 'adding' }
RuleBase >> add: aRule [
	rules add: aRule.
]

{ #category : 'accessing' }
RuleBase >> firstEnable [
	| x res|
	x:= 1.
	res := nil.
	[ 
		x < (rules size) and:res isNil
	]
	whileTrue: [
		(rules at:x) enable ifTrue:[
			res := rules at:x.
			].
		x := x + 1.
	].
	^ res.
]

{ #category : 'initialization' }
RuleBase >> initialize [
	super initialize.
	rules := OrderedCollection new
]

{ #category : 'as yet unclassified' }
RuleBase >> moreWeightRule [
	| ruleRes r ruleTemp|
	r := self rules.
	ruleRes := self firstEnable.
	1 to: r size do:[ :x | 
		ruleTemp := r at:x.
		ruleTemp enable ifTrue:[
			ruleRes := ruleRes max: ruleTemp .
			].
		].
	^ ruleRes.
	
	
]

{ #category : 'initialization' }
RuleBase >> reset [
	rules do:[ :rule | rule enable:true ]
]

{ #category : 'accessing' }
RuleBase >> rules [
	^ rules.
]

{ #category : 'accessing' }
RuleBase >> rules: anOrderedCollectionOfRules [
	rules := anOrderedCollectionOfRules.
]

{ #category : 'enumerating' }
RuleBase >> select: aFactBase [
	^ rules select: [ :each | each enable & (each condition value: aFactBase)].
]
