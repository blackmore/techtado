// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function clearText(thefield){
 if (thefield.defaultValue== ' search')
 thefield.value = ""
 thefield.style.color = "#333";

 if (thefield.defaultValue != ' search')
 thefield.style.color = "#333";
}