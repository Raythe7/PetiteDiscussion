Class {
	#name : 'MinerPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'miner',
		'buttons'
	],
	#category : 'demineur',
	#package : 'demineur'
}

{ #category : 'initialization' }
MinerPresenter >> connectPresenters [
""
1 to: 10 do: [  :x |
	1 to: 10 do: [  :y |
		| btn |
		btn := buttons atPoint: (x@y).
		btn eventHandler whenMouseDownDo: [ :event |
			event isPrimaryButton ifTrue: [
				miner atX: x atY: y putState: #revealed.
				btn label: (miner cells atX: x atY: y) valeur asString.
			].
	 		event isSecondaryButton ifTrue:[
				miner atX: x atY: y putState: #marked.
				btn icon: (self iconNamed: #flag).
			].
		].
	].].
]

{ #category : 'layout' }
MinerPresenter >> defaultLayout [
	^ SpBoxLayout newVertical
		add: buttons;
		yourself.
]

{ #category : 'initialization' }
MinerPresenter >> initializePresenters [

	miner := Miner new.
	miner generateBomb.
	buttons := SpGridLayout new.

	1 to: 10 do: [ :x |
			1 to: 10 do: [ :y |
					| btn |
					btn := self newButton label: ''.
					btn propertyAt: #x put: x.
					btn propertyAt: #y put: y.
					buttons add: btn atPoint: x @ y ] ]
]

{ #category : 'initialization' }
MinerPresenter >> initializeWindow: aWindowPresenter [
    super initializeWindow: aWindowPresenter.
	aWindowPresenter 
        title: 'Mon Démineur';
        initialExtent: 800 @ 600;
        centered.
]
