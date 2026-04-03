"
Class : Cell

Permet de représenter une cellule
"
Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'bombe',
		'etat',
		'valeur'
	],
	#category : 'demineur',
	#package : 'demineur'
}

{ #category : 'requirements' }
Cell >> empty [
	^ bombe not and: [  valeur = 0 ]
]

{ #category : 'accessing' }
Cell >> etat [ 
	^ etat.
]

{ #category : 'accessing' }
Cell >> etat: aState [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	etat := aState 
]

{ #category : 'accessing' }
Cell >> generateBomb [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	^bombe:= true.
]

{ #category : 'accessing' }
Cell >> hasBomb [
	^ bombe.
]

{ #category : 'accessing' }
Cell >> increment [
	valeur := valeur + 1.
]

{ #category : 'initialization' }
Cell >> initialize [ 
	super initialize.
	
	bombe := false.
	valeur := 0.
	etat := #hidden.
]

{ #category : 'printing' }
Cell >> printOn: aStream [
    (etat = #hidden) ifTrue: [ 
        aStream nextPutAll: '[  ]'. 
        ^ self ].

	(etat = #marked) ifTrue: [ 
        aStream nextPutAll: '[ ; ]'. 
        ^ self ].


    bombe ifTrue: [ 
        aStream nextPutAll: '[ X ]' 
    ] ifFalse: [ 
        aStream 
            nextPutAll: '[';
            print: valeur;  " <--- Utilise print: au lieu de printString "
            nextPutAll: ']' 
    ]
]

{ #category : 'accessing' }
Cell >> valeur [
	^ valeur.
]
