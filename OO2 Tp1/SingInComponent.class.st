Class {
	#name : #SingInComponent,
	#superclass : #AccessComponent,
	#category : #'OO2 Tp1-ui'
}

{ #category : #utility }
SingInComponent >> registerAndLogin [
	| theUser |
	theUser :=  User newUsername: username password: password.
	self model addUser: theUser.
	self proceedWith: theUser
]

{ #category : #rendering }
SingInComponent >> renderButtonsOn: aCanvas [ 
	self renderSignUpButtonOn: aCanvas
]

{ #category : #rendering }
SingInComponent >> renderInputElementsOn: aCanvas [
	aCanvas horizontalRule.
	aCanvas heading:'Creating new Account'.
	super renderInputElementsOn: aCanvas.

]

{ #category : #rendering }
SingInComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton 
		callback: [ self answer ];
		with: 'Back' .
	aCanvas submitButton
		callback: [ self registerAndLogin ];
		with: 'Register'.
	aCanvas horizontalRule
]
