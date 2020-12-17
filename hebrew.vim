"save the cursor
normal mz
"we need to strip all \he's that are already there.
silent! %s/\\he{\(\_.\{-}\)}/\1/g

"TODO- maybe we should start by marking off problematic
"punctuation instead of trying to deal with it later on...


"start at beggining of a word, then look for hebrew letters, and
"punctuation that appears in said letters including curly quotes
silent! %s/\(^\|[^\\]\)\zs\<[א-ת][א-ת:'~"“”\n[:space:]]\{-1,}'\=:\=\ze\(\_s\|[[:punct:]]\)\+\(\w\|\%$\)/\\he{\0}/g

silent! %s/\(^\|[^\\]\)\zs\<[א-ת][א-ת:'~"\n[:space:]]\{-1,}'\=:\=\ze\(\_s\|[[:punct:]]\)\+\\he{/\\he{\0}/g
while 1
  "this is where we loop, catching list pieces, until we're done
  "we didn't use this for the second part b/c there we also need
  "to catch periods between hebrew.
  "TODO- we need to consider a case where a sentence ends, and
  "then is followed by a hebrew word and a more hebrew in parentheses.
  try
%s/\(^\|[^\\]\)\zs\<[א-ת][א-ת'~"\n[:space:]]\{-1,}\ze,/\\he{\0}/g
catch 
  break
endtry
endwhile

"the way this works is that it looks for a non-match with a
"single letter followed by a colon or an alphabetic number in such
"a situation, and double checks that our thing ends in hebrew,
"and then moves the colon outside the brackets
silent! %s/\(\("[א-ת]\)\|\(\<[א-ת]\)\)\@<!\([א-ת]\)\@<=\zs:}/}:/g

"a similar approach for periods checking if it's in the middle of
"a sentence. If the user doesn't capitalize, we can't really help
"them
silent! %s/[א-ת]\zs}\.\(\_s*\([[:punct:]]\{\@<!\|\l\|\r\r\)\)/.}\1/g

"put the cursor back where it was
silent! normal `z
