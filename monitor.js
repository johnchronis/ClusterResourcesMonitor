var express = require('express');
var app = express();
var sys = require('util')
var spawn = require('child_process').spawn;
var child;
var fs = require('fs');
var path = require('path');

var filedir = __dirname;
var filename = "block";
var mylock = "nlock";
var mylockpath = path.join(filedir,mylock);
var filepath= path.join(filedir,filename);


app.get('/', function (req, res) {
 //mstat = spawn('./mstats.sh', ['-w','workers']);
 //mstat.on('exit',function(code){
                                  // console.log("received get");
 fs.writeFile(mylockpath, "", function(err) {
                                  // console.log("write");
	 if(fs.existsSync(filepath)){
		var w= fs.watch(filedir, function(event, who) {
			 if (event === 'rename' && who === filename) {
			      if (!fs.existsSync(filepath)) {
		                      console.log("block deleted");
				res.sendFile("./monitor.html",{root:__dirname})
				w.close();
				try {
				fs.unlinkSync(mylockpath);
				} catch (err) {
  					//console.log("error handled");
				}
							//console.log("deleted_sent");
			      }
			    }
		  })
		
	}else{
		//console.log("no block");
		res.sendFile("./monitor.html",{root:__dirname})
try {
				fs.unlinkSync(mylockpath);
} catch (err) {
  					//console.log("error handled");
				}
		//console.log("deleted_sent");
	}
  });
 
});


app.listen(8484, function () {
  console.log('StatsMonitor runs on 8484 ');
});

