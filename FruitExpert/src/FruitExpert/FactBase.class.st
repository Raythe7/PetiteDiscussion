Class {
	#name : 'FactBase',
	#superclass : 'Dictionary',
	#category : 'FruitExpert-ExpertSystem',
	#package : 'FruitExpert',
	#tag : 'ExpertSystem'
}

{ #category : 'examples' }
FactBase class >> example [
	^ self new
	at: 'inactif' put: nil ;
	at: 'femme' put: nil ;
	yourself
]

{ #category : 'accessing' }
FactBase class >> experience [
	^ self new
	at: 'rouge' put: nil;
	at: 'pepin' put: nil ;
	at: 'concombre' put: nil ;
	yourself
]

{ #category : 'as yet unclassified' }
FactBase class >> fruitExpert [
	^ self new
    at: 'Rouge' put: nil ;
    at: 'Jaune' put: nil ;
    at: 'Verte' put: nil ;
    at: 'Petite' put: nil;
    at: 'Moyenne' put: nil ;
    at: 'Grosse' put: nil ;
    at: 'Croquante' put: nil ;
    at: 'Juteuse' put: nil ;
    at: 'Sucree' put: nil ;
    at: 'Tres sucree' put: nil ;
    at: 'Acidulee' put: nil ;

    yourself.
]

{ #category : 'accessing' }
FactBase >> at: key [
	^ self at: key ifAbsent: [ ^ nil ]
]

{ #category : 'testing' }
FactBase >> has: key [
	^ self includesKey: key
]

{ #category : 'initialization' }
FactBase >> reset [
	self keysDo: [ :each |
		self at:each put:nil.
		 ].
]
