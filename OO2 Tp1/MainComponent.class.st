"
|application|
application := WAAdmin register: LogInComponent asApplicationAt: 'CuOOra'.
application sessionClass: UserSession .
CuOOra soleInstanceWithExample.
"
Class {
	#name : #MainComponent,
	#superclass : #WAComponent,
	#category : #'OO2 Tp1-ui'
}

{ #category : #callbacks }
MainComponent >> befriend: anUser [
	self session user addFollowing: anUser
]

{ #category : #callbacks }
MainComponent >> createNewPost [
	self call: NewPostComponent new
]

{ #category : #callbacks }
MainComponent >> findFriend [
	self call: (UserFinderComponent newParent:self) .
]

{ #category : #model }
MainComponent >> model [ 
^CuOOra soleInstance 
]

{ #category : #callbacks }
MainComponent >> notBefriend:anUser [
self session user removeFollowing:anUser .
]

{ #category : #rendering }
MainComponent >> renderContentOn: aCanvas [
	aCanvas heading style:' background-color: black; color:white'; with:'CuOOra '.
	aCanvas horizontalRule.
	aCanvas heading: 'Welcome ' , self session user username.
	self renderMyQuestions:aCanvas.
	self renderPostsOn: aCanvas.
	aCanvas horizontalRule.
	self renderFriendsOn: aCanvas.
	aCanvas horizontalRule.
	self renderLogoutButtonOn: aCanvas.
]

{ #category : #rendering }
MainComponent >> renderFriendsOn: aCanvas [
	aCanvas heading
		level: 2;
		with: 'Following'.
	aCanvas
		unorderedList: [ self session user following
				do: [ :each | 
					aCanvas
						listItem:[aCanvas anchor callback: [ self showProfileOf: each ];
						with: (each username) ]] ].
	aCanvas anchor
		callback: [ self findFriend ];
		with: [ aCanvas button: 'Find User' ]
]

{ #category : #rendering }
MainComponent >> renderLastQuestions: aCanvas [
	aCanvas
		unorderedList: [ (self model
				latestPostInNetwork: (self session user following) user:(self session user) )
				do: [ :post | 
					"QuestionComponent new question: post"
					aCanvas render: (QuestionComponent newQuestion: post parent: self)
					"self viewAnswers: aCanvas question: post " ] ]
]

{ #category : #rendering }
MainComponent >> renderLogoutButtonOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self session user: nil.
					self call: LogInComponent new ];
				with: [ aCanvas button with: 'Logout' ] ]
]

{ #category : #rendering }
MainComponent >> renderMyQuestions:aCanvas [
aCanvas strong with: [ 
	aCanvas anchor
		style: 'font-size: 25px; color:darkorange';
		callback: [ self showProfileOf: self session user];
		with: 'My questions'].
aCanvas break.
aCanvas break.
aCanvas anchor
		callback: [ self createNewPost ];
		with: [ aCanvas button: 'Create new post' ].
aCanvas horizontalRule.
]

{ #category : #rendering }
MainComponent >> renderPostsOn: aCanvas [
	aCanvas heading
		level: 2;
		with: 'Latest Posts'.
	self renderLastQuestions: aCanvas .
]

{ #category : #callbacks }
MainComponent >> seeAnswers:aQuestion [
| instance |
	instance := AnswersComponent newQuestion: aQuestion parent:self .
	self call: instance .
	
]

{ #category : #callbacks }
MainComponent >> showProfileOf: aUser [
|instance|
instance := UserProfileComponent newProfileUser: aUser parent:self. 
self call: instance.

]
