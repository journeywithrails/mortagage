// JavaScript Document
//<script type="text/javascript" src="http://www.google.com/jsapi">

window.onload = function()
{
	doSearch();
}
google.load("prototype", "1.6.0.3");
google.load("search", "1");
var searcher;

function date_digit_convert(date_value)
{
return 	date_value > 9 ? date_value : '0'+date_value;
}


function processSearchResults()
{ 

  var results = searcher.results;

  for (var i=0; i<results.length; i++)
  {
	 
   <!------------------------------ news   ----------------------------------------->
    if(i%2==0) 
	{
		var trnode =new Element('tr',{'class':'Row01'});
	}
	else
	{
		var trnode =new Element('tr',{'class':'Row02'});
	}	
	var subtd1 =new Element('td', { 'valign':'top', 'style':'width:84px;'});
	var subtd2 =new Element('td', { 'style':'width:10px;'});
	var subtd3 =new Element('td', { 'valign':'top', 'style':'!width:203px;' });
	var subtd4 =new Element('td', { 'style':'width:10px;'});
	var subtd5 =new Element('td', { 'valign':'top', 'style':'width:160px;' });
	var subtd6 =new Element('td', { 'style':'width:10px;'});
	var subtd7 =new Element('td', { 'valign':'top', 'style':'width:77px;' });
	
	
	trnode.appendChild(subtd1);
	trnode.appendChild(subtd2);
	trnode.appendChild(subtd3);
	trnode.appendChild(subtd4);
	trnode.appendChild(subtd5);
	trnode.appendChild(subtd6);
	trnode.appendChild(subtd7);
	

	
	var dt = new Date(unescape(results[i].publishedDate));
	
	subtd1.appendChild(new Element('a', { 'class': 'Link01', 'valign':'middle', 'target':'_blank', href: unescape(results[i].url)}).update( 'News'));
	subtd3.appendChild(new Element('span', {'valign':'middle','style':'color:#948B54;'}).update(unescape(results[i].titleNoFormatting)));
	subtd5.appendChild(new Element('span', {'style':'color:#000000'}).update('Sun Microsystems Group'));
	subtd7.appendChild(new Element('span', {'style':'color:#948B54;'}).update(date_digit_convert(dt.getMonth()+1) + "/" + date_digit_convert(dt.getDate()) + "/" + dt.getFullYear()));	
	
  
   $('results_div').appendChild(trnode);
   
   
  }
   
}



