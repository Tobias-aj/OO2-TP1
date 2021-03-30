Class {
	#name : #Question,
	#superclass : #Object,
	#instVars : [
		'text',
		'creationDate',
		'questionTopics',
		'userQuestion',
		'answers',
		'votes'
	],
	#category : #'OO2 Tp1-model'
}

{ #category : #'instance creation' }
Question class >> newText:aText user:anUser topics:allTopics [        "recibe una coleccion de topicos"
|instance|
instance :=self new.
instance text: aText userQuestion: anUser topics: allTopics

]

{ #category : #adding }
Question >> addVoteQ:aVote [
votes add:aVote
]

{ #category : #accessing }
Question >> answers [
^answers


]

{ #category : #accessing }
Question >> answersBy:aUser [ 
^answers select:[:each | each author == aUser username ]
]

{ #category : #accessing }
Question >> creationDate [
^creationDate




]

{ #category : #accessing }
Question >> orderedAnswers [
	^ answers asSortedCollection: [:answer1 :answer2 |  answer1 score  <= answer2 score]
]

{ #category : #accessing }
Question >> questionTopics [
^questionTopics



]

{ #category : #accessing }
Question >> sumInteresting:aUser [ 
^(self questionBy:aUser) + (self answersBy: aUser).
]

{ #category : #accessing }
Question >> text [
^text

]

{ #category : #initialize }
Question >> text: aText userQuestion: anUser topics: allTopics [
	text := aText.
	userQuestion := anUser.
	questionTopics := allTopics.
	creationDate := Date today.
	answers := OrderedCollection.
	votes := OrderedCollection
]

{ #category : #accessing }
Question >> userQuestion [
^userQuestion


]

{ #category : #accessing }
Question >> votes [
^votes





]