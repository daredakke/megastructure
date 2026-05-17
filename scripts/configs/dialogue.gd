class_name Dialogue
extends Node
## A place for dialogue of all kinds, including linear, looping and branching.


enum PeopleKeys {
	TestPerson
}

enum Keys {
	# Test Level
	TestDialogue,
	TestBox,
}

static var char_names := {
	PeopleKeys.TestPerson: "Test Person",
}

static var lines := {
	Keys.TestDialogue: {
		"start": [
			{
				"speaker": char_names[PeopleKeys.TestPerson],
				"line": "Hello there.",
			},
			{
				"speaker": char_names[PeopleKeys.TestPerson],
				"line": "Do you need something?",
				"choices": [
					{
						"text": "Yes",
						"branch": "A"
					},
					{
						"text": "No",
						"branch": "B"
					},
					{
						"text": "What are you reading?",
						"branch": "C",
					},
				]
			},
		],
		"A": [
			{
				"speaker": char_names[PeopleKeys.TestPerson],
				"line": "I see...",
				"branch": "D"
			},
		],
		"B": [
			{
				"speaker": char_names[PeopleKeys.TestPerson],
				"line": "Then why are you talking to me?",
				"branch": "D"
			},
		],
		"C": [
			{
				"speaker": char_names[PeopleKeys.TestPerson],
				"line": "This is an article by a reputable scholar about how the government eradicated all birds in the 80s and replaced them with sophisticated camouflaged surveillance drones."
			},
			{
				"speaker": char_names[PeopleKeys.TestPerson],
				"line": "It's terribly fascinating. I can lend it to you later once I'm finished with it."
			},
		],
		"D": [
			{
				"speaker": char_names[PeopleKeys.TestPerson],
				"line": "I am busy reading, go away."
			},
		]
	},
	Keys.TestBox: {
		"start": [
			{
				"speaker": "With Speaker",
				"line": "When I write I'm listening to things that inspire me in the direction of whatever world I'm imagining. Boris and Sunn O))) and Earth were really instrumental in me just finding a place in my head. It's important to write about things that matter to you in particular or just not bother.",
			},
			{
				"speaker": "",
				"line": "When I write I'm listening to things that inspire me in the direction of whatever world I'm imagining. Boris and Sunn O))) and Earth were really instrumental in me just finding a place in my head. It's important to write about things that matter to you in particular or just not bother.",
			},
		],
	},
}


static func get_dialogue_lines(key: Keys) -> Dictionary:
	return lines[key]
