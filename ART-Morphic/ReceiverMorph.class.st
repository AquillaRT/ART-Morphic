"
PBEの勉強用
"
Class {
	#name : 'ReceiverMorph',
	#superclass : 'Morph',
	#category : 'ART-Morphic',
	#package : 'ART-Morphic'
}

{ #category : 'initialization' }
ReceiverMorph >> initialize [

	super initialize.
	self color: Color red.
	self extent: 200 @ 200
]

{ #category : 'dropping/grabbing' }
ReceiverMorph >> repelsMorph: aMorph event: anEvent [
	"判定が false（欲しくない）なら、true（拒絶）を返す"

	^ (self wantsDroppedMorph: aMorph) not
]

{ #category : 'dropping/grabbing' }
ReceiverMorph >> wantsDroppedMorph: aMorph [

	^ aMorph color = Color blue
]

{ #category : 'dropping/grabbing' }
ReceiverMorph >> wantsDroppedMorph: aMorph event: anEvent [
	"自分自身（self）の引数1つ版に丸投げする"

	^ self wantsDroppedMorph: aMorph
]
