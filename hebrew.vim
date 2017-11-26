"save the cursor
normal mz
"we also need to strip all \he's that are already there.
silent! %s/\\he{\(\_.\{-}\)}/\1/g
"start at beggining of a word, then look for hebrew letters, and
"punctuation that appears in said letters
silent! %s/\(^\|[^\\]\)\zs\<[א-ת][א-ת:'~"\n[:space:]]\{-1,}'\=:\=\ze\(\_s\|[[:punct:]]\)\+\(\w\|\%$\)/\\he{\0}/g

silent! %s/\(^\|[^\\]\)\zs\<[א-ת][א-ת:'~"\n[:space:]]\{-1,}'\=:\=\ze\(\_s\|[[:punct:]]\)\+\\he{/\\he{\0}/g
while 1
  "this is where we loop, catching list pieces, until we're done
  "we didn't use this for the second part b/c there we also need
  "to catch periods between hebrew.
  "TODO- we need to consider a case where a sentence ends, and
  "then is followed by a hebrew word and a more hebrew in parentheses.
  try
silent %s/\(^\|[^\\]\)\zs\<[א-ת][א-ת'~"\n[:space:]]\{-1,}\ze,/\\he{\0}/g
catch 
  break
endtry
endwhile
"TODO- looking for a more robust solution that compares the
"original amount with the new amount
let colons= "[א-ת]:}"
if search(colons, 'wn')
  echo "---------------------------------------------------"
  echo "Colon detected. Please check out if this is correct."
  echo "They may be cycled through with n and N, as usual"
  let @/ = colons
endif

"put the cursor back where it was
silent! normal `z
