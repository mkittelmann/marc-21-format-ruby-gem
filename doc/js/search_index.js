var search_data = {"index":{"searchIndex":["falcon","marc21format","marclocgov","marser","testmarc21format","crawl()","each()","find()","generate_validation_params()","get()","get_defined_indicators()","get_indicator()","get_indicator_values()","get_indicators()","get_subfield()","get_subfield_values()","get_subfields()","get_tag()","get_tags_with_indicators()","get_tags_without_indicators()","get_undefined_indicators()","indicatorize()","new()","new()","new()","setup()","subfield_repeatable?()","subfield_repeatable_non_existant()","test_find()","test_get_defined_indicators()","test_get_indicators()","test_get_indicators_if_no_indicators()","test_get_single_indicator()","test_get_single_subfield_that_does_not_exist()","test_get_single_subfield_that_exist()","test_get_subfields()","test_get_subfields_if_no_subfields()","test_get_tags_with_indicators()","test_get_tags_without_indicators()","test_get_undefined_indicators()","test_load_format_from_file()","test_load_format_live_from_web()","test_subfield_repeatable_false()","test_subfield_repeatable_true()","validate()","validate_indicators()","validate_subfields()","gemfile","rakefile","marc-21-format.gemspec","readme","marc21.json","marc21","marc21_live.val","tmp_for.comparison"],"longSearchIndex":["falcon","marc21format","marclocgov","marser","testmarc21format","marclocgov#crawl()","marc21format#each()","marc21format#find()","falcon#generate_validation_params()","marc21format#get()","marc21format#get_defined_indicators()","marc21format#get_indicator()","marc21format#get_indicator_values()","marc21format#get_indicators()","marc21format#get_subfield()","marc21format#get_subfield_values()","marc21format#get_subfields()","marc21format#get_tag()","marc21format#get_tags_with_indicators()","marc21format#get_tags_without_indicators()","marc21format#get_undefined_indicators()","falcon#indicatorize()","falcon::new()","marc21format::new()","marser::new()","testmarc21format#setup()","marc21format#subfield_repeatable?()","testmarc21format#subfield_repeatable_non_existant()","testmarc21format#test_find()","testmarc21format#test_get_defined_indicators()","testmarc21format#test_get_indicators()","testmarc21format#test_get_indicators_if_no_indicators()","testmarc21format#test_get_single_indicator()","testmarc21format#test_get_single_subfield_that_does_not_exist()","testmarc21format#test_get_single_subfield_that_exist()","testmarc21format#test_get_subfields()","testmarc21format#test_get_subfields_if_no_subfields()","testmarc21format#test_get_tags_with_indicators()","testmarc21format#test_get_tags_without_indicators()","testmarc21format#test_get_undefined_indicators()","testmarc21format#test_load_format_from_file()","testmarc21format#test_load_format_live_from_web()","testmarc21format#test_subfield_repeatable_false()","testmarc21format#test_subfield_repeatable_true()","falcon#validate()","falcon#validate_indicators()","falcon#validate_subfields()","","","","","","","",""],"info":[["Falcon","","Falcon.html","","<p>&#39;#010 “Library of Congress Control Number” #I_ #J_\n#Sa:12:&lt;b.z.8.&gt; ;&#39;\n"],["MARC21Format","","MARC21Format.html","","<p>Access the MARC21 format documentation\nwww.loc.gov/marc/bibliographic/ecbdlist.html\n<p>Simplifies the creation …\n"],["MARCLOCGOV","","MARCLOCGOV.html","",""],["Marser","","Marser.html","",""],["TestMARC21Format","","TestMARC21Format.html","",""],["crawl","MARCLOCGOV","MARCLOCGOV.html#method-i-crawl","()",""],["each","MARC21Format","MARC21Format.html#method-i-each","()",""],["find","MARC21Format","MARC21Format.html#method-i-find","( str )",""],["generate_validation_params","Falcon","Falcon.html#method-i-generate_validation_params","()",""],["get","MARC21Format","MARC21Format.html#method-i-get","( syntax )",""],["get_defined_indicators","MARC21Format","MARC21Format.html#method-i-get_defined_indicators","()","<p>Returns a hash with all tags and only their defined indicator positions.\n"],["get_indicator","MARC21Format","MARC21Format.html#method-i-get_indicator","( tag_and_indicator )","<p>Example return format:\n\n<pre class=\"ruby\"><span class=\"ruby-string\">&quot;4 - HTTP&quot;</span>\n</pre>\n"],["get_indicator_values","MARC21Format","MARC21Format.html#method-i-get_indicator_values","()",""],["get_indicators","MARC21Format","MARC21Format.html#method-i-get_indicators","( tag )",""],["get_subfield","MARC21Format","MARC21Format.html#method-i-get_subfield","( tag_and_subfield )","<p>Example return format:\n\n<pre class=\"ruby\"><span class=\"ruby-string\">&quot;$b - Access number (R)&quot;</span>\n</pre>\n"],["get_subfield_values","MARC21Format","MARC21Format.html#method-i-get_subfield_values","()",""],["get_subfields","MARC21Format","MARC21Format.html#method-i-get_subfields","( tag )","<p>Returns all subfields of a certain tag.\n<p>Example return format:\n\n<pre>{&quot;856 - ELECTRONIC LOCATION AND ACCESS (R)&quot;=&gt; ...</pre>\n"],["get_tag","MARC21Format","MARC21Format.html#method-i-get_tag","( tag )","<p>Example return format:\n\n<pre>{&quot;856 - ELECTRONIC LOCATION AND ACCESS (R)&quot;=&gt;\n{&quot;First - Access method&quot;=&gt;\n [&quot;# - ...</pre>\n"],["get_tags_with_indicators","MARC21Format","MARC21Format.html#method-i-get_tags_with_indicators","()","<p>Example return:\n\n<pre>&quot;856 - ELECTRONIC LOCATION AND ACCESS (R)&quot;=&gt;\n{&quot;First - Access method&quot;=&gt;\n [&quot;# - No information ...</pre>\n"],["get_tags_without_indicators","MARC21Format","MARC21Format.html#method-i-get_tags_without_indicators","()","<p>Returns a hash with all tags that do not have any indicators.\n"],["get_undefined_indicators","MARC21Format","MARC21Format.html#method-i-get_undefined_indicators","()","<p>Returns a hash with all tags concerned and their undefined indicator\npositions.\n<p>Example return format …\n"],["indicatorize","Falcon","Falcon.html#method-i-indicatorize","( line )",""],["new","Falcon","Falcon.html#method-c-new","()",""],["new","MARC21Format","MARC21Format.html#method-c-new","( file = '' )",""],["new","Marser","Marser.html#method-c-new","( file = '' )",""],["setup","TestMARC21Format","TestMARC21Format.html#method-i-setup","()",""],["subfield_repeatable?","MARC21Format","MARC21Format.html#method-i-subfield_repeatable-3F","( tag_and_subfield )","<p>Returns\n<p><code>true</code> if subfield is repeatable\n<p><code>false</code> if subfield ist not repeatable\n"],["subfield_repeatable_non_existant","TestMARC21Format","TestMARC21Format.html#method-i-subfield_repeatable_non_existant","()",""],["test_find","TestMARC21Format","TestMARC21Format.html#method-i-test_find","()",""],["test_get_defined_indicators","TestMARC21Format","TestMARC21Format.html#method-i-test_get_defined_indicators","()",""],["test_get_indicators","TestMARC21Format","TestMARC21Format.html#method-i-test_get_indicators","()",""],["test_get_indicators_if_no_indicators","TestMARC21Format","TestMARC21Format.html#method-i-test_get_indicators_if_no_indicators","()",""],["test_get_single_indicator","TestMARC21Format","TestMARC21Format.html#method-i-test_get_single_indicator","()",""],["test_get_single_subfield_that_does_not_exist","TestMARC21Format","TestMARC21Format.html#method-i-test_get_single_subfield_that_does_not_exist","()",""],["test_get_single_subfield_that_exist","TestMARC21Format","TestMARC21Format.html#method-i-test_get_single_subfield_that_exist","()",""],["test_get_subfields","TestMARC21Format","TestMARC21Format.html#method-i-test_get_subfields","()",""],["test_get_subfields_if_no_subfields","TestMARC21Format","TestMARC21Format.html#method-i-test_get_subfields_if_no_subfields","()",""],["test_get_tags_with_indicators","TestMARC21Format","TestMARC21Format.html#method-i-test_get_tags_with_indicators","()",""],["test_get_tags_without_indicators","TestMARC21Format","TestMARC21Format.html#method-i-test_get_tags_without_indicators","()",""],["test_get_undefined_indicators","TestMARC21Format","TestMARC21Format.html#method-i-test_get_undefined_indicators","()",""],["test_load_format_from_file","TestMARC21Format","TestMARC21Format.html#method-i-test_load_format_from_file","()",""],["test_load_format_live_from_web","TestMARC21Format","TestMARC21Format.html#method-i-test_load_format_live_from_web","()",""],["test_subfield_repeatable_false","TestMARC21Format","TestMARC21Format.html#method-i-test_subfield_repeatable_false","()",""],["test_subfield_repeatable_true","TestMARC21Format","TestMARC21Format.html#method-i-test_subfield_repeatable_true","()",""],["validate","Falcon","Falcon.html#method-i-validate","( tag, description )",""],["validate_indicators","Falcon","Falcon.html#method-i-validate_indicators","( tag )",""],["validate_subfields","Falcon","Falcon.html#method-i-validate_subfields","( tag )",""],["Gemfile","","Gemfile.html","","<p>source “rubygems.org” ruby “1.9.3” gem “nokogiri”, “&gt;= 1.6.7.2 …\n"],["Rakefile","","Rakefile.html","","<p>require &#39;rake/testtask&#39;\n<p>Rake::TestTask.new do |t|\n\n<pre class=\"ruby\"><span class=\"ruby-identifier\">t</span>.<span class=\"ruby-identifier\">libs</span> <span class=\"ruby-operator\">&lt;&lt;</span> <span class=\"ruby-string\">&#39;test&#39;</span>\n</pre>\n"],["marc-21-format.gemspec","","marc-21-format_gemspec.html","","<p>Gem::Specification.new do |s|\n\n<pre>s.name        = &#39;marc-21-format&#39;\ns.version     = &#39;0.0.1&#39;\ns.date        = ...</pre>\n"],["readme","","readme_md.html","","<p>MARC21 Format Parser and CLI tool\n<p>Please note that this gem is in <em>alpha</em> state.\n<p>Try it (install as a local …\n"],["marc21.json","","test/documentation/marc21_json.html","","<p>{\n\n<pre>&quot;LEADER&quot; =&gt; {\n        &quot;Character Positions&quot; =&gt;\n        [&quot;00-02 - Tag&quot;,\n                &quot;03-06 - Field ...</pre>\n"],["marc21","","test/documentation/marc21_txt.html","","<p>LEADER\n\n<pre>  Character Positions\n  00-04 - Logical record length\n  05 - Record status\n      a - Increase in ...</pre>\n"],["marc21_live.val","","test/examples/marc21_live_val.html","","<p>000 “Leader” ; 001 “Control Number (Nr)” ; 003 “Control Number Identifier\n(Nr)” …\n"],["tmp_for.comparison","","test/examples/tmp_for_comparison_txt.html","","<p>!000:28: “Leader” ;  !001 “Control Number” ; #003 “Control Number\nIdentifier” …\n"]]}}