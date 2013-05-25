CONFIG = require('config').watcher

chokidar = require 'chokidar'

console.log "input Folder %s", CONFIG.input_folder


watcher = chokidar.watch CONFIG.input_folder, persistent: true

watcher.on 'add', (path) ->
	console.log('File', path, 'has been added');
