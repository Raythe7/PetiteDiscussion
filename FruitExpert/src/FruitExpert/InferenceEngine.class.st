Class {
	#name : 'InferenceEngine',
	#superclass : 'Object',
	#instVars : [
		'factBase',
		'ruleBase',
		'end',
		'diag',
		'points'
	],
	#category : 'FruitExpert-ExpertSystem',
	#package : 'FruitExpert',
	#tag : 'ExpertSystem'
}

{ #category : 'examples' }
InferenceEngine class >> example [
	^ self new
	factBase: FactBase example;
	ruleBase: RuleBase example;
	yourself
]

{ #category : 'accessing' }
InferenceEngine class >> experience [ 
	^ self new
	factBase: FactBase experience ;
	ruleBase: RuleBase experience ;
	yourself
	
]

{ #category : 'examples' }
InferenceEngine class >> fruitExpert [
    | instance |
    instance := self new.
    instance 
        factBase: FactBase fruitExpert;
        ruleBase: RuleBase fruitExpert;

        diag: [ |res fb|
				res  := nil.
				fb := instance factBase.
				((fb at: 'Verte') == true) ifTrue: [ 
					res := 'Votre pomme est de la variété Fuji'. instance end:true ].
				
				((fb at: 'Petite') == true) ifTrue: [ 
					res := 'C''est le Gala'. instance end:true ].
				
				
				
				(((fb at: 'Rouge') == true) and:[(fb at: 'Jaune') == true]) ifTrue: [ 
					res := 'Votre pomme est de la variété Elstar'. instance end:true ].
				"On renvoie res à la toute fin"
				(res isNil) ifTrue:['Je ne sais pas de quel pomme il s''agit']
				ifFalse:[res].
				
			];
        yourself.
    ^ instance
]

{ #category : 'adding' }
InferenceEngine >> addPoints: anInteger [
	points := points+anInteger
]

{ #category : 'accessing' }
InferenceEngine >> diag [

	^ diag.
]

{ #category : 'accessing' }
InferenceEngine >> diag: anObject [

	diag := anObject
]

{ #category : 'accessing' }
InferenceEngine >> end [

	^ end
]

{ #category : 'accessing' }
InferenceEngine >> end: anObject [

	end := anObject
]

{ #category : 'accessing' }
InferenceEngine >> factBase [
	^ factBase
]

{ #category : 'accessing' }
InferenceEngine >> factBase: anObject [
factBase:= anObject.
]

{ #category : 'accessing' }
InferenceEngine >> firstEnable [
	| x res|
	x:= 1.
	res := nil.
	[ 
		x < (ruleBase rules size) and:res isNil
	]
	whileTrue: [
		(ruleBase rules at:x) enable ifTrue:[
			res := ruleBase rules at:x.
			].
		x := x + 1.
	].
	^ res.
]

{ #category : 'initialization' }
InferenceEngine >> initialize [
	super initialize.
	factBase := FactBase new.
	ruleBase := RuleBase new.
	diag := [ ].
	end := false.
	points := 0.
]

{ #category : 'testing' }
InferenceEngine >> isEnd [
	|selectedRules |
	selectedRules := ruleBase select: self factBase.
	(selectedRules) isEmpty ifTrue:[end := true].
	

	
]

{ #category : 'as yet unclassified' }
InferenceEngine >> moreWeightRule: anOrderedCollection [
	| ruleRes r ruleTemp|
	r := anOrderedCollection.
	ruleRes := self firstEnable.
	
	r size = 1 ifTrue:[
		^ ruleRes.
		].
	
	1 to: r size do:[ :x | 
		ruleTemp := r at:x.
		ruleTemp enable ifTrue:[
			ruleRes := ruleRes max: ruleTemp .
			].
		].
	^ ruleRes.
	
	
]

{ #category : 'accessing' }
InferenceEngine >> points [

	^ points
]

{ #category : 'accessing' }
InferenceEngine >> points: anObject [

	points := anObject
]

{ #category : 'as yet unclassified' }
InferenceEngine >> putOnFact: aFact aValue: aValue [
	factBase at: aFact put: aValue.
	self isEnd.
	
	
	self changed.
	
]

{ #category : 'actions' }
InferenceEngine >> reload [ 
	ruleBase reset.
	factBase reset.
	end := false.
	points := 0.
	
	self changed.
]

{ #category : 'accessing' }
InferenceEngine >> ruleBase [

	^ ruleBase
]

{ #category : 'accessing' }
InferenceEngine >> ruleBase: anObject [
ruleBase:= anObject.
]

{ #category : 'running' }
InferenceEngine >> run [
	
	| selectedRules |
	self ruleBase reset.
	[
		selectedRules := ruleBase select: self factBase.
		selectedRules isEmpty 
	] whileFalse: [ (self moreWeightRule:selectedRules) value: self factBase ].
	^ self factBase
]

{ #category : 'as yet unclassified' }
InferenceEngine >> tryAGuess [
	
	points >= 10 ifTrue:[
		points := 0.
		diag value.
		].
]
