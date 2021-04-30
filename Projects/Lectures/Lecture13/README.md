# Lecture 13: Persistence




## Store Doc in File System


### Make sure file name is unique
If there is already a same name, add incrementing number at the end.



## Get DocumentStore look into File System 


`
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let store = EmojiArtDocumentStore(directory: url)
`


`do {
    let documents = try FileManager.default.contentsOfDirectory(atPath: directory.path)
    for document in documents {
        let emojiArtDocument = EmojiArtDocument(url: directory.appendingPathComponent(document))
        self.documentNames[emojiArtDocument] = document
    }
    } catch {
        print("EmojiArtDocumentStore: couldn't create store from directory \(directory): \(error.localizedDescription)")
}`


## Others

### Add extension for String collection
`extension String
{
        func uniqued<StringCollection>(withRespectTo otherStrings: StringCollection) -> String
            where StringCollection: Collection, StringCollection.Element == String {
            var unique = self
            while otherStrings.contains(unique) {
            unique = unique.incremented
        }
        return unique
}`
