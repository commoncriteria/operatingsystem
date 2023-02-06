var system = require('system');
var page = require('webpage').create();

page.open(system.args[1], function()
{
	console.log(page.content);
	phantom.exit();
});
