Class {
	#name : 'ExpertPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'engine',
		'factsKey',
		'factsValues',
		'allowed',
		'deny',
		'currentRule',
		'reload'
	],
	#category : 'FruitExpert-ExpertSystem',
	#package : 'FruitExpert',
	#tag : 'ExpertSystem'
}

{ #category : 'examples' }
ExpertPresenter class >> fruitExpert [
	^ self new
		engine: InferenceEngine fruitExpert;
		yourself.
]

{ #category : 'initialization' }
ExpertPresenter >> connectPresenters [
	| temp |
	allowed action:[
		temp := engine moreWeightRule: (engine ruleBase select: engine factBase).
		engine addPoints:temp weight.
		engine putOnFact:temp action aValue:true.
		engine tryAGuess.
		].
	
	deny action:[
		temp := engine moreWeightRule: (engine ruleBase select: engine factBase).
		engine addPoints:temp weight.
		engine putOnFact:temp action aValue:false.
		engine tryAGuess.
		].
	reload action:[
		engine reload.
		allowed enabled:true.
		deny enabled:true.
		]
	
]

{ #category : 'layout' }
ExpertPresenter >> defaultLayout [
	| buttonBar factList middle|
	buttonBar := SpBoxLayout newLeftToRight
		add: allowed expand:true;
		add: deny expand:true;
		spacing: 5;
		yourself.
		
	factList := SpBoxLayout newHorizontal
		add: factsKey width:100;
		add: factsValues width:100;
		yourself.
		
	middle := SpBoxLayout newVertical
		add: currentRule;
		add: buttonBar height: 35;
		add: reload height: 35;
		spacing: 5;
		yourself.
		
	^ SpBoxLayout newHorizontal
		add: factList expand:false;
		add: middle expand:true;
		yourself.
		
	
		
		
	

]

{ #category : 'initialization' }
ExpertPresenter >> initializePresenters [
	engine := InferenceEngine fruitExpert.
	factsKey :=  self newList.
	factsValues :=  self newList.
	allowed := self newButton.
	deny := self newButton.
	currentRule := self newLabel.
	engine addDependent: self.
	
	currentRule label: (engine moreWeightRule: (engine ruleBase select: engine factBase))question.
	
	factsValues items: engine factBase values asOrderedCollection.
	factsKey items: engine factBase keys asOrderedCollection.
	
	allowed label: 'Oui'.
	allowed icon:(self iconNamed: #accept).
	allowed color: (Color green alpha:0.1).
	deny label: 'Non'.
	deny icon:(self iconNamed: #cancel).
	deny color: (Color red alpha:0.1).
	
	reload := self newButton.
	reload label: 'Relancer'.
	reload color: (Color white alpha:0.1).
	reload icon:(self iconNamed: #restart).
	

]

{ #category : 'initialization' }
ExpertPresenter >> initializeWindow: aWindowPresenter [
    super initializeWindow: aWindowPresenter.
	aWindowPresenter 
        title: 'Mon système expert';
        initialExtent: 500 @ 400;
        centered.
]

{ #category : 'updating' }
ExpertPresenter >> update: aParameter [

	factsValues items: engine factBase values asOrderedCollection.
	
	currentRule label: (engine moreWeightRule: (engine ruleBase select: engine factBase))question.
	
	
	engine tryAGuess.
	engine end ifTrue:[
		allowed enabled: false.
		deny enabled:false.
		currentRule label: 'Il n''y a plus de question'.
	
		SpInformDialog new
    		title: 'Diagnostique';
    		label: (engine diag value) asString;
    		acceptLabel: 'Quitter';
    		openModal.
		]
]
