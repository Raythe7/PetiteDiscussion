Class {
	#name : 'Rule',
	#superclass : 'Object',
	#traits : 'TComparable',
	#classTraits : 'TComparable classTrait',
	#instVars : [
		'condition',
		'action',
		'enable',
		'weight',
		'question'
	],
	#category : 'FruitExpert-ExpertSystem',
	#package : 'FruitExpert',
	#tag : 'ExpertSystem'
}

{ #category : 'instance creation' }
Rule class >> newWithCondition: conditionBlock andAction: actionBlock [
	
	^ (self new)
		condition: conditionBlock;
		action: actionBlock;
		yourself.
]

{ #category : 'instance creation' }
Rule class >> newWithCondition: conditionBlock andAction: aFact andQuestion: aQuestion andValue: value [
	
	^ (self new)
		condition: conditionBlock;
		action: aFact;
		question: aQuestion;
		weight: value;
		yourself.
]

{ #category : 'instance creation' }
Rule class >> newWithCondition: conditionBlock andAction: actionBlock andValue: value [
	
	^ (self new)
		condition: conditionBlock;
		action: actionBlock;
		weight: value;
		yourself.
]

{ #category : 'instance creation' }
Rule class >> newWithCondition: conditionBlock andQuestion: aQuestion andValue: value [
	
	^ (self new)
		condition: conditionBlock;
		question: aQuestion;
		weight: value;
		yourself.
]

{ #category : 'instance creation' }
Rule class >> newWithCondition: conditionBlock andValue: value [
	
	^ (self new)
		condition: conditionBlock;
		weight: value;
		yourself.
]

{ #category : 'comparing' }
Rule >> < aComparable [
	"Answer whether the receiver is less than the argument."

	^ (self weight < aComparable weight)
]

{ #category : 'accessing' }
Rule >> action [

	^ action
]

{ #category : 'accessing' }
Rule >> action: anObject [

	action := anObject
]

{ #category : 'accessing' }
Rule >> condition [

	^ condition
]

{ #category : 'accessing' }
Rule >> condition: anObject [

	condition := anObject
]

{ #category : 'accessing' }
Rule >> enable [

	^ enable
]

{ #category : 'accessing' }
Rule >> enable: anObject [

	enable := anObject
]

{ #category : 'initialization' }
Rule >> initialize [
	super initialize.
	self enable: true. 
	self condition: [  ].
	self action: [  ].
	self question: nil.
]

{ #category : 'accessing' }
Rule >> question [

	^ question
]

{ #category : 'accessing' }
Rule >> question: anObject [

	question := anObject
]

{ #category : 'accessing' }
Rule >> value: aFactBase [
	(self enable & self condition value: aFactBase) ifFalse: [ ^ self ].
	self enable: false.
	^ self action value: aFactBase
]

{ #category : 'accessing' }
Rule >> weight [
	^ weight
]

{ #category : 'accessing' }
Rule >> weight: anObject [
	weight := anObject
]
