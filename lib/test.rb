 require 'pp'
syntax = '245i1'
tag, indicator = syntax.split( /\s*i/ )
indicator = indicator.sub( '1', 'First' ).sub( '2', 'Second' )
# pp indicator
tag = {"245 - TITLE STATEMENT (NR)"=>
  {"First - Title added entry"=>["0 - No added entry", "1 - Added entry"],
   "Second - Nonfiling characters"=>["0-9 - Number of nonfiling characters"]}}
 pp tag.select { |k,v| { k => v } if v.delete_if { |kk,vv| vv if !kk.match( /#{indicator}/ ) } }