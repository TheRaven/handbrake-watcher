sys = require "sys"
exec = require('child_process').exec;
util = require "util"
path = require "path"
fs = require "fs"


log_filename = 'log.txt'
if !fs.existsSync(log_filename)
  fd = fs.openSync(log_filename, 'w');
  fs.close(fd)


watcher_config = require('config').watcher
handbrake_config = require('config').handbrake

chokidar = require 'chokidar'

watcher = chokidar.watch watcher_config.input_folder, persistent: true
watcher.on 'add', (file) ->
	
	output_filename = util.format("%s/%s", watcher_config.output_folder, path.basename(file))
	command = util.format handbrake_config.command, file, output_filename

	console.log "running command: %s", command + " 1> "+log_filename
	child = exec command+ " 1> "+log_filename, (error, stdout, stderr) ->
	  console.log "done"



jobwatcher = chokidar.watch "./"+log_filename, persistent: true

jobwatcher.on 'change', (file) ->
  content = fs.readFileSync file, encoding: "utf-8"
  process.stdout.clearLine()
  process.stdout.cursorTo 0
  process.stdout.write content

	