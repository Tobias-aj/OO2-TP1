Class {
	#name : #TestCuOOra,
	#superclass : #TestCase,
	#instVars : [
		'sis',
		'u1',
		'u2',
		'u3',
		'u4',
		't1',
		't2',
		't3',
		't4',
		't5',
		'q1',
		'q2',
		'q3',
		'a1',
		'a2',
		'a3',
		'v1',
		'v2',
		'v3'
	],
	#category : #'OO2 Tp1-test'
}

{ #category : #running }
TestCuOOra >> setUp [
	| ord1 ord2 aux |
	sis := CuOOra new.
	u1 := User newUsername: 'pedro@cuoora.com' password: 'asd'.
	u2 := User newUsername: 'diego@cuoora.com' password: 'asd'.
	u3 := User newUsername: 'juan@cuoora.com' password: 'asd'.
	sis addUser: u1.
	sis addUser: u2.
	sis addUser: u3.
	u3 addFollowing: u2.
	u1 addFollowing: u3.
	ord1 := OrderedCollection new.
	t1 := Topic newName: 'OO1' description: 'Orientacion a Objetos 1'.
	t2 := Topic
		newName: 'Test de unidad'
		description: 'Testeo de programas'.
	ord1 add: t1.
	ord1 add: t2.
	sis addTopicList: ord1.
	ord2 := OrderedCollection new.
	t3 := Topic
		newName: 'Smalltalk'
		description: 'Lenguaje de Programacion'.
	ord2 add: t1.
	ord2 add: t3.
	aux := OrderedCollection new.
	aux add: t3.
	sis addTopicList: aux.
	q1 := Question
		newAuthor: u1
		text:
			'Necesito aprender a hacer test pero no entiendo para q sirve este metodo.'
		title: '¿Para qué sirve el método SetUp?'
		topics: ord1.
	q2 := Question
		newAuthor: u2
		text: 'Tengo este error y necesito ayuda.'
		title: '¿Qué significa #messageNotUnderstood?'
		topics: ord2.
	a1 := Answer
		newAuthor: u2
		text:
			' Sirve para instanciar los objetos que son
evaluados por el test en un único método y que se ejecute
siempre antes de cada test.'.
	a2 := Answer
		newAuthor: u1
		text:
			' Significa que el objeto que recibió el mensaje
no encontró ningún método para ejecutar en respuesta.'.
	sis addQuestionToSistem: q1.
	sis addQuestionToSistem: q2.
	q1 addAnswer: a1.
	q2 addAnswer: a2.
	v1 := Vote newBelongsTo: u2 value: true.
	v2 := Vote newBelongsTo: u1 value: true.
	q1 addVote: v1.
	a1 addVote: v2.

	"------------------------------"
	u2 addInterestTopic: t1.
	q3 := Question
		newAuthor: u3
		text: 'text'
		title: 'title'
		topics: ord1.
	t4 := Topic newName: 'OO2' description: 'Orientacion a Objetos 2'.
	t5 := Topic
		newName: 'CADP'
		description: 'Conceptos de Algoritmos Datos y Programas'.
		
	u4 := User newUsername: 'Osbourne' password:'CrazyTrain'.
	 
]

{ #category : #tests }
TestCuOOra >> testAddQuestionToSistem [
	self deny: sis topics isEmpty.
	self assert: t1 questions size equals: 2.
	self assert: t2 questions size equals: 1.
	self deny: (t1 questions includes: q3).
	self deny: (t2 questions includes: q3).
	sis addQuestionToSistem: q3.
	self assert: t1 questions size equals: 3.
	self assert: t2 questions size equals: 2.
	self assert: (t1 questions includes: q3).
	self assert: (t2 questions includes: q3).
]

{ #category : #tests }
TestCuOOra >> testAddTopicList [
	| ord |
	ord := OrderedCollection new.
	self assert: sis topics size equals: 3.
	self deny: (sis topics includes: t4).
	self deny: (sis topics includes: t5).
	ord add: t4.
	ord add: t5.
	sis addTopicList: ord.
	self assert: sis topics size equals: 5.
	self assert: (sis topics includes: t4).
	self assert:	 (sis topics includes: t5).
]

{ #category : #acccessing }
TestCuOOra >> testAddUser [ 
self deny: (sis users isEmpty) .
self assert:sis users size equals:3.
self deny:(sis users includes: u4). 
sis addUser:u4. 
self assert:sis users size equals:4.
self assert:(sis users includes: u4). 
]

{ #category : #tests }
TestCuOOra >> testAnswersBy [
	self assert: (sis answersBy: u3) size equals: 0.
	self assert: (sis answersBy: u1) size equals: 1.
	self assert: ((sis answersBy: u1) includes: a2).
	self assert: (sis answersBy: u2) size equals: 1.
	self assert: ((sis answersBy: u2) includes: a1).
]

{ #category : #tests }
TestCuOOra >> testCreateTopics [
	|string topics|
	string:= 'Tecnologia,programacion,pc'.
	topics := (sis createTopics: (string findTokens: ',')).
	
	
	self assert: (topics anySatisfy: [:topic| topic name = 'programacion' ]) .
		
	self assert: (topics anySatisfy: [:topic| topic name = 'pc' ]) .
	
	self assert: (topics anySatisfy: [:topic| topic name = 'Tecnologia' ]) .
	
	self deny: (topics anySatisfy: [:topic| topic name = 'cocina' ]) .


]

{ #category : #tests }
TestCuOOra >> testDeleteQuestion [
	self assert: (t1 questions includes: q1).
	self assert: t1 questions size equals: 2 .
	self assert: (t2 questions includes: q1).
	self assert: t2 questions size equals: 1 .
	
	sis deleteQuestion: q1.
	
	self deny: (t1 questions includes: q1).
	self assert: t1 questions size equals: 1 .
	self deny: (t2 questions includes: q1).
	self assert: t2 questions size equals: 0 .
]

{ #category : #tests }
TestCuOOra >> testGetTopicQuestions [
	|collection |
	collection := OrderedCollection new.	"Creo la coleccion esperada"
	collection add: q1.
	collection add: q2.
	
	self assertCollection: (sis getTopicQuestions: t1) equals: collection.
	
	self assert: ((sis getTopicQuestions: t2)size=1)
]

{ #category : #acccessing }
TestCuOOra >> testGetUsersQuestions [
|following|
following:=OrderedCollection new.
following add:u2.
following add:u1.

self assert:((sis getUsersQuestions:following)includes:q1).
self assert:((sis getUsersQuestions:following)includes:q2).
self deny:((sis getUsersQuestions:following)includes:q3).




]

{ #category : #acccessing }
TestCuOOra >> testLatestPostInNetwork [
self assert:((sis latestPostInNetwork:(u3 following) user:u3)includes:q2). 
self assert:((sis latestPostInNetwork:(u2 following) user:u2)includes:q1). 
self deny:((sis latestPostInNetwork:(u1 following) user:u1)includes:q1). 


]

{ #category : #tests }
TestCuOOra >> testQuestionsBy [
	self assert:((sis questionsBy:u2)includes:q2).
	self deny:((sis questionsBy:u2)includes:q1).
	self assert: (sis questionsBy: u3) isEmpty.
	

	
	
	
]

{ #category : #tests }
TestCuOOra >> testScoreA [
self assert:((sis scoreA:u1)=50).
self assert:(sis scoreA:u3)=0.
]

{ #category : #tests }
TestCuOOra >> testScoreQ [
self assert:((sis scoreQ:u1)=20).
self deny:(sis scoreQ:u3)=20.
self assert:((sis scoreQ:u1)=20).
]

{ #category : #tests }
TestCuOOra >> testScoreV [
self assert:((sis scoreV:u1)=2).
self assert:(sis scoreV:u3)=0.
self deny:((sis scoreV:u2)=1).
]

{ #category : #acccessing }
TestCuOOra >> testTotalScoreOf [

self assert:((sis totalScoreOf:u1 )= 72).
self assert:((sis totalScoreOf:u3 )= 0).

]

{ #category : #tests }
TestCuOOra >> testUserWithUsernameProtectedBy [
self assert: (sis userWithUsername: 'diego@cuoora.com' protectedBy: 'asd') equals: u2.

self deny: (sis userWithUsername: 'pedro@cuoora.com' protectedBy: 'fdsa')  equals: u1.

self assert: (sis userWithUsername: 'gerardo' protectedBy: 'holaMundo') equals: nil.
]

{ #category : #acccessing }
TestCuOOra >> testUsersMatchingNamePart [
self assert: [(sis usersMatchingNamePart: 'e') includes: u1] .
self assert: [(sis usersMatchingNamePart: 'e') includes: u2] .
self deny: [(sis usersMatchingNamePart: 'e') includes: u3] .




]
