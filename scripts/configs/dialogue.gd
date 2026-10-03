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
	Sashimi,
	Relatable,
	LobsterGirl,
	Painful,
	Ideas,
	SSSegue,
	MusicBox,
	EndCards,
	Choice,
	SpinOff,
	Sadness,
	DrunkPicnic,
	WashedOut,
	FakeShimeji,
	OctopusGirl,
	Egg,
	CharacterDesign,
	SisDrunk,
	CloseUpTwo,
	Touhou,
	ThankYou,
	AboutProject,
	Outside,
	Reverb,
	LedgeGrab,
	InteriorSpaces,
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
				"line": "There are 355 images in this gallery organised into seven collections based around a few rough themes I was noticing.",
			},
			{
				"speaker": "",
				"line": "Some pictures easily belong to multiple collections and I've placed some of these close to collection transitions.",
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
				"line": "You'd be smug too if you had two tuna.",
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
	Keys.Sashimi: {
		"start": [
			{
				"speaker": "",
				"line": "One of several examples of girls pondering fish. It says 'sashimi', so I guess that clears up her intentions.",
			},
		],
	},
	Keys.Relatable: {
		"start": [
			{
				"speaker": "",
				"line": "Possibly one of the comfiest images in this gallery.",
			},
			{
				"speaker": "",
				"line": "I think I relate to it since I usually do most of my work at home on a laptop while dressed in something comfortable.",
			},
		],
	},
	Keys.LobsterGirl: {
		"start": [
			{
				"speaker": "",
				"line": "I've always been struck by how well this one was drawn.",
			},
			{
				"speaker": "",
				"line": "The moon is interesting, though the starless sky is a little unsettling.",
			},
		],
	},
	Keys.Painful: {
		"start": [
			{
				"speaker": "",
				"line": "Despite how much pain and suffering is depicted here, a fish manages to make an appearance.",
			},
			{
				"speaker": "",
				"line": "As always, the face in one of the lenses hints at a greater story. It's nice to stare and ponder what that might be.",
			},
		],
	},
	Keys.Ideas: {
		"start": [
			{
				"speaker": "",
				"line": "Images like this make me wonder where tkmiz gets his ideas from. This one's so strange, yet also kinda funny.",
			},
			{
				"speaker": "",
				"line": "I like her smug facial expression while the beer can amusingly diminishes the seriousness of the scene.",
			},
		],
	},
	Keys.SSSegue: {
		"start": [
			{
				"speaker": "",
				"line": "I could have placed these in the SS collection, especially the one in the middle, but I like to have a loose connection to the next level.",
			},
			{
				"speaker": "",
				"line": "Though it only works if you're going counter-clockwise.",
			},
			{
				"speaker": "",
				"line": "Incidentally, the one in the middle is a favourite. The colours and the way she appears to move lends a very carefree feeling to it that I like.",
			},
		],
	},
	Keys.MusicBox: {
		"start": [
			{
				"speaker": "",
				"line": "There are ten tracks I put together for this gallery, all arrangements of pieces from the SSR soundtrack.",
			},
			{
				"speaker": "",
				"line": "Some are relatively faithful to their sources, others are slower or shorter. The playlist is randomised at game launch.",
			},
			{
				"speaker": "",
				"line": "I went with a music box as the only instrument for sake of simplicity which allowed me to produce enough tracks to keep things varied.",
			},
			{
				"speaker": "",
				"line": "Also, I felt something on the quieter, less busy side would make for a nicer viewing experience while not being too distracting. Of course, you can just turn it off or play something else if you want.",
			},
			{
				"speaker": "",
				"line": "I did consider trying to make original music, but that would have required a lot more time and energy which I didn't have. Work keeps me quite busy in September.",
			},
			{
				"speaker": "",
				"line": "Tracklist (in no particular order): Amadare no Uta, Chito to Yuuri, Futaribocchi, Hazumu Kokoro, Hikari wo Motomete, Kaze to Haikyo to Sanpomichi, Kettenkrad, Kimi to Sugosu Hibi, Kimi wo Omou, Owari no Uta.",
			},
		],
	},
	Keys.EndCards: {
		"start": [
			{
				"speaker": "",
				"line": "It's nice seeing all these end cards lined up next to each other.",
			},
			{
				"speaker": "",
				"line": "A shame we'll never see the final two SSR volumes animated. Especially the AI chapter.",
			},
		],
	},
	Keys.Choice: {
		"start": [
			{
				"speaker": "",
				"line": "I was spoiled for choice regarding images for this level, hence why everything might feel a bit crammed in. I did the best I could to fit in what I felt to be most important.",
			},
		],
	},
	Keys.SpinOff: {
		"start": [
			{
				"speaker": "",
				"line": "These ones of Chito and Yuuri at university would make for a great slice of life spin off I feel. It's just fun watching them interact, especially if the setting was more down to earth.",
			},
		],
	},
	Keys.Sadness: {
		"start": [
			{
				"speaker": "",
				"line": "This one just makes me feel sad, it should be obvious if you know why. A fitting end to this collection.",
			},
		],
	},
	Keys.DrunkPicnic: {
		"start": [
			{
				"speaker": "",
				"line": "This one I've always found really comfy. Chito is particulary cute here.",
			},
			{
				"speaker": "",
				"line": "I like the idea that she's weaker to alcohol than Yuuri. Maybe that's wishful thinking.",
			},
			{
				"speaker": "",
				"line": "It's also relatable in how alcohol tends to make me quite sleepy these days, more so than when I was younger.",
			},
		],
	},
	Keys.WashedOut: {
		"start": [
			{
				"speaker": "",
				"line": "The brightness and the washed out look this scene has really makes it feel hot. Days like this are nice every once in a while.",
			},
			{
				"speaker": "",
				"line": "It seems like we'll be having a lot more of them in years to come.",
			},
		],
	},
	Keys.FakeShimeji: {
		"start": [
			{
				"speaker": "",
				"line": "I don't even know if this is Shijima or not. It sure feels like her, but her eyes are red while everywhere else it's blue or black.",
			},
		],
	},
	Keys.OctopusGirl: {
		"start": [
			{
				"speaker": "",
				"line": "It's nice to know that these sisters got a small collection of their own.",
			},
			{
				"speaker": "",
				"line": "Right: caption reads 'Desire to show off octopus' while she invites you to look at the octopus.",
			},
			{
				"speaker": "",
				"line": "Top-right: caption reads 'Octopus, feeling of affirmation' while she is impressed. Admittedly I'm not quite sure what a better translation of the caption would be.",
			},
			{
				"speaker": "",
				"line": "Left: 'Human rights for octopi!",
			},
		],
	},
	Keys.Egg: {
		"start": [
			{
				"speaker": "",
				"line": "Egg.",
			},
			{
				"speaker": "",
				"line": "Pls don't scramble or omelette.",
			},
		],
	},
	Keys.CharacterDesign: {
		"start": [
			{
				"speaker": "",
				"line": "It's nice when a character's design reflects their personality.",
			},
			{
				"speaker": "",
				"line": "Even if you don't know these two, you can at least make a good guess as to what they're like to be around.",
			},
		],
	},
	Keys.SisDrunk: {
		"start": [
			{
				"speaker": "",
				"line": "/sisdrunk/",
			},
			{
				"speaker": "",
				"line": "A relatable image.",
			},
		],
	},
	Keys.CloseUpTwo: {
		"start": [
			{
				"speaker": "",
				"line": "I'm pretty sure this is Shijima, though I realise now that it's hard to tell.",
			},
			{
				"speaker": "",
				"line": "Still, there's something amusing to me about such a close-up. Her displeasure with whatever's in front of her is emphasised considerably.",
			},
		],
	},
	Keys.Touhou: {
		"start": [
			{
				"speaker": "",
				"line": "All roads lead to Touhou Project it seems.",
			},
			{
				"speaker": "",
				"line": "This pleases me as a big fan of Touhou, though unfortunately it doesn't seem like tkmiz has drawn Youmu, Kogasa or Nazrin.",
			},
		],
	},
	Keys.ThankYou: {
		"start": [
			{
				"speaker": "",
				"line": "Thank you for taking the time to wander through this gallery.",
			},
			{
				"speaker": "",
				"line": "I know it isn't much, but I hope it was interesting at least for a little while.",
			},
			{
				"speaker": "",
				"line": "I've been working on 3D projects here and there over the past few years with little direction, so it's nice to finally create something cohesive, even if it isn't all that interactive.",
			},
			{
				"speaker": "",
				"line": "Whether I make more stuff like this remains to be seen. There's a chance I'll never touch game dev ever again after this. It's really tiresome.",
			},
		],
	},
	Keys.AboutProject: {
		"start": [
			{
				"speaker": "",
				"line": "Hello. Thank you for taking a look at this odd project I put together over 3-4 weeks.",
			},
			{
				"speaker": "",
				"line": "I wanted to make some kind of diorama in advance of the sixth SSR rewatch, sort of like the drainage thing I put together two years ago.",
			},
			{
				"speaker": "",
				"line": "I toyed with a few ideas before settling on the art gallery from SSR chapter 35. I figured it'd be nice to have a space you could move through to view tkmiz's art instead of just browsing a file explorer.",
			},
			{
				"speaker": "",
				"line": "Plus it meant I didn't have to do so much 3D modelling as it can get rather dull.",
			},
		],
	},
	Keys.Outside: {
		"start": [
			{
				"speaker": "",
				"line": "The environment beyond the art gallery is a bit sparse. This reflects how things are in chapter 35 and is one of the reasons why I went with this idea over, say, the pipe maze before the factory that Ishii points the girls to.",
			},
			{
				"speaker": "",
				"line": "I got a bit lazy with this part and my official justification is that the art gallery is the primary focus, though I was really just got worn out.",
			},
		],
	},
	Keys.Reverb: {
		"start": [
			{
				"speaker": "",
				"line": "There is a simple dynamic reverb system that tries to make moving between exterior and interior spaces a bit more convincing. It doesn't really work in all cases though and would require more work to get right.",
			},
			{
				"speaker": "",
				"line": "It came about after I made the drainage diorama. I wanted to add footsteps and felt they should sound different when you move into larger or smaller spaces.",
			},
			{
				"speaker": "",
				"line": "For more serious projects (like that'll ever happen), I'd probably go with how it was done in Half Life 2 or use FMod or something.",
			},
		],
	},
	Keys.LedgeGrab: {
		"start": [
			{
				"speaker": "",
				"line": "You can ledge grab by jumping towards a ledge and pressing space when the indicator appears. I was going to disable it for this project, but I forgot. I'm not really sure why I added it in the first place.",
			},
			{
				"speaker": "",
				"line": "It's a quick and dirty solution since it requires you to hold forward to make it, but I don't think it feels that bad.",
			},

		],
	},
	Keys.InteriorSpaces: {
		"start": [
			{
				"speaker": "",
				"line": "I was thinking of adding something to these empty spaces on each level, like some tables and chairs perhaps, but alas I ran out of energy.",
			},
		],
	},
}


static func get_dialogue_lines(key: Keys) -> Dictionary:
	return lines[key]
