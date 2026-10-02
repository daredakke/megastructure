class_name Dialogue
extends Node
## A place for dialogue of all kinds, including linear, looping and branching.


enum PeopleKeys {
	TestPerson
}

enum Keys {
	TestDialogue,
	TestBox,
	ViewingOrder,
	ExhibitChoice,
	FlyingCatGirl,
	Eels,
	SharedThemes,
	SecretShimeji,
	Interpretation,
	FishCount,
	GloomyCandidate,
	BalancedComposition,
	OLSuicide,
	LonelyOctopus,
	KaniHat,
	Fishiles,
	AboutGloomy,
	CastellaNightRain,
	Despair,
	AnotherStory,
	NudeDrinking,
	Graduation,
	EtchASketch,
	SmugTuna,
	CloseUp,
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
				"speaker": "Test",
				"line": "When I write I'm listening to things that inspire me in the direction of whatever world I'm imagining. Boris and Sunn O))) and Earth were really instrumental in me just finding a place in my head. It's important to write about things that matter to you in particular or just not bother.",
			},
		],
	},
	Keys.ViewingOrder: {
		"start": [
			{
				"speaker": "",
				"line": "When placing the pictures, I started from the door on the right and proceeded in a counter-clockwise direction for each floor. You might want to follow the exhibits in that order, but it doesn't really matter that much.",
			},
		],
	},
	Keys.ExhibitChoice: {
		"start": [
			{
				"speaker": "",
				"line": "I went with a bunch of rough themes to determine what collections to display. Some pictures easily belong to multiple collections and I've placed some of these close to collection transitions.",
			},
			{
				"speaker": "",
				"line": "The gloomy collection is the roughest since there are plenty of gloomy pictures in tkmiz's output. Try not to think too hard about it.",
			},
		],
	},
	Keys.FlyingCatGirl: {
		"start": [
			{
				"speaker": "",
				"line": "This picture is fascinating. I wonder how she ended up here and in what direction she's flying. The accompanying fish are really funny to me somehow.",
			},
		],
	},
	Keys.Eels: {
		"start": [
			{
				"speaker": "",
				"line": "I found another eel picture like these after I finished placing all the pictures. Unfortunately I couldn't be bothered making space for it, I'm sorry.",
			},
			{
				"speaker": "",
				"line": "The left is the 'straight-forward eel' who absolutely does not want to bend itself.",
			},
			{
				"speaker": "",
				"line": "The right is the 'connected eels'. The left eel wants to connect while the right eel is having a hard time.",
			},
		],
	},
	Keys.SharedThemes: {
		"start": [
			{
				"speaker": "",
				"line": "Sometimes I notice a theme between pictures in a collection, so I've tried to put some together.",
			},
			{
				"speaker": "",
				"line": "Also, did you know that all the frames are procedurally generated? I was going to place the images on the walls as is, but a friend's suggestion pushed me to try a little harder.",
			},
		],
	},
	Keys.SecretShimeji: {
		"start": [
			{
				"speaker": "",
				"line": "On closer inspection, I noticed that she has head shrooms like Shijima from SS.",
			},
			{
				"speaker": "",
				"line": "I didn't notice while putting the collections together or when placing each picture. I considered maybe placing this in the SS collection, but it's so subtle that I don't think it really matters.",
			},
		],
	},
	Keys.Interpretation: {
		"start": [
			{
				"speaker": "",
				"line": "You could read into this one as representing a feeling of directionlessness, stagnation and reckless consumerism in modern society or something.",
			},
			{
				"speaker": "",
				"line": "Or you could just take it at face value and marvel at the absurd scene on display. How did these girls find themselves in this situation I wonder?",
			},
		],
	},
	Keys.FishCount: {
		"start": [
			{
				"speaker": "",
				"line": "I considered trying to count every instance of a fish in the entire gallery and presenting that as a piece of trivia.",
			},
			{
				"speaker": "",
				"line": "But alas I could not be bothered. Still, there's a lot of fish in tkmiz's drawings. I wonder what their favourite is?",
			},
		],
	},
	Keys.GloomyCandidate: {
		"start": [
			{
				"speaker": "",
				"line": "A good example of a picture that could have gone in the gloomy collection. I got a bit tunnel-visioned while placing pictures and didn't think to reconsider for whatever reason.",
			},
			{
				"speaker": "",
				"line": "Now I'm here writing commentary at the end of this long project and I can't bring myself to make any more big changes, so I guess here it will stay.",
			},
		],
	},
	Keys.BalancedComposition: {
		"start": [
			{
				"speaker": "",
				"line": "I like pictures that make me wonder about the story behind what I'm seeing. What drove these girls to hang themselves in this way?",
			},
			{
				"speaker": "",
				"line": "Also, I really like the balanced composition here. There's something satisfying about it.",
			},
		],
	},
	Keys.OLSuicide: {
		"start": [
			{
				"speaker": "",
				"line": "To be trapped in a standard 9-5 office job sounds like my idea of hell, regardless of if I enjoyed the job or not. I hear it's even worse in places like Japan and South Korea.",
			},
			{
				"speaker": "",
				"line": "The blue sky and their joyous expressions says it all really.",
			},
		],
	},
	Keys.LonelyOctopus: {
		"start": [
			{
				"speaker": "",
				"line": "This octopus is lonely. Maybe you can keep it company for a little while.",
			},
		],
	},
	Keys.KaniHat: {
		"start": [
			{
				"speaker": "",
				"line": "/kanihat/",
			},
		],
	},
	Keys.Fishiles: {
		"start": [
			{
				"speaker": "",
				"line": "This might be one of my favourite images in this entire gallery. The idea of 'fishiles' is that amusing.",
			},
			{
				"speaker": "",
				"line": "It's also quite an abstract picture like some of its neighbours. Guess which collection follows this one.",
			},
		],
	},
	Keys.AboutGloomy: {
		"start": [
			{
				"speaker": "",
				"line": "This is probably the weakest collection in the gallery. At the very least, it highlights one aspect common to a lot of tkmiz's art.",
			},
			{
				"speaker": "",
				"line": "The powerline images might be a bit of a stretch though.",
			},
		],
	},
	Keys.CastellaNightRain: {
		"start": [
			{
				"speaker": "",
				"line": "I'm not quite sure what this means. 'This is a bright and castella-rainy night' perhaps?",
			},
		],
	},
	Keys.Despair: {
		"start": [
			{
				"speaker": "",
				"line": "/_despair/",
			},
		],
	},
	Keys.AnotherStory: {
		"start": [
			{
				"speaker": "",
				"line": "Another picture that tells a story. Whatever happened, I'm sure it'll become a painful memory for both of them.",
			},
		],
	},
	Keys.NudeDrinking: {
		"start": [
			{
				"speaker": "",
				"line": "Life can take us to some dark and/or strange places sometimes. It took me way too long to notice the fish on her right thigh.",
			},
		],
	},
	Keys.Graduation: {
		"start": [
			{
				"speaker": "",
				"line": "I quit high school in my last year and never bothered attending my university's graduation ceremony. Makes me wonder what they must be like, especially if you had classmates you actually cared about.",
			},
			{
				"speaker": "",
				"line": "Mustn't forget that, following graduation, one's troubles are only beginning.",
			},
		],
	},
	Keys.EtchASketch: {
		"start": [
			{
				"speaker": "",
				"line": "I've been pondering for a while now about how to describe tkmiz's line art, and I realise now that it reminds me a lot of an etch-a-sketch.",
			},
			{
				"speaker": "",
				"line": "It's like he tries to draw as much as possible with a single line. That the underlying forms feels usually quite solid despite the visible imperfections is really fascinating.",
			},
			{
				"speaker": "",
				"line": "Years ago, it was suggested that tkmiz's style involved 'economy of line', but if that were the case, then his images would be far more minimalistic.",
			},
			{
				"speaker": "",
				"line": "It's more that he doesn't seem to worry about getting lines placed exactly right while having the confidence to render form correctly.",
			},
		],
	},
	Keys.SmugTuna: {
		"start": [
			{
				"speaker": "",
				"line": "I suppose I'd be smug too if I was a tuna dual-wielder.",
			},
		],
	},
	Keys.CloseUp: {
		"start": [
			{
				"speaker": "",
				"line": "I don't have much to say about this image aside from the juxtaposition between the detail of her face with how roughly the room has been drawn.",
			},
			{
				"speaker": "",
				"line": "If you focus on her face, you almost don't notice how crude the desks look.",
			},
		],
	},
}


static func get_dialogue_lines(key: Keys) -> Dictionary:
	return lines[key]
