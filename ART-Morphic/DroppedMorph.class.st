"
PBEの勉強用
"
Class {
	#name : 'DroppedMorph',
	#superclass : 'Morph',
	#category : 'ART-Morphic',
	#package : 'ART-Morphic'
}

{ #category : 'initialization' }
DroppedMorph >> initialize [

	super initialize.
	self color: Color blue.
	self position: 250 @ 100
]

{ #category : 'dropping/grabbing' }
DroppedMorph >> rejectDropMorphEvent: anEvent [

	| h |
	h := anEvent hand.
	UIManager default defer: [ h grabMorph: self ].
	anEvent wasHandled: true
]
