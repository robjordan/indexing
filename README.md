# indexing
Tools for my new hobby of indexing books (work in progress)

Here's the rough workflow I use.

Extract the source document (from Word or whatever) as a plain text file, one line to a paragraph.

Open the text file in emacs, turn-on wrap-region mode, with this in my .emacs file

```lisp
(wrap-region-mode t)

(wrap-region-add-wrapper "<START:person>" "<END>" "/")
(wrap-region-add-wrapper "<START:location>" "<END>" "@")
(wrap-region-add-wrapper "<START:organization>" "<END>" "~")
```

 Mark indexable terms in the text (dragging the mouse works, even though, mysteriously, in my emacs setup, the marked region isn't highlighted in any way.
 
 Press one of the hot-keys, i.e. '/' for a person, '@' for a place, '~' for an organisation.
 
 The marked-up document should look something like this:
 
 ```text
 <START:location>Machango<END> is a small town where the fields have been the same for generations, where children spend all day playing in the streets, and where nothing changes. <START:location>Maracaibo<END> is a state capital city with a population surpassing one million and is the second largest city in <START:location>Venezuela<END>. <START:location>Zulia<END> is a state, home to both, with a fierce identity and a strong historical past. <START:person>Daniuska Rodríguez<END> was born in <START:location>La Raya Pueblo Nuevo<END>, near <START:location>Machango<END>, on 4 February 1999, so when asked what place name she would like on a t-shirt carrying her name and image, you would perhaps consider it an easy decision. I was born in <START:location>Shirley, Southampton<END>, a city in the English county of <START:location>Hampshire<END>. I always answer ‘<START:location>Southampton<END>’ when I am asked where I am from or where I was born. I would never consider saying <START:location>Shirley<END> or <START:location>Hampshire<END>, especially if I was asked by a foreigner. Yet <START:person>Daniuska<END> was at pains to answer, labouring over the decision.
 ```
 
After completing a session of marking-up (not necessarily the whole document, it helps to do this bit-by-bit), save the edited file (but keep a copy of the unmarked pure text version), then run the `extract-tags.sh` script with input from the tagged file. This will produce an output file something like this:
 
 ```text
 :location>Stratford on Avon
:location>Worcester Cathedral
:organization>Sherborne School
:person>Bellini
:person>Bruckner
:person>Edward Elgar
:person>Elgar
```
Import this, with '>' as column-separator, into the first two columns of a spreadsheet, which has, at minumum, three columns as follows:
* Type	(i.e. person, place or organisation)
* Search string	(the text occuring in the body of the book)
* Index term (the entry as it will occur in the index, e.g. Surname, Firstname)

Fill in the index term column, making sure that variations on the search string map to the same index term, e.g. 'Daniuska' and 'Daniuska Rodriguez' will both map to index term: 'Rodriguez, Daniuska'. The spreadsheet you are compiling will form the basis of the [concordance file](https://www.webucator.com/how-to/how-create-concordance-file-use-automark-microsoft-word.cfm), to be applied to the Microsoft Word document to build the index. Index terms can be hierarchical e.g. "Southampton:Football Club" would list in the index under a main entry of 'Southampton' and a sub-entry of 'Football Club'.

The next step is to inject the completed tags back into the original text file. This saves us having to repeatedly tag common terms. First you need to save the contents of column 1 of the spreadsheet to a plain text file called `markup.txt`. There's a script, `inject-tags.sh` that will create a script `transform.sh`, that in turn will apply tags around all of the captured search strings. Remember, the tags are injected to the original text, not the marked-up version.

One important thing to watch out for. Sometimes a search string appears in two very different contexts. For instance, in the first book I indexed, 'Alexander' almost always referred to Alexander the Great, so I set up an index entry accordingly. However there was one reference to Alexander Stadium in Birmingham, which should definitely have not bee referenced in the index entry for Alexander the Great. Two ways to deal with this:
* Make a note of false matches, and manually remove the index tags from the eventual Microsoft Word document so they don't show up in the index. Messy.
* Make the search strings more specific, so that they only match correct terms in the text. For instance 'Alexander the Great', 'Alexander conquered', 'Alexander was poisoned'. You get the idea. Much better approach.

After iterating around this loop many times you will have tagged the entire book, and collated a concordance spreadsheet with a full set of index entries and search terms. Cut and paste the contents of first and second columns of your spreadsheet to a blank Word document, to create a two column table and save this. Follow one of the [many tutorials](https://www.webucator.com/how-to/how-create-concordance-file-use-automark-microsoft-word.cfm) online to build an index in your Word version of the book text.  

