# Core-ML-TuriCreate
Creating a natural language processing model  to analyze the sentiment of news headlines on iOS with Turi Create. Training a Core ML model from scratch, then using that model within an iOS Application. 

## Getting Started 

-> Run the following command in Terminal to check if Python is installed: 

python -V 

-> Run the following command to check if pip is installed: 

which pip

-> Run the following commend to install a virtualenv: 

sudo pip install virtualenv

## Installing Turi Create 

-> Open a Terminal window and navigate to the dataset model directory using the command cd. 

-> From the directory enter the following command to create a new virtual environment named venv:
	virtualenv venv

-> Activate the environment using the following command:
	source venv/bin/activate

-> Install Turi Create: 
	pip install -U turicreate 

## Using Turi Create to train a model 

-> In the new Terminal with the virtual environment active launch Python in the same directory as the dataset, using the following command: 
	python

-> Run the following command: 
	import turicreate as tc 

-> Load the dataset JSON data (+ 3000 samples) data : 
	tc.SFrame.read_json(‘news_database.json’, orient=‘records’)

-> Type the following command to show the size and data types contained within the newly created SFrame:
	data

-> Create the model by running: 
	model = tc.text_classifier.create(data, ‘label’, features=[‘text’])

-> Re-run the command util you are satisfy with the model accuracy 

-> Export the model in the Core ML format: 
	model.export_coreml(‘TextClassifier.mlmodel’)

## Using Core ML 

-> Import the pre-trained model in your app project by dragging the TextClassifier.mlmodel into the project navigator 
-> Write the NSLinguisticTagger function to transform the text into a dictionary word counts: 

	func wordCounts(text: String) -> [String: Double] {
	
	var bagOfWords: [String: Double] = [:]

	let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)

	let range = NSRange(text.startIndex…, in: text)

	let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]

	tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { _, tokenRange, _ in 
	let word = (text as NSString).substring(with: tokenRange)
	bagOfWords[word, default: 0] += 1
		}
	}

-> Using the model through the following function: 
	func analyze(text: String) {
		let counts = wordCounts(text: text)

		let model = TextClassifier()

		do {
			let prediction = try model.prediction(text: counts)

			print(“\(prediction.labelProbability) \(prediction.label)”)
		} catch {
			print(error)
		}
	}

