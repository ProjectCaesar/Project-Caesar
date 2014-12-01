require 'open-uri'
list = open('http://caeserwiki.comule.com/list.js')
listcontent = list.read

while true
  list = open('http://caeserwiki.comule.com/list.js')
  listcontent = list.read
  # open and write to a file with ruby
  text = open("list.js")
  if listcontent != text.read
	open('list.js', 'w') { |f|
  	f.puts listcontent
	}
  end
  listp = listcontent.split("\n")
  cont = "var list = []; ";
  for x in listp
	if File.exist?('database/'+(x.gsub("https://en.wikipedia.org/wiki/", "").downcase).gsub(" ", "_")+".html")
		file = open('http://caeserwiki.comule.com/database/'+(x.gsub("https://en.wikipedia.org/wiki/", "").downcase).gsub(" ", "_")+".html")
		content = file.read
		text2 = open("database/"+(x.gsub("https://en.wikipedia.org/wiki/", "").downcase).gsub(" ", "_")+".html")
		if content != text2.read
			open("database/"+(x.gsub("https://en.wikipedia.org/wiki/", "").downcase).gsub(" ", "_")+".html", 'w') { |f|
  			f.puts content
			}
  		end	
	else
		File.open("database/"+(x.gsub("https://en.wikipedia.org/wiki/", "").downcase).gsub(" ", "_")+".html", "w+") { |file| file.write("") }
	end
	set = open("database/"+(x.gsub("https://en.wikipedia.org/wiki/", "").downcase).gsub(" ", "_")+".html")
	setcontent = ""+set.read.gsub("<!-- Hosting24 Analytics Code -->", "").gsub("<script type=\"text/javascript\" src=\"http://stats.hosting24.com/count.php\"></script>", "").gsub("<!-- End Of Analytics Code -->", "")
	o = setcontent.strip 
	cont += "list.push([\""+x+"\",\""+o.gsub("\"","\\\"")+"\"]);"
  end
	cont += "var s = 0;\nfunction check2darray(str,list){for(i=0; i <= list.length-1; i++){if(list[i][0] == str){s = i; return true;}}return false;}\nif(check2darray(window.location.href,list)){$(\"body\").append(\"<div style='background-color: #FFF; position:fixed; left:0px; top:0px; padding:5px; border-bottom-right-radius:10px; border: solid 1px #CFCFCF;'><img style='float:left; width: 32px; height: 32px;' src='https://dl.dropboxusercontent.com/s/lo7brmze4yhpleb/pizza.png'/><span style='margin-top: 7px; margin-left:2px; float:left;'>This Wiki article has been marked by Project Caesar as being biased.</span></div><div style='position: absolute; bottom:0px; left:0px;'></div>\");$(\"#ca-view\").after(\"<li id='ca-edit'><span><a href='http://caeserwiki.comule.com/wiki.php?url=\"+list[s][0]+\"' title='You can edit this page. Please use the preview button before saving [alt-shift-e]' accesskey='e'>Edit /w PC</a></span></li>\"); $( \"#References\" ).prepend( list[s][1]);}"
	  textn = open("replace2.js")
  	if cont != textn.read
		open('replace2.js', 'w') { |f|
  		f.puts cont
	}
  end
   sleep 60
end
