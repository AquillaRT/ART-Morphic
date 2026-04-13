"
PBEの勉強用
"
Class {
	#name : 'CrossMorph',
	#superclass : 'Morph',
	#category : 'ART-Morphic',
	#package : 'ART-Morphic'
}

{ #category : 'dropping/grabbing' }
CrossMorph >> aboutToBeGrabbedBy: aHand [
	"自分の現在の位置をプロパティとして保存しておく"

	self setProperty: #oldPosition toValue: self position.
	super aboutToBeGrabbedBy: aHand
]

{ #category : 'geometry testing' }
CrossMorph >> containsPoint: aPoint [
	"当たり判定を十字の形に合わせる（以前実装したもの）"

	^ (self horizontalBar containsPoint: aPoint) or: [
		  self verticalBar containsPoint: aPoint ]
]

{ #category : 'drawing' }
CrossMorph >> drawOn: aCanvas [
	"自分自身の bounds を使って描画する"

	aCanvas fillRectangle: self horizontalBar color: self color.
	aCanvas fillRectangle: self verticalBar color: self color
]

{ #category : 'layout' }
CrossMorph >> fullBounds [
	"テキストの描画範囲より、上下左右に1ピクセルずつ広く掃除範囲を設定します"

	^ super fullBounds expandBy: 1
]

{ #category : 'event handling' }
CrossMorph >> handlesKeyDown: anEvent [

	^ true
]

{ #category : 'event handling' }
CrossMorph >> handlesKeyStroke: anEvent [

	^ true
]

{ #category : 'event handling' }
CrossMorph >> handlesMouseDown: anEvent [

	^ true
]

{ #category : 'event handling' }
CrossMorph >> handlesMouseOver: anEvent [

	^ true
]

{ #category : 'private' }
CrossMorph >> horizontalBar [

	| crossHeight |
	crossHeight := (self height / 3) rounded.
	^ self bounds insetBy: 0 @ crossHeight
]

{ #category : 'initialization' }
CrossMorph >> initialize [

	super initialize.
	"十字架全体を包み込む矩形（0,0 から 100,100 まで）を自分の領土として設定する"
	self bounds: (0 @ 0 extent: 100 @ 100).
	self color: Color blue
]

{ #category : 'event handling' }
CrossMorph >> keyDown: anEvent [

	| key |
	key := anEvent key.
	key = KeyboardKey up ifTrue: [
		self position: self position - (0 @ 10) ].
	key = KeyboardKey down ifTrue: [
		self position: self position + (0 @ 10) ].
	key = KeyboardKey right ifTrue: [
		self position: self position + (10 @ 0) ].
	key = KeyboardKey left ifTrue: [
		self position: self position - (10 @ 0) ]
]

{ #category : 'event handling' }
CrossMorph >> keyStroke: anEvent [

	| keyValue |
	keyValue := anEvent keyCharacter.
	keyValue == $+ ifTrue: [ self startStepping ].
	keyValue == $- ifTrue: [ self stopStepping ]
]

{ #category : 'event handling' }
CrossMorph >> mouseDown: anEvent [

	anEvent redButtonPressed ifTrue: [ "今の色が青なら赤に、そうでなければ青にする（トグル処理）"
			self color = Color blue
				ifTrue: [ self color: Color red ]
				ifFalse: [ self color: Color blue ] ].

	anEvent yellowButtonPressed ifTrue: [ self color: Color yellow ].

	self changed
]

{ #category : 'event handling' }
CrossMorph >> mouseEnter: anEvent [

	anEvent hand newKeyboardFocus: self
]

{ #category : 'event handling' }
CrossMorph >> mouseLeave: anEvent [

	anEvent hand releaseKeyboardFocus: self
]

{ #category : 'geometry' }
CrossMorph >> position: aPoint [

	self changed. "動く前の場所を汚染（消去対象）にする"
	super position: aPoint.
	self changed "動いた後の場所を再描画対象にする"
]

{ #category : 'dropping/grabbing' }
CrossMorph >> rejectDropMorphEvent: anEvent [
	"保存した場所を取り出す（なければ今の場所）"

	| oldPos |
	oldPos := self
		          valueOfProperty: #oldPosition
		          ifAbsent: [ self position ].
	"アニメーションさせずに、まずは確実に『戻る』ことを優先"
	self position: oldPos.
	self openInWorld "これでもう消えません"
]

{ #category : 'stepping and presenter' }
CrossMorph >> step [

	(self color diff: Color black) < 0.1
		ifTrue: [ self color: Color red ]
		ifFalse: [ self color: self color darker ]
]

{ #category : 'stepping and presenter' }
CrossMorph >> stepTime [

	^ 100
]

{ #category : 'private' }
CrossMorph >> verticalBar [

	| crossWidth |
	crossWidth := (self width / 3) rounded.
	^ self bounds insetBy: crossWidth @ 0
]
