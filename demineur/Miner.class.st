"
Class: Miner

Permet de jouer le démineur
"
Class {
	#name : 'Miner',
	#superclass : 'Object',
	#instVars : [
		'loosing',
		'numberOfBombs',
		'numberOfSelectedBombs',
		'cells'
	],
	#category : 'demineur',
	#package : 'demineur'
}

{ #category : 'accessing' }
Miner >> atRandom [
	| res tempx tempy |
	res := Point new.
	tempx := 10 atRandom.
	tempy := 10 atRandom.
	res setX: tempx setY: tempy.
	^ res
	
	
	 
	
	
	
	
]

{ #category : 'accessing' }
Miner >> atX: x atY: y putState: aState [
    | currentCell |
    currentCell := cells atX: x atY: y.
    
    "1. CONDITION D'ARRÊT : Si déjà a aState, on stoppe immédiatement"
    currentCell etat = aState ifTrue: [ ^ self ].
    
    "2. MARQUAGE : On change l'état tout de suite"
    currentCell etat: aState.

    "3. LOGIQUE"
	 aState = #revealed ifTrue:[
    	currentCell hasBomb ifTrue: [ ^ self stoping ].
	 ].
	aState = #marked ifTrue:[
		currentCell hasBomb ifTrue: [ ^ self incrementSelectedBomb].
		].
    
    "4. PROPAGATION : Uniquement si c'est un 0"
	 aState = #revealed ifTrue:[
    	currentCell valeur = 0 ifTrue: [ 
        self updateEmptyNeighbor: (x @ y) 
    	].
	 ]
]

{ #category : 'accessing' }
Miner >> cells [
	^ cells.
]

{ #category : 'accessing' }
Miner >> generateBomb [ 
    "Place des bombes à des emplacements aléatoires de la grille et incrémente les voisins"
    | tempPoint tempCell |
    1 to: 10 do: [ :i | 
        tempPoint := self atRandom.
        tempCell := cells atX: tempPoint x atY: tempPoint y.
        tempCell generateBomb.

        "Répercuter sur les voisins"
        self updateNeighborsOf: tempPoint x at: tempPoint y.
    ]
]

{ #category : 'as yet unclassified' }
Miner >> incrementSelectedBomb [
	numberOfSelectedBombs := numberOfSelectedBombs + 1.
]

{ #category : 'initialization' }
Miner >> initialize [ 
    super initialize.
    cells := CTArray2D width: 10 height: 10.
    
   1 to: 10 do: [ :column |
       1 to: 10 do: [ :row |
           cells atColumn: column atRow: row put: Cell new.
       ]
   ].
    loosing := false.
    numberOfBombs := 0.
    numberOfSelectedBombs := 0.
]

{ #category : 'testing' }
Miner >> isInside: r at: c [
    ^ r >= 1 and: [ r <= cells height and: [ c >= 1 and: [ c <= cells width ] ] ]
]

{ #category : 'accessing' }
Miner >> loosing [
    ^ loosing.
]

{ #category : 'printing' }
Miner >> printOn: aStream [
    | values |
    "super printOn: aStream."
    
    1 to: 10 do: [ :column |
       1 to: 10 do: [ :row |
              values := cells atX: column atY: row .
           values printOn: aStream .
       ].
        aStream cr.
   ].
]

{ #category : 'accessing' }
Miner >> stoping [
    loosing := true.
]

{ #category : 'as yet unclassified' }
Miner >> updateEmptyNeighbor: aPoint [
    | x y |
    x := aPoint x.
    y := aPoint y.

    "Voisin Haut"
    (self isInside: y - 1 at: x) ifTrue: [ 
        self atX: x atY: y - 1 putState:#revealed ].

    "Voisin Bas"
    (self isInside: y + 1 at: x) ifTrue: [ 
        self atX: x atY: y + 1 putState:#revealed ].

    "Voisin Gauche"
    (self isInside: y at: x - 1) ifTrue: [ 
        self atX: x - 1 atY: y putState: #revealed  ].

    "Voisin Droite"
    (self isInside: y at: x + 1) ifTrue: [ 
        self atX: x + 1 atY: y putState: #revealed  ].

	(self isInside: y+1 at: x + 1) ifTrue: [ 
        self atX: x + 1 atY: y+1 putState: #revealed  ].

	(self isInside: y-1 at: x + 1) ifTrue: [ 
        self atX: x + 1 atY: y-1 putState: #revealed  ].

	(self isInside: y-1 at: x-1) ifTrue: [ 
        self atX: x-1 atY: y-1 putState: #revealed  ].

	(self isInside: y+1 at:x-1) ifTrue: [ 
        self atX: x-1 atY: y+1 putState: #revealed  ].
]

{ #category : 'as yet unclassified' }
Miner >> updateNeighborsOf: row at: col [
    "Parcourt les 8 cases autour de (row, col) de manière optimisée"
    row - 1 to: row + 1 do: [ :r |
        col - 1 to: col + 1 do: [ :c |
            "Vérifier les limites de la grille et exclure la case centrale (la bombe)"
            ((self isInside: r at: c) and: [ (r = row and: [ c = col ]) not ]) ifTrue: [ 
                (cells atX: r atY: c) increment 
            ]
        ]
    ]
]

{ #category : 'accessing' }
Miner >> winning [
    ^ numberOfBombs = numberOfSelectedBombs.

]
