// JavaScript Document
//<script type="text/javascript" src="http://www.google.com/jsapi">

window.onload = function()
{
	doSearch();
}
google.load("prototype", "1.6.0.3");
google.load("search", "1");
var searcher;

function processSearchResults()
{
  var results = searcher.results;
  for (var i=0; i<results.length; i++)
  {
    var tablenode =new Element('table', { className:'news_result_item'});	
	var trnode = new Element('tr');
	var subtd1 =new Element('td', { className:'news_date_item', 'valign':'top', 'style':'width:60px; padding-bottom:5px;'});
	var subtd2 =new Element('td', { className:'news_result_item', 'valign':'top', 'style':'padding-left:2px; padding-bottom:5px;' });
	trnode.appendChild(subtd1);
	trnode.appendChild(subtd2);
	tablenode.appendChild(trnode);
	
	var dt = new Date(unescape(results[i].publishedDate));
	subtd1.appendChild(new Element('div', { 'class': 'news_date_item', 'style':'float:left;padding-right:5px;'}).update(dt.getMonth()+1 + "/" + dt.getDate() + "/" + dt.getFullYear()));
    subtd2.appendChild(new Element('a', { 'class': 'news_result_item', 'style':'text-decoration:none;color:#000000;', 'target':'_blank', href: unescape(results[i].url) }).update( unescape(results[i].titleNoFormatting)));
    
    $('results_div').appendChild(tablenode);
  }
}



