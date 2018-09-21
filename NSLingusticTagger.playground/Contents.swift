import UIKit


let inputString = "Alongside the slick looking new iPhone trio, Tim Cook and the gang also used last week’s big Cupertino event to take the covers off of the newest smartwatch from the company – the Apple Watch Series 4. With a bigger display, extra health tracking smarts and a revamped OS, it promises to be the best Apple Watch yet. But has it done enough to convince the critics? The early Apple Watch Series 4 reviews are in, here’s a pick of what the tech press are saying about it"

let inputString_kor = "ㅋㅋㅋㅋㅋ"
/*
 Tag Schemes:
 1. tokenType: classifies tokens according to their broad type: word, punctuation, or whitespace.
 2. lexicalClass: classifies tokens according to class: part of speech, type of punctuation, or whitespace.
 3. nameType: classifies tokens according to whether they are part of a named entity.
 4. nameTypeOrLexicalClass: classifies tokens corresponding to names according to nameType, and classifies all other tokens according to lexicalClass.
 5. lemma: supplies a stem form of a word token, if known.
 6. language: supplies the language for a token, if one can be determined.
 7. script: supplies the script for a token, if one can be determined.
 */


let lingusticTagger = NSLinguisticTagger(tagSchemes: [.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
let options: NSLinguisticTagger.Options = [NSLinguisticTagger.Options.omitPunctuation, .omitWhitespace, .joinNames]

func dominantLanguage(text: String) -> String? {
    lingusticTagger.string = text
    return lingusticTagger.dominantLanguage
}



dominantLanguage(text: inputString)
dominantLanguage(text: inputString_kor)

func tokenise(_ text: String) {
    lingusticTagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    lingusticTagger.enumerateTags(in: range, unit: NSLinguisticTaggerUnit.word, scheme: .tokenType, options: options) { (tage, tokenRange, _) in
        let word = (inputString as NSString).substring(with: tokenRange)
    }
}

tokenise(inputString)

// Lemmatisation
func lemmatise(text: String) {
    lingusticTagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    lingusticTagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { (tag, tokenRange, _ ) in
        if let lemma = tag?.rawValue {
            
        }
    }
}


lemmatise(text: "went")
lemmatise(text: "have changed")

func parts(of text: String) -> [[String: String]] {
    lingusticTagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    var words = [[String:String]]()
    lingusticTagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { (tag, tokenRange, _ ) in
        if let tag = tag {
            let word = (inputString as NSString).substring(with: tokenRange)
            words.append([tag.rawValue: word])
        }
    }
    return words
}

let lex = parts(of: inputString)
print("========================lexicalClass============================")
lex.forEach { print($0) }

print("========================namedEntitiy============================")
func namedEntitiy(text: String) -> [[String: String]] {
    lingusticTagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    let tags: [NSLinguisticTag] = [NSLinguisticTag.personalName, .placeName, .organizationName]
    
    var names = [[String: String]]()
    lingusticTagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { (tag, tokenRange, _ ) in
        if let tag = tag, tags.contains(tag) {
            let name = (text as NSString).substring(with: tokenRange)
            names.append([tag.rawValue: name])
        }
    }
    
    return names
}

namedEntitiy(text: inputString).forEach { print($0) }



























