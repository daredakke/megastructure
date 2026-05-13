class_name Dialogue
extends Node


enum PeopleKeys {
	TestPerson
}

enum Keys {
	# Test Level
	TestDialogue,
	TestBox,
	OneFence,
	OneMechanics,
	OneFallHeight,
	TwoCompressionAndRelease,
	TwoLargeEnvironments,
	TwoLadders,
	TwoDarkness,
	TwoLiftShafts,
	TwoLiftEasing,
	ThreeCathedral,
	GeneralOriginalIntention,
	GeneralMechanics,
	GeneralMovement,
	GeneralTorch,
	ThreeTestLevel,
	GeneralNoClip,
	GeneralTextures,
	GeneralInfluences,
	GeneralThreeEnvironment,
	GeneralBranchingDialogue,
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
	Keys.OneFence: {
		"start": [
			{
				"speaker": "",
				"line": "[This Fence]",
			},
			{
				"speaker": "",
				"line": "It's annoying how this fence texture disappears at a distance at certain angles.",
			},
			{
				"speaker": "",
				"line": "It'd be fine if it were a 3D model, but this way is much cheaper.",
			},
			{
				"speaker": "",
				"line": "I can't be bothered trying to solve this problem unfortunately.",
			},
		],
	},
	Keys.OneMechanics: {
		"start": [
			{
				"speaker": "",
				"line": "[Introducing Mechanics to the Player]",
			},
			{
				"speaker": "",
				"line": "Mechanics should be presented to the player one at a time, especially those that are important to progression like jumping.",
			},
			{
				"speaker": "",
				"line": "The initial corridor allows players to get comfortable with movement while this area allows them to try running and jumping around in a safe environment.",
			},
			{
				"speaker": "",
				"line": "Completing this part will present them with another area where they can die if they screw up.",
			},
			{
				"speaker": "",
				"line": "When teaching any skill or mechanic, start small and allow room for failure before testing players with more serious challenges.",
			},
		],
	},
	Keys.OneFallHeight: {
		"start": [
			{
				"speaker": "",
				"line": "[Fall Height]",
			},
			{
				"speaker": "",
				"line": "This part intends to teach the player the safe fall height. It's quite a long way down, but since there is no other way, hopefully they try dropping down.",
			},
			{
				"speaker": "",
				"line": "Once they know they can survive such a fall, it should calibrate how they approach later environments, letting them predict which jumps are possible.",
			},
			{
				"speaker": "",
				"line": "It's hard to say if this is really effective without further testing though.",
			},
			{
				"speaker": "",
				"line": "Incidentally, the player can safely fall 12 metres before dying. The amount of camera shake is proportional to the fall distance.",
			},
			{
				"speaker": "",
				"line": "The faster the player falls, they will begin to hear the air rushing around them. This will happen if you travel fast enough in any direction too.",
			},
			{
				"speaker": "",
				"line": "Little touches like that really place the player in the world in my opinion. More games should have them.",
			},
			{
				"speaker": "",
				"line": "Don't worry if you do die, checkpoints are frequent. You can always reset by pressing T if you get stuck somewhere too.",
			},
		],
	},
	Keys.TwoCompressionAndRelease: {
		"start": [
			{
				"speaker": "",
				"line": "[Compression and Release]",
			},
			{
				"speaker": "",
				"line": "This is an architectural term referring to moving people through confined spaces first to make large spaces feel grander.",
			},
			{
				"speaker": "",
				"line": "The transition from the room, vent and pipe to the much larger room is emphasised all the more with the dynamic reverb system.",
			},
			{
				"speaker": "",
				"line": "Running around on these metal pipes and hearing so much echo sells the illusion better than something fixed.",
			},
			{
				"speaker": "",
				"line": "Notice how it changes as you move through the level. The sound will differ between the centre and edges of this room.",
			},
			{
				"speaker": "",
				"line": "Turning on and off the torch while standing still is a good way to check this effect closely.",
			},
			{
				"speaker": "",
				"line": "Also, you may notice the background ambience sounds different when you're in a closed space. Another little detail to improve relative realism.",
			},
			{
				"speaker": "",
				"line": "The smaller and more enclosed the space you're in, the more a low-pass filter acts upon the level atmospherics.",
			},
		],
	},
		Keys.TwoLargeEnvironments: {
		"start": [
			{
				"speaker": "",
				"line": "[The Difficulties of Large Environments]",
			},
			{
				"speaker": "",
				"line": "The main problem will large environments is that you need more detail to make it feel more realistic, even if the player doesn't quite understand what they see.",
			},
			{
				"speaker": "",
				"line": "For example, where do the pipes go? What do they carry? For what purpose was this space built?",
			},
			{
				"speaker": "",
				"line": "While not important in the moment, more details would be nice, like hanging cables, electric boxes, pipes and more to convey a complex arrangement of machinery.",
			},
			{
				"speaker": "",
				"line": "However, it's tiresome and time-consuming work. Hopefully this space gives you some idea of what that might be like.",
			},
			{
				"speaker": "",
				"line": "For a more complete vision, try playing Lorn's Lure or Doll's Nest.",
			},
			{
				"speaker": "",
				"line": "Both of these games move the player through large, detailed megastructures and truly convey a sense of scale.",
			},
		],
	},
	Keys.TwoLadders: {
		"start": [
			{
				"speaker": "",
				"line": "[Ladders]",
			},
			{
				"speaker": "",
				"line": "I made the ladders as a personal challenge and was surprised when I managed to come up with a working solution.",
			},
			{
				"speaker": "",
				"line": "However, they're deeply flawed. They only really work in situations where you jump on to them. Getting off the top successfully usually requires sprinting.",
			},
			{
				"speaker": "",
				"line": "I figured I should include them here though. Even if something is half-baked, there might be a place for it. Breaks up the platforming too.",
			},
		],
	},
	Keys.TwoDarkness: {
		"start": [
			{
				"speaker": "",
				"line": "[Darkness]",
			},
			{
				"speaker": "",
				"line": "I wanted part of one level to be shrouded in darkness, adding to the challenge of platforming.",
			},
			{
				"speaker": "",
				"line": "I think the torch is enough to help the player, making them slow down and really figure out what's around them.",
			},
			{
				"speaker": "",
				"line": "This requires a lot more testing though as you have ensure the environment is designed such that the player doesn't get lost.",
			},
			{
				"speaker": "",
				"line": "Too much darkness can be overwhelming too, hence why I have some lights around to help direct and orient the player.",
			},
			{
				"speaker": "",
				"line": "Still, a complex and run down place like this is not always going to be easy to move through. Such is life.",
			},
		],
	},
	Keys.TwoLiftShafts: {
		"start": [
			{
				"speaker": "",
				"line": "[Think Carefully When Building Levels]",
			},
			{
				"speaker": "",
				"line": "I didn't think far enough ahead when putting together these lift shafts, specifically the doors.",
			},
			{
				"speaker": "",
				"line": "They'd be clipping into the lift bodies if there were any behind them.",
			},
			{
				"speaker": "",
				"line": "Well, you get the idea. At least the lift works.",
			},
		],
	},
	Keys.TwoLiftEasing: {
		"start": [
			{
				"speaker": "",
				"line": "[Lift Details]",
			},
			{
				"speaker": "",
				"line": "If I had the will, I'd make it so the lifts ease into and out of their top speed instead of immediately setting off.",
			},
			{
				"speaker": "",
				"line": "The lift here is fine, but feels a bit unnatural. If I weren't so lazy I'd make the button light change from red to green while running.",
			},
			{
				"speaker": "",
				"line": "Alas, this will have to do.",
			},
			{
				"speaker": "",
				"line": "As an aside, I think a large diagonal freight lift would be really cool to make.",
			},
		],
	},
	Keys.ThreeCathedral: {
		"start": [
			{
				"speaker": "",
				"line": "[Cathedral]",
			},
			{
				"speaker": "",
				"line": "I always wanted to end the game in a big space, something like a cathedral. The few I've been to IRL have always been quite impressive.",
			},
			{
				"speaker": "",
				"line": "For some reason I spent about 5 hours actually modelling one off the top of my head.",
			},
			{
				"speaker": "",
				"line": "I knew there needed to be a big hall, some kind of spires and an upper balcony. Also big round windows.",
			},
			{
				"speaker": "",
				"line": "I would have added pews or some other details, but I kinda wanted to keep things on the simple side. There's enough geometry as it is.",
			},
			{
				"speaker": "",
				"line": "It's also a bit too big in my opinion, but at least you can appreciate how the reverb system works by moving around it.",
			},
		],
	},
	Keys.GeneralTorch: {
		"start": [
			{
				"speaker": "",
				"line": "[Torch]",
			},
			{
				"speaker": "",
				"line": "The torch is fairly rudimentary, but I was able to add a few effects to make it feel more realistic, which is to say old and unreliable.",
			},
			{
				"speaker": "",
				"line": "It's constantly flickering which becomes more intense when you have a hard landing. It's not just the camera getting shaken around when you do so.",
			},
			{
				"speaker": "",
				"line": "If I did somehow make this tech demo into a full game, I'd want to play around with it more.",
			},
			{
				"speaker": "",
				"line": "Maybe it goes out sometimes on its own, maybe it needs batteries or needs a dynamo wound, meaning you get less light with less charge.",
			},
			{
				"speaker": "",
				"line": "It's interesting thinking of what constraints can be applied to the player and how they could be used to heighten tension.",
			},
		],
	},
	Keys.GeneralOriginalIntention: {
		"start": [
			{
				"speaker": "",
				"line": "[Original Intentions]",
			},
			{
				"speaker": "",
				"line": "I originally set out to make an improved first person controller using what I had learned from making an interactive 3D diorama.",
			},
			{
				"speaker": "",
				"line": "One of the first improvements I wanted was footsteps as the player walked, but I wasn't satisfied with how dry they sounded as they moved around an environment.",
			},
			{
				"speaker": "",
				"line": "I wanted something like Half Life 2 where sounds would change depending on the size, shape and material of their surroundings.",
			},
			{
				"speaker": "",
				"line": "This set me off down a rabbit hole researching how reverb works and what settings reflect different environments.",
			},
			{
				"speaker": "",
				"line": "Eventually I came up with a solution involving multiple raycasts projected from the player, about 66 in total.",
			},
			{
				"speaker": "",
				"line": "These check the player's surroundings every 100ms and update the reverb parameters based on the distance a raycast travels, the collision angle and collider material.",
			},
			{
				"speaker": "",
				"line": "Several of the upward raycasts have a greater effect on the system, which is noticeable when you walk out of a building.",
			},
			{
				"speaker": "",
				"line": "Everything will sound a lot drier when you do. It might not be totally realistic, but I think it sounds good enough.",
			},
			{
				"speaker": "",
				"line": "In terms of materials, the main thing accounted for is reflectiveness. Concrete is very reflective while sand isn't.",
			},
			{
				"speaker": "",
				"line": "Concrete, dull metal and hollow metal are the main materials in these levels. There's sand and cloth too, but I never found a place for them.",
			},
			{
				"speaker": "",
				"line": "I feel like the system works better with harder environments like a megastructure though, so I'm not particularly bothered. I'm impressed the system works at all.",
			},
			{
				"speaker": "",
				"line": "Going back to the game as a whole, I ended up implementing a bunch of other mechanics out of shear curiousity. It's fun to reverse-engineer things.",
			},
			{
				"speaker": "",
				"line": "This led to thoughts of maybe turning what I had into a proper game, so I started experimenting with level ideas.",
			},
			{
				"speaker": "",
				"line": "Little did I know how time-consuming level design, white-boxing and modelling would be for something serious. That diorama I made before took 3 weeks for one level.",
			},
			{
				"speaker": "",
				"line": "It took me far longer than necessary to figure out how to texture models properly too.",
			},
			{
				"speaker": "",
				"line": "Ensure mesh scale is reset to 1 all around for uniform UVs, then apply triplanar materials in Godot. This way you don't have to manually texture everything.",
			},
			{
				"speaker": "",
				"line": "I eventually abandoned it at one point, partially from a lack of direction, but also from other people's opinions.",
			},
			{
				"speaker": "",
				"line": "I figured I'd share progress updates for fun, but it led to a lot of friction. Feedback is important for a proper game, but was that really my goal?",
			},
			{
				"speaker": "",
				"line": "This feedback only served to confuse me more about my intentions. Initially it was just something I put together for my own interest.",
			},
			{
				"speaker": "",
				"line": "I eventually revived it after a particularly busy period at work kept me from any personal project. I needed my own thing to work on again.",
			},
			{
				"speaker": "",
				"line": "I cleared out a lot of old models and refactored the FPS controller and reverb system. Once it was tidied up, I figured I should do something with it.",
			},
			{
				"speaker": "",
				"line": "Many levels and ideas were designed, built and scrapped. Eventually I settled on creating 2-3 levels as a tidy package to demonstrate the mechanics.",
			},
			{
				"speaker": "",
				"line": "Programming the various systems and mechanics was much more fun than level design, so I think I'll proceed with that in mind. Not everything needs to be complete.",
			},
			{
				"speaker": "",
				"line": "A solid deadline and a little accountability helped me get through this project. There is a sense of accomplishment in having reached this point.",
			},
			{
				"speaker": "",
				"line": "There's more I could do with this framework I've put together for myself, but it'll be for my personal amusement above all.",
			},
			{
				"speaker": "",
				"line": "At least now I know I'm capable now of making 3D games. I know how to use Blender and Godot well enough after both being very intimidating in the beginning.",
			},
			{
				"speaker": "",
				"line": "My understanding of object-oriented and modular programming has improved too. It's liberating when you have a deeper understanding of your tools.",
			},
		],
	},
	Keys.GeneralMechanics: {
		"start": [
			{
				"speaker": "",
				"line": "[Mechanics]",
			},
			{
				"speaker": "",
				"line": "I ended up adding a bunch of other mechanics and details based on games I was playing at the time.",
			},
			{
				"speaker": "",
				"line": "The side-to-side head movement, FOV change on sprint and death/checkpoint/respawn system was from Lorn's Lure.",
			},
			{
				"speaker": "",
				"line": "Though, unlike that game and many others, I made it so that you can only sprint while moving forward.",
			},
			{
				"speaker": "",
				"line": "The player can crouch jump which isn't ever made use of, but is a nice vestige from the source-inspired FPS controller tutorial that I followed to build this.",
			},
			{
				"speaker": "",
				"line": "The FPS controller has been heavily modified since and is now quite different. It also has full controller support, though I'm still unsure of the button mapping.",
			},
			{
				"speaker": "",
				"line": "One of the biggest differences is using the right analogue stick to look around when using a controller.",
			},
			{
				"speaker": "",
				"line": "The tutorial solution felt really odd - luckily I was able to improve upon it and learn something about joystick magnitude along the way.",
			},
		],
	},
	Keys.GeneralMovement: {
		"start": [
			{
				"speaker": "",
				"line": "[Movement]",
			},
			{
				"speaker": "",
				"line": "I have yet to test it with many others, but I think the movement feels alright.",
			},
			{
				"speaker": "",
				"line": "Changes I made from the original tutorial for this FPS controller included inertia, so you accelerate to full speed and decelerate to slow down.",
			},
			{
				"speaker": "",
				"line": "When you jump, there is diminishing air control, so you have to commit the longer you are in the air.",
			},
			{
				"speaker": "",
				"line": "It all works pretty well with controller too. You may notice that moving the left analogue stick partially will not just move you slower, but slows down the footsteps too.",
			},
			{
				"speaker": "",
				"line": "There's coyote time, so you have 10 frames after walking off a ledge to still jump. Little things like that are important to me, even if I'm not out to make a full game.",
			},
			{
				"speaker": "",
				"line": "Finally, when refactoring the code in October 2025, I improved how the FPS controller interacts with slopes.",
			},
			{
				"speaker": "",
				"line": "Before, hitting too steep an angle would cause the player to immediately stop. The footstep system would constantly trigger too and it felt pretty bad.",
			},
			{
				"speaker": "",
				"line": "It took some trial and error, but now the player can move onto slopes that are too steep with the system preserving forward momentum before making them slide back down.",
			},
			{
				"speaker": "",
				"line": "It might not sound like much, but it was something that really bothered me with the old version. It was worth coming back just to fix that issue.",
			},
		],
	},
	Keys.ThreeTestLevel: {
		"start": [
			{
				"speaker": "",
				"line": "[Test Level]",
			},
			{
				"speaker": "",
				"line": "If you jump through this window (you'll need to sprint and ledge-grab), you can reach the original test level for this tech demo.",
			},
			{
				"speaker": "",
				"line": "It's a mess, not the most organised space for testing stuff.",
			},
		],
	},
	Keys.GeneralNoClip: {
		"start": [
			{
				"speaker": "",
				"line": "[No Clip]",
			},
			{
				"speaker": "",
				"line": "You can press the N key to noclip. WASD for movement, scroll the mouse wheel to speed up or slow down, jump to move up and crouch to move down.",
			},
		],
	},
	Keys.GeneralInfluences: {
		"start": [
			{
				"speaker": "",
				"line": "[Influences]",
			},
			{
				"speaker": "",
				"line": "There were many pieces of media I took inspiration from for this half-baked tech demo.",
			},
			{
				"speaker": "",
				"line": "The biggest is probably Blame!, a manga by Tsutomu Nihei. I'm not sure how you could talk about megastructures without it.",
			},
			{
				"speaker": "",
				"line": "In it, the MC spends literally thousands of years wandering a megastructure that has apparently consumed over half the solar system.",
			},
			{
				"speaker": "",
				"line": "It can be hard to follow, but the visuals are frequently awe-inspiring.",
			},
			{
				"speaker": "",
				"line": "Next is Lorn's Lure, which was a big inspiration for the movement and mechanics, though there's no climbing, wall-jumping or grappling here.",
			},
			{
				"speaker": "",
				"line": "It was frustrating to play at times, since the developer doesn't always make it clear through level design where you need to go.",
			},
			{
				"speaker": "",
				"line": "But in a way, this makes the megastructure feel more real. Such a complex environment wasn't built for easy traversal. You have to work to get around.",
			},
			{
				"speaker": "",
				"line": "The levels are quite large too, and you descend over several. I don't think any other game has made me feel lost in something so big before, it's really something.",
			},
			{
				"speaker": "",
				"line": "I never finished the last level (if you play yourself you might see why), but it was worth it all the same.",
			},
			{
				"speaker": "",
				"line": "Also, the developer's approach to texturing is really rough, but somehow it works. That in itself was inspiring.",
			},
			{
				"speaker": "",
				"line": "Doll's Nest was another game I spent time playing in Autumn/Winter of 2025. As an android, you fight through a megastructure seeking artifacts of the progenitor.",
			},
			{
				"speaker": "",
				"line": "It plays like older Armored Core games and, while unbalanced and a bit repetitive, its environment design is solid. I took over 200 screenshots as reference.",
			},
			{
				"speaker": "",
				"line": "I really should have spent time copying more from it for practice. The second level demonstrates the clearest similarities.",
			},
			{
				"speaker": "",
				"line": "I have other sources of inspiration too, such as photos of abandoned bunkers, apartment blocks and nuclear reactors, not to mention other games.",
			},
			{
				"speaker": "",
				"line": "Ultimately, there's no lack of ideas with this premise. One could spend a very long time designing and building these kinds of environments.",
			},
			{
				"speaker": "",
				"line": "Unfortunately, I tend to get bored doing the same thing over and over. I'm glad I managed to get something built at all.",
			},
		],
	},
	Keys.GeneralTextures: {
		"start": [
			{
				"speaker": "",
				"line": "[Textures]",
			},
			{
				"speaker": "",
				"line": "I'm reasonably happy with the textures I found and how they've been applied to models.",
			},
			{
				"speaker": "",
				"line": "Everything feels fairly consistent to me. Were I to go further, I would improve the variety and introduce some colour.",
			},
			{
				"speaker": "",
				"line": "This tech demo is very monochromatic, which perhaps is fitting of an artificial world, but it can get dull after a while.",
			},
		],
	},
	Keys.GeneralThreeEnvironment: {
		"start": [
			{
				"speaker": "",
				"line": "[Third Level Environment]",
			},
			{
				"speaker": "",
				"line": "As a level, this one is a bit of a mixed bag. I wanted to make the player ledge-grab stuff, hence all the blocks at the start.",
			},
			{
				"speaker": "",
				"line": "The surrounding environment was initially more complex and open, but it was pretty messy and full of triangles, so here's a box instead.",
			},
			{
				"speaker": "",
				"line": "At least it's more performant. And the lighting inside the cathedral is pretty nice.",
			},
		],
	},
	Keys.GeneralBranchingDialogue: {
		"start": [
			{
				"speaker": "",
				"line": "Did you know this dialogue system supports branching and looping?",
			},
			{
				"speaker": "",
				"line": "While I never got around to revealing lines letter by letter (I've done that in other projects), I wanted to solve this problem.",
			},
			{
				"speaker": "",
				"line": "Ideally the data structure used for the dialogue, choices and branching paths would be built with a dedicated program.",
			},
			{
				"speaker": "",
				"line": "I might still build it as a web app for practicing my Vue.js skills.",
			},
			{
				"speaker": "",
				"line": "Anyway, here is a simple demonstration.",
				"branch": "Question"
			},
		],
		"Question": [
			{
				"speaker": "",
				"line": "What do you want to know?",
				"choices": [
					{
						"text": "About this cathedral...",
						"branch": "A"
					},
					{
						"text": "Where did all this material come from?",
						"branch": "B"
					},
					{
						"text": "I'm good",
						"branch": "End",
					},
				]
			},
		],
		"A": [
			{
				"speaker": "",
				"line": "Strange isn't it? No idea who built it or why.",
			},
			{
				"speaker": "",
				"line": "Have you noticed the spires are made of metal?",
				"branch": "Question"
			},
		],
		"B": [
			{
				"speaker": "",
				"line": "I hear it's all made by turning energy into matter.",
			},
			{
				"speaker": "",
				"line": "Something to do with gravity furnaces apparently, though I've never seen one.",
			},
			{
				"speaker": "",
				"line": "Ever wondered what it's like near one?",
				"choices": [
					{
						"text": "That sounds dangerous",
						"branch": "C"
					},
					{
						"text": "Sounds like a fun time",
						"branch": "D"
					}
				]
			},
		],
		"C": [
			{
				"speaker": "",
				"line": "Probably best to stay well away from things you don't understand.",
				"branch": "Question"
			},
		],
		"D": [
			{
				"speaker": "",
				"line": "I hear the flow of time and space get rather convoluted near them, be careful if you ever find one.",
				"branch": "Question"
			},
		],
		"End": [
			{
				"speaker": "",
				"line": "I hope you found this mildly interesting."
			},
		]
	},
}


static func get_dialogue_lines(key: Keys) -> Dictionary:
	return lines[key]
